#define BANDIT_TYPE_NPC /mob/living/carbon/human/npc/bandit
#define POLICE_TYPE_NPC /mob/living/carbon/human/npc/police

/mob/living/carbon/human/npc
	name = "NPC"

	// NPCs normally walk around slowly
	move_intent = MOVE_INTENT_WALK

	// NPC humans get the area of effect, player humans dont.
	violation_aoe = TRUE

	/// Until we do a full NPC refactor (see: rewriting every single bit of code)
	/// use this to determine NPC weapons and their chances to spawn with them -- assuming you want the NPC to do that
	/// Otherwise just set it under the NPC's type as
	/// my_weapon = type_path
	/// my_backup_weapon = type_path
	/// This only determines my_weapon, you set my_backup_weapon yourself
	/// The last entry in the list for a type of NPC should always have 100 as the index
	var/static/list/role_weapons_chances = list(
		BANDIT_TYPE_NPC = list(
			/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle = 33,
			/obj/item/gun/ballistic/revolver/darkpack/snub = 33,
			/obj/item/melee/baseball_bat/vamp = 100,
		),
		POLICE_TYPE_NPC = list(
			/obj/item/gun/ballistic/revolver/darkpack/magnum = 66,
			/obj/item/gun/ballistic/automatic/darkpack/ar15 = 100,
		)
	)
	var/datum/socialrole/socialrole

	var/is_talking = FALSE
	COOLDOWN_DECLARE(annoyed_cooldown)
	COOLDOWN_DECLARE(car_dodge)
	var/hostile = FALSE
	var/aggressive = FALSE
	var/last_antagonised = 0
	var/mob/living/danger_source
	var/obj/effect/abstract/turf_fire/afraid_of_fire
	var/mob/living/last_attacker
	var/last_health = 100
	var/mob/living/last_damager

	var/turf/walktarget	//dlya movementa

	var/last_grab = 0

	var/tupik_steps = 0
	var/tupik_loc

	var/stopturf = 1

	var/extra_mags = 2
	var/extra_loaded_rounds = 10

	var/has_weapon = FALSE

	var/my_weapon_type = null
	var/obj/item/my_weapon = null

	var/my_backup_weapon_type = null
	var/obj/item/my_backup_weapon = null

	var/spawned_weapon = FALSE

	var/spawned_backup_weapon = FALSE

	var/staying = FALSE

	var/lifespan = 0	//How many cycles. He'll be deleted if over than a ten thousand
	var/old_movement = FALSE

	var/list/spotted_bodies = list()

	var/is_criminal = FALSE

	var/list/drop_on_death_list = null

	// NPC 911 reporting phrases
	COOLDOWN_DECLARE(call_911_cooldown)
	var/static/list/open_carrying_phrases = list(
		"Is that...?!",
		"Are you carrying a weapon?!",
		"Oh my god, are you carrying a weapon?",
		"Someone needs to call the police, that's crazy.",
		"Just rob a bank or something?",
		"That's illegal, you know.",
		"Open carrying a weapon in 2016 is crazy.",
		"That's a crime, you know.",
		"You should put that weapon away.",
		"Are you crazy? You can't just carry a weapon around like that.",
		"This is California, psycho. Put the weapon away.",
		"In what world is it okay to open carry a weapon like that? Put it away.",
		"It's 2016, not 1816.",
		"The cops are going to shoot you, dude.",
		"Crazy. You should put that away before you get shot.",
		"Holy crap, someone call the cops! That psycho has a weapon!"
	)

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()

	GLOB.npc_list += src
	GLOB.alive_npc_list += src

	AddElement(/datum/element/relay_attackers)
	RegisterSignal(src, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(handle_attacked))

	// Annoy the NPC when pushed around
	RegisterSignal(src, COMSIG_LIVING_MOB_BUMPED, PROC_REF(handle_bumped))
	// Be annoyed if helped
	RegisterSignal(src, COMSIG_CARBON_HELP_ACT, PROC_REF(handle_helped))
	return INITIALIZE_HINT_LATELOAD

