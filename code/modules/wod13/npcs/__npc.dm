#define BANDIT_TYPE_NPC /mob/living/carbon/human/npc/bandit
#define POLICE_TYPE_NPC /mob/living/carbon/human/npc/police

/mob/living/carbon/human/npc
	name = "Loh ebanii"

	// NPCs normally walk around slowly
	move_intent = MOVE_INTENT_WALK

	/// Until we do a full NPC refactor (see: rewriting every single bit of code)
	/// use this to determine NPC weapons and their chances to spawn with them -- assuming you want the NPC to do that
	/// Otherwise just set it under the NPC's type as
	/// my_weapon = type_path
	/// my_backup_weapon = type_path
	/// This only determines my_weapon, you set my_backup_weapon yourself
	/// The last entry in the list for a type of NPC should always have 100 as the index
	var/static/list/role_weapons_chances = list(
		BANDIT_TYPE_NPC = list(
			/obj/item/gun/ballistic/automatic/vampire/deagle = 33,
			/obj/item/gun/ballistic/vampire/revolver/snub = 33,
			/obj/item/melee/vampirearms/baseball = 100,
		),
		POLICE_TYPE_NPC = list(
			/obj/item/gun/ballistic/vampire/revolver = 66,
			/obj/item/gun/ballistic/automatic/vampire/ar15 = 100,
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
	var/obj/effect/fire/afraid_of_fire
	var/mob/living/last_attacker
	var/last_health = 100
	var/mob/living/last_damager

	var/turf/walktarget	//dlya movementa

	var/last_grab = 0

	var/tupik_steps = 0
	var/tupik_loc

	var/stopturf = 1

	var/extra_mags=2
	var/extra_loaded_rounds=10

	var/has_weapon = FALSE

	var/my_weapon_type = null
	var/obj/item/my_weapon = null

	var/my_backup_weapon_type = null
	var/obj/item/my_backup_weapon = null

	var/spawned_weapon = FALSE

	var/spawned_backup_weapon = FALSE

	var/ghoulificated = FALSE

	var/staying = FALSE

	var/lifespan = 0	//How many cycles. He'll be deleted if over than a ten thousand
	var/old_movement = FALSE
	var/max_stat = 2

	var/list/spotted_bodies = list()

	var/is_criminal = FALSE

	var/list/drop_on_death_list = null

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()

	GLOB.npc_list += src
	GLOB.alive_npc_list += src

	return INITIALIZE_HINT_LATELOAD

/mob/living/carbon/human/npc/LateInitialize(mapload)
	. = ..()

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
	GLOB.npc_list -= src
	GLOB.alive_npc_list -= src
	SShumannpcpool.npclost()

	. = ..()

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

//If an npc's item has TRAIT_NODROP, we NEVER drop it, even if it is forced.
/mob/living/carbon/human/npc/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if (I && HAS_TRAIT(I, TRAIT_NODROP))
		return FALSE

	. = ..()
//============================================================

/mob/living/carbon/human/npc/proc/realistic_say(message)
	GLOB.move_manager.stop_looping(src, SShumannpcpool)

	if (!message)
		return
	if (stat >= HARD_CRIT)
		return
	if (is_talking)
		return
	is_talking = TRUE

	addtimer(CALLBACK(src, PROC_REF(start_talking), message), 0.5 SECONDS)

/mob/living/carbon/human/npc/proc/start_talking(message)
	if (is_talking)
		return

	create_typing_indicator()
	var/typing_delay = round(length_char(message) * 0.5)
	addtimer(CALLBACK(src, PROC_REF(finish_talking), message), max(0.1 SECONDS, typing_delay))

/mob/living/carbon/human/npc/proc/finish_talking(message)
	remove_typing_indicator()
	say(message)
	is_talking = FALSE

/mob/living/carbon/human/npc/proc/Annoy(atom/source)
	GLOB.move_manager.stop_looping(src, SShumannpcpool)

	if (!can_npc_move())
		return
	if (danger_source)
		return

	if (!COOLDOWN_FINISHED(src, annoyed_cooldown))
		return
	COOLDOWN_START(src, annoyed_cooldown, 5 SECONDS)

	if(source)
		addtimer(CALLBACK(src, PROC_REF(face_atom), source), rand(0.3 SECONDS, 0.7 SECONDS))

	var/phrase
	if (prob(50))
		phrase = pick(socialrole.neutral_phrases)
	else
		if (gender == MALE)
			phrase = pick(socialrole.male_phrases)
		else
			phrase = pick(socialrole.female_phrases)
	realistic_say(phrase)

/mob/living/carbon/human/Bump(atom/Obstacle)
	. = ..()
	var/mob/living/carbon/human/npc/NPC = locate() in get_turf(Obstacle)
	if(NPC)
		if(a_intent != INTENT_HELP)
			NPC.Annoy(src)

/mob/living/carbon/Move(NewLoc, direct)
	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		H.update_shadow()

	if (HAS_TRAIT(src, TRAIT_RUBICON))
		if(istype(NewLoc, /turf/open/floor/plating/shit))
			return

	. = ..()

/mob/living/carbon/human/npc/Move(NewLoc, direct)
	if (!can_npc_move())
		GLOB.move_manager.stop_looping(src, SShumannpcpool)
	var/getaway = stopturf + 1
	if (!old_movement)
		getaway = 2
	if (get_dist(src, walktarget) <= getaway)
		GLOB.move_manager.stop_looping(src, SShumannpcpool)
		walktarget = null

	. = ..()

// TODO: [Lucia] split this into registered signals
/mob/living/carbon/human/npc/attack_hand(mob/user, list/modifiers)
	if (!isliving(user))
		return
	var/mob/living/hit_by = user

	if (hit_by.combat_mode == FALSE)
		Annoy(user)
	else
		for(var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
			NEPIC.Aggro(user)
		Aggro(user, TRUE)

	if (hit_by.combat_mode == INTENT_DISARM)
		Aggro(user, TRUE)

	. = ..()

/mob/living/carbon/human/npc/on_hit(obj/projectile/P)
	. = ..()

	if (!P?.firer)
		return

	for (var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
		NEPIC.Aggro(P.firer)

	Aggro(P.firer, TRUE)
	var/witness_count

	for (var/mob/living/carbon/human/npc/NEPIC in viewers(7, usr))
		if (NEPIC?.stat != DEAD)
			witness_count++
		if (witness_count > 1)
			for (var/obj/item/police_radio/radio in GLOB.police_radios)
				radio.announce_crime("victim", get_turf(src))
			for (var/obj/machinery/p25transceiver/police/radio in GLOB.p25_tranceivers)
				if (radio.p25_network == "police")
					radio.announce_crime("victim", get_turf(src))
					break

/mob/living/carbon/human/npc/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	. = ..()
	if(throwingdatum?.thrower && (AM.throwforce > 5 || (AM.throwforce && src.health < src.maxHealth)))
		Aggro(throwingdatum.thrower, TRUE)

/mob/living/carbon/human/npc/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if (!user)
		return
	if (!W.force || ((W.force <= 5) && (health >= maxHealth)))
		return

	for (var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
		NEPIC.Aggro(user)
	Aggro(user, TRUE)

/mob/living/carbon/human/npc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	. = ..()

	last_grab = world.time

// TODO: [Lucia] reimplement ghouls
/*
/mob/living/carbon/human/npc/proc/ghoulificate(mob/owner)
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as [owner]`s ghoul?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, "<span class='ghostalert'>[owner] is ghoulificating [src].</span>")
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		key = C.key
		ghoulificated = TRUE
		set_species(/datum/species/ghoul)
		if(mind)
			if(mind.enslaved_to != owner)
				mind.enslave_mind_to_creator(owner)
				to_chat(src, "<span class='userdanger'><b>AS PRECIOUS VITAE ENTER YOUR MOUTH, YOU NOW ARE IN THE BLOODBOND OF [owner]. SERVE YOUR REGNANT CORRECTLY, OR YOUR ACTIONS WILL NOT BE TOLERATED.</b></span>")
				return TRUE
	return FALSE
*/
