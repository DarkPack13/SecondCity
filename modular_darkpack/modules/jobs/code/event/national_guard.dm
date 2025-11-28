/datum/outfit/job/vampire/national_guard
	name = "National Guard Soldier"
	//ears = /obj/item/p25radio/police/government
	uniform = /obj/item/clothing/under/vampire/military_fatigues
	mask = /obj/item/clothing/mask/vampire/balaclava
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/ammo_box/magazine/darkpackaug
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/gun/ballistic/automatic/darkpack/aug
	suit = /obj/item/clothing/suit/vampire/vest/army
	head = /obj/item/clothing/head/vampire/army
	backpack_contents = list(
		/obj/item/ammo_box/magazine/darkpackaug = 3,
		/obj/item/radio = 1,
		/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta = 1
		)

/datum/antagonist/national_guard/proc/equip_national_guard()
	var/mob/living/carbon/human/H = owner.current
	if(!ishuman(owner.current))
		return
	H.equipOutfit(national_guard_outfit)
	H.set_species(/datum/species/human)
	H.set_clan(null)
	H.generation = 13
	H.st_set_stat(5, STAT_STAMINA)
	H.st_set_stat(5, STAT_LARCENY)
	H.st_set_stat(4, STAT_STRENGTH)
	H.recalculate_max_health(TRUE)

	for(var/datum/action/A in H.actions)
		if(A.vampiric)
			A.Remove(H)
	REMOVE_TRAIT(H, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	var/obj/item/organ/eyes/NV = new()
	NV.Insert(H, TRUE, FALSE)

	var/list/landmarkslist = list()
	for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
		if(S.name == name)
			landmarkslist += S
	var/obj/effect/landmark/start/D = pick(landmarkslist)
	H.forceMove(D.loc)

/datum/antagonist/national_guard/proc/offer_loadout()
	var/list/loadouts = list(
		"Flamethrower",
		"EOD",
		"Medic",
		"Sniper",
		"Ammo Carrier"
	)
	var/loadout_type = input(owner.current, "Choose your loadout:", "Loadout Selection") in loadouts
	switch(loadout_type)
		if("Flamethrower")
			owner.current.put_in_r_hand(new /obj/item/liquid_flamethrower(owner.current))
			owner.current.put_in_l_hand(new /obj/item/gas_can/full(owner.current))
		if("EOD")
			owner.current.put_in_r_hand(new /obj/item/clothing/suit/vampire/eod(owner.current))
			owner.current.put_in_l_hand(new /obj/item/clothing/head/vampire/eod(owner.current))
		if("Medic")
			owner.current.put_in_r_hand(new /obj/item/storage/medkit/darkpack/combat(owner.current))
		if("Sniper")
			owner.current.put_in_r_hand(new /obj/item/gun/ballistic/automatic/darkpack/sniper(owner.current))
			owner.current.put_in_l_hand(new /obj/item/ammo_box/darkpack/c556(owner.current))
		if("Ammo Carrier")
			owner.current.put_in_r_hand(new /obj/item/ammo_box/darkpack/c556/incendiary(owner.current))
			owner.current.put_in_l_hand(new /obj/item/ammo_box/darkpack/c556/incendiary(owner.current))

/datum/antagonist/national_guard
	name = "National Guard"
	roundend_category = "national guard"
	antagpanel_category = "National Guard"
	pref_flag = ROLE_NATIONAL_GUARD
	antag_hud_name = "synd"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	var/always_new_team = FALSE
	var/datum/team/national_guard/national_guard_team
	var/national_guard_outfit = /datum/outfit/job/vampire/national_guard
	var/custom_objective

/datum/antagonist/national_guard/sergeant
	name = "National Guard Sergeant"
	always_new_team = TRUE
	var/title

/datum/antagonist/national_guard/on_gain()
	var/mob/living/carbon/human/guard_character = owner.current
	guard_character.randomize_human_appearance()
	forge_objectives()
	equip_national_guard()
	give_alias()
	offer_loadout()
	return ..()

/datum/antagonist/national_guard/on_removal()
	..()
	to_chat(owner.current, span_userdanger("You are no longer in the National Guard!"))

/datum/antagonist/national_guard/greet()
	to_chat(owner.current, span_alertsyndie("You're in the national guard."))
	to_chat(owner, span_notice("You are a [national_guard_team ? national_guard_team.national_guard_name : "national guard"] soldier!"))
	owner.announce_objectives()


/datum/antagonist/national_guard/proc/give_alias()
	var/my_name = "Tyler"
	var/list/military_ranks = list("Private", "Private First Class", "Specialist", "Corporal")
	var/selected_rank = pick(military_ranks)
	if(owner.current.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	owner.current.fully_replace_character_name(null,"[selected_rank] [my_name] [my_surname]")

/datum/antagonist/national_guard/forge_objectives()
	spawn(2 SECONDS)
	if(national_guard_team)
		objectives |= national_guard_team.objectives

/datum/antagonist/national_guard/sergeant/give_alias()
	var/my_name = "Tyler"
	if(owner.current.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	owner.current.fully_replace_character_name(null,"Sergeant [my_name] [my_surname]")

/datum/team/national_guard/antag_listing_name()
	if(national_guard_name)
		return "[national_guard_name] Soldiers"
	else
		return "Soldiers"


/datum/antagonist/national_guard/sergeant/greet()
	to_chat(owner, "<B>You are the leading sergeant for this mission. You are responsible for guiding your team's operation.</B>")
	to_chat(owner, "<B>If you feel you are not up to this task, give your command to another soldier.</B>")
	owner.announce_objectives()
	addtimer(CALLBACK(src, PROC_REF(national_guardteam_name_assign)), 1)

/datum/antagonist/national_guard/sergeant/proc/national_guardteam_name_assign()
	if(!national_guard_team)
		return
	national_guard_team.rename_team(ask_name())

/datum/antagonist/national_guard/sergeant/proc/ask_name()
	var/randomname = pick(GLOB.last_names)
	var/newname = stripped_input(owner.current,"You are the sergeant. Please choose a name for your team.", "Name change",randomname)
	if (!newname)
		newname = randomname
	else
		newname = reject_bad_name(newname)
		if(!newname)
			newname = randomname

/datum/antagonist/national_guard/create_team(datum/team/national_guard/new_team)
	if(!new_team)
		if(!always_new_team)
			for(var/datum/antagonist/national_guard/N in GLOB.antagonists)
				if(!N.owner)
					stack_trace("Antagonist datum without owner in GLOB.antagonists: [N]")
					continue
		national_guard_team = new /datum/team/national_guard
		national_guard_team.update_objectives()
		return
	if(!istype(national_guard_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	national_guard_team = new_team

/datum/antagonist/national_guard/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_NATIONAL_GUARD
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has national guard'd [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has national guard'd [key_name(new_owner)].")

/datum/team/national_guard/proc/rename_team(new_name)
	national_guard_name = new_name
	name = "[national_guard_name] Team"

/datum/objective/national_guard
	name = "national_guard"
	explanation_text = "Follow the orders of your sergeant."
	martyr_compatible = TRUE

/proc/national_guard_name()
	var/name = ""

	// Prefix
	name += pick("Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-ray", "Yankee", "Zulu")

	// Suffix
	if	(prob(80))
		name += " "

		// Full
		if(prob(60))
			name += pick("Squad", "Team", "Unit", "Group", "Section", "Element", "Detachment")
		// Broken
		else
			name += pick("-", "*", "")
			name += "Ops"

/datum/team/national_guard
	var/national_guard_name
	var/core_objective = /datum/objective/national_guard
	member_name = "National Guard Operative"
	var/memorized_code
	var/list/team_discounts
	var/obj/item/nuclear_challenge/war_button

/datum/team/national_guard/New()
	..()
	national_guard_name = national_guard_name()

/datum/team/national_guard/proc/update_objectives()
	if(core_objective)
		var/datum/objective/O = new core_objective
		O.team = src
		objectives += O

/datum/team/national_guard/roundend_report()
	var/list/parts = list()
	parts += span_header("[national_guard_name] Operatives:")

	var/text = "<br>[span_header("The national guard were:")]"
	text += printplayerlist(members)
	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