/mob/living/carbon/human/npc/LateInitialize(mapload)
	if (role_weapons_chances.Find(type))
		for(var/weapon in role_weapons_chances[type])
			if(prob(role_weapons_chances[type][weapon]))
				my_weapon = new weapon(src)
				break

	if (!my_weapon && my_weapon_type)
		my_weapon = new my_weapon_type(src)

	if (my_weapon)
		has_weapon = TRUE
		equip_to_appropriate_slot(my_weapon)
		if(istype(my_weapon, /obj/item/gun/ballistic))
			RegisterSignal(my_weapon, COMSIG_GUN_FIRED, PROC_REF(handle_gun))
			RegisterSignal(my_weapon, COMSIG_GUN_EMPTY, PROC_REF(handle_empty_gun))
		register_sticky_item(my_weapon)

	if (my_backup_weapon_type)
		my_backup_weapon = new my_backup_weapon_type(src)
		equip_to_appropriate_slot(my_backup_weapon)
		register_sticky_item(my_backup_weapon)

/mob/living/carbon/human/npc/Destroy()
	UnregisterSignal(src, list(COMSIG_ATOM_WAS_ATTACKED, COMSIG_LIVING_MOB_BUMPED, COMSIG_CARBON_HELP_ACT))
	danger_source = null
	QDEL_NULL(afraid_of_fire)
	last_attacker = null
	last_damager = null
	walktarget = null
	tupik_loc = null
	my_weapon_type = null
	my_weapon = null
	my_backup_weapon_type = null
	my_backup_weapon = null
	spotted_bodies = null
	drop_on_death_list = null
	GLOB.npc_list -= src
	GLOB.alive_npc_list -= src
	SShumannpcpool.currentrun -= src
	SShumannpcpool.try_repopulate()
	return ..()

//====================Sticky Item Handling====================
/mob/living/carbon/human/npc/proc/register_sticky_item(obj/item/my_item)
	ADD_TRAIT(my_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
	if(!drop_on_death_list?.len)
		drop_on_death_list = list()
	drop_on_death_list += my_item

/mob/living/carbon/human/npc/death(gibbed)
	. = ..()

	if (!LAZYLEN(drop_on_death_list))
		return

	for (var/obj/item/dropping_item in drop_on_death_list)
		LAZYREMOVE(drop_on_death_list, dropping_item)
		REMOVE_TRAIT(dropping_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
		dropItemToGround(dropping_item, TRUE)

//============================================================

/mob/living/carbon/human/npc/proc/realistic_say(message)
	GLOB.move_manager.stop_looping(src)

	if (!message)
		return
	if (stat >= HARD_CRIT)
		return
	if (is_talking)
		return
	is_talking = TRUE

	addtimer(CALLBACK(src, PROC_REF(start_talking), message), 1 SECONDS)

/mob/living/carbon/human/npc/proc/start_talking(message)
	ADD_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	create_typing_indicator()
	var/typing_delay = round(length_char(message) * 0.5)
	addtimer(CALLBACK(src, PROC_REF(finish_talking), message), max(3 SECONDS, typing_delay))

/mob/living/carbon/human/npc/proc/finish_talking(message)
	remove_typing_indicator()
	REMOVE_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	say(message)
	is_talking = FALSE

/mob/living/carbon/human/npc/proc/Annoy(atom/source)
	GLOB.move_manager.stop_looping(src)

	if (!can_npc_move())
		return
	if (danger_source)
		return

	if (!COOLDOWN_FINISHED(src, annoyed_cooldown))
		return
	COOLDOWN_START(src, annoyed_cooldown, 5 SECONDS)

	if(source)
		addtimer(CALLBACK(src, PROC_REF(face_atom), source), rand(0.3 SECONDS, 0.7 SECONDS))

	var/phrase = "Wow."
	if (prob(50))
		phrase = pick(socialrole?.neutral_phrases)
	else
		if (gender == MALE)
			phrase = pick(socialrole?.male_phrases)
		else
			phrase = pick(socialrole?.female_phrases)
	realistic_say(phrase)

/mob/living/carbon/human/npc/proc/handle_attacked(datum/source, atom/attacker, attack_flags)
	// Only aggro nearby npcs if its lethal.
	if(!(attack_flags & (ATTACKER_STAMINA_ATTACK|ATTACKER_SHOVING)))
		for(var/mob/living/carbon/human/npc/nearby_npcs in oviewers(DEFAULT_SIGHT_DISTANCE, src))
			nearby_npcs.Aggro(attacker)
		SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_FIREFIGHT, get_turf(src))
	Aggro(attacker, TRUE)

/mob/living/carbon/human/npc/proc/handle_bumped(mob/living/carbon/human/npc/source, mob/living/bumping)
	SIGNAL_HANDLER

	if (bumping.can_mobswap_with(source) && prob(25))
		return

	source.Annoy(bumping)

/mob/living/carbon/human/npc/proc/handle_helped(mob/living/carbon/human/npc/source, mob/living/helper)
	SIGNAL_HANDLER

	source.Annoy(helper)

/mob/living/carbon/human/npc/Move(NewLoc, direct)
	if (!can_npc_move())
		GLOB.move_manager.stop_looping(src)

	var/getaway = stopturf + 1

	if (!old_movement)
		getaway = 2

	if (get_dist(src, walktarget) <= getaway)
		GLOB.move_manager.stop_looping(src)
		walktarget = null

	. = ..()

/mob/living/carbon/human/npc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	. = ..()

	last_grab = world.time

/mob/living/carbon/human/npc/ghoulificate(mob/owner)
	deadchat_broadcast(span_ghostalert("[owner] is ghoulificating [src]."), owner, src)

	AddComponent(\
		/datum/component/ghost_direct_control,\
		ban_type = ROLE_GHOUL,\
		poll_candidates = TRUE,\
		role_name = "[owner]'s ghoul",\
		poll_length = 30 SECONDS,\
		poll_question = "Do you want to play as [owner]'s ghoul?",\

		assumed_control_message = "You are now [owner]'s ghoul!",\
		after_assumed_control = CALLBACK(src, PROC_REF(ghoul_player_controlled), owner)\
	)

	//poll_ignore_key = POLL_IGNORE_GHOUL,

	. = ..()
	return TRUE

/mob/living/carbon/human/npc/proc/ghoul_player_controlled(mob/owner)
	message_admins("[key_name_admin(src)] has became a ghoul by [key_name_admin(owner)].")


// Crime report handling
/mob/living/carbon/human/npc/handle_attacked(datum/source, atom/attacker, attack_flags)
	if(attack_flags & (ATTACKER_STAMINA_ATTACK|ATTACKER_SHOVING))
		return
	for(var/mob/living/carbon/human/npc/nearby_npcs in oviewers(DEFAULT_SIGHT_DISTANCE, src))
		nearby_npcs.Aggro(attacker)
	Aggro(attacker, TRUE)

/mob/living/carbon/human/npc/Aggro(mob/living/victim, attacked = FALSE)
	. = ..()
	if(attacked)
		return
	if(aggressive)
		return
	INVOKE_ASYNC(src, PROC_REF(call_911), victim)

/mob/living/carbon/human/npc/proc/call_911(atom/attacker, open_carrying = FALSE)
	if(!COOLDOWN_FINISHED(src, call_911_cooldown))
		return
	var/area/vtm/crime_area = astype(get_area(src))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE)
		return
	if(prob(20)) // some RNG to if they call or not
		return
	if(!istype(l_store, /obj/item/smartphone) && !istype(r_store, /obj/item/smartphone))
		return
	if(HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_RESTRAINED) || staying)
		return
	var/turf/crime_turf = get_turf(src)
	var/crime = CRIME_BATTERY
	var/clothing_desc = null
	if(istype(attacker, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = attacker
		if(istype(H.get_active_held_item(), /obj/item/gun) || istype(H.get_inactive_held_item(), /obj/item/gun))
			crime = CRIME_FIREFIGHT
		if(open_carrying)
			crime = CRIME_OPEN_CARRYING
		var/list/worn = list()
		if(H.head) worn += H.head
		if(H.wear_suit) worn += H.wear_suit
		if(H.w_uniform) worn += H.w_uniform
		if(H.shoes) worn += H.shoes
		if(length(worn))
			clothing_desc = pick(worn):name
	GLOB.move_manager.stop_looping(src)
	var/saved_danger = danger_source
	danger_source = null
	manual_emote("takes out [p_their()] phone and starts dialing 911!")
	staying = TRUE
	if(!do_after(src, 5 SECONDS, target = src, cog_icon = 'modular_darkpack/modules/phones/icons/phone.dmi', cog_iconstate = "phone"))
		staying = FALSE
		if(saved_danger)
			danger_source = saved_danger
		return
	if(clothing_desc)
		realistic_say("[pick("Police!", "Hello, police?!")] [pick(pick(socialrole.help_phrases), "Wearing [clothing_desc]!")]")
	else
		realistic_say("[pick("Police!", "Hello, police?!")] [pick(socialrole.help_phrases)]")
	var/mob/living/carbon/human/H = astype(attacker, /mob/living/carbon/human)
	if(H)
		H.witnessed_crimes += 1
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, remove_crime_stack)), 1 MINUTES)
		if(H.witnessed_crimes >= 10 && !H.warrant)
			H.warrant = TRUE
			SEND_SOUND(H, sound('modular_darkpack/modules/deprecated/sounds/suspect.ogg', volume = 75))
			to_chat(H, span_userdanger("<b>ALL-POINTS BULLETIN ISSUED!</b>"))
			to_chat(H, span_warning("The police are now able to track you down and will pursue you on sight. Lay low for a while and they will eventually stop looking for you."))
		else if(!H.warrant)
			SEND_SOUND(H, sound('modular_darkpack/modules/deprecated/sounds/sus.ogg', volume = 75))
			to_chat(H, span_userdanger("<b>SUSPICIOUS ACTION ([crime])</b>"))
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, crime, crime_turf, clothing_desc)
	staying = FALSE

/obj/item/proc/is_scary_weapon() // NPCs don't like seeing scary weapons
	if(istype(src, /obj/item/instrument))
		return FALSE
	if(force > 20)
		return TRUE
	var/obj/item/storage/belt/sheath/sword_sheath = astype(src, /obj/item/storage/belt/sheath)
	var/obj/item/gun/ballistic/gun = astype(src, /obj/item/gun/ballistic)
	if(sword_sheath)
		return !isnull(sword_sheath.stored_blade)
	if(gun)
		return !isnull(gun.serial_type) // we check for a serial number so NPCs dont freak out over donksoft foam guns
	return FALSE

/datum/proximity_monitor/advanced/violation_check_aoe/proc/check_criminal_violation(mob/living/carbon/human/entered_mob)
	var/threatcount = 0
	var/datum/job/entered_job = SSjob.get_job(entered_mob?.job)
	if(entered_job?.departments_bitflags & DEPARTMENT_BITFLAG_POLICE)
		return 0 // dont call 911 on the police
	for(var/obj/item/thing in entered_mob?.held_items) //they're holding it!
		if(thing.is_scary_weapon())
			threatcount += 11 // 11 so that if they have 5 charisma and 5 intimidation, they still have a tiny chance of getting snitched on
	if(entered_mob?.belt?.is_scary_weapon() || entered_mob?.back?.is_scary_weapon())
		threatcount += 5 //not an immediate threat, but still a threat
	return threatcount

/datum/proximity_monitor/advanced/violation_check_aoe/on_entered(turf/source, atom/movable/entered, turf/old_loc)
	. = ..()
	var/mob/living/carbon/human/entered_mob = astype(entered, /mob/living/carbon/human)
	var/mob/living/carbon/human/npc/host_mob = astype(host, /mob/living/carbon/human/npc)
	if(!entered_mob || !host_mob || !entered_mob.client || istype(entered_mob, /mob/living/carbon/human/npc))
		return
	var/severity = check_criminal_violation(entered_mob)
	if(!severity)
		return
	var/call_chance = severity - (entered_mob.st_get_stat(STAT_CHARISMA) + entered_mob.st_get_stat(STAT_INTIMIDATION))
	if(prob(call_chance))
		INVOKE_ASYNC(host_mob, TYPE_PROC_REF(/mob/living/carbon/human/npc, call_911), entered_mob, open_carrying = TRUE)
		return // if they call, dont yap after
	if(prob(1)) // if they don't call, the npc might just yap
		host_mob.point_at(entered_mob)
		host_mob.realistic_say(pick(host_mob.open_carrying_phrases))

/mob/living/carbon/human/proc/remove_crime_stack()
	if(QDELETED(src))
		return
	witnessed_crimes = max(0, witnessed_crimes - 1) // each witnessed crime stack lasts 1 minute. police pursue them after 10 stacks.
	if(!warrant)
		return
	if(witnessed_crimes == 0)
		to_chat(src, span_info("(APB) The police call off their search for you. You are no longer wanted."))
		warrant = FALSE
