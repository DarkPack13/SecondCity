/datum/outfit/job/swat
	name = "Swat Officer"
	//ears = /obj/item/p25radio/police/tactical
	uniform = /obj/item/clothing/under/vampire/police/utility
	mask = /obj/item/clothing/mask/vampire/balaclava
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/vamp/keys/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/gun/ballistic/automatic/darkpack/ar15
	suit = /obj/item/clothing/suit/vampire/vest/police
	head = /obj/item/clothing/head/vampire/helmet
	id = /obj/item/card/police
	backpack_contents = list(
		/obj/item/ammo_box/magazine/darkpack556 = 4,
		///obj/item/radio/cop = 1,
		/obj/item/storage/medkit/darkpack/ifak = 1,
		/obj/item/vamp/keys/hack=2
		)

/datum/antagonist/swat/proc/equip_swat()
	var/mob/living/carbon/human/H = owner.current
	if(!ishuman(owner.current))
		return
	H.equipOutfit(swat_outfit)
	H.set_species(/datum/species/human)
	H.set_clan(null)
	H.generation = 13
	H.st_set_stat(5, STAT_LARCENY)
	H.st_set_stat(4, STAT_STRENGTH)
	H.ignores_warrant = TRUE

	for(var/datum/action/A in H.actions)
		if(A.vampiric)
			A.Remove(H)
	H.thaumaturgy_knowledge = FALSE
	var/obj/item/organ/eyes/NV = new()
	NV.Insert(H, TRUE, FALSE)

	var/list/landmarkslist = list()
	for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
		if(S.name == name)
			landmarkslist += S
	var/obj/effect/landmark/start/D = pick(landmarkslist)
	H.forceMove(D.loc)

/obj/effect/landmark/start/swat
	name = "Swat Officer"
	delete_after_roundstart = FALSE

/datum/antagonist/swat
	name = "Swat Officer"
	roundend_category = "Swat"
	antagpanel_category = "Swat"
	pref_flag = ROLE_SWAT
	antag_hud_name = "synd"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	var/always_new_team = FALSE
	var/datum/team/swat/swat_team
	var/swat_outfit = /datum/outfit/job/swat
	var/custom_objective

/datum/antagonist/swat/team_leader
	name = "Swat Team Leader"
	always_new_team = TRUE
	var/title

/datum/antagonist/swat/on_gain()
	randomize_appearance()
	forge_objectives()
	equip_swat()
	give_alias()
	return ..()

/datum/antagonist/swat/on_removal()
	..()
	to_chat(owner.current,span_userdanger("You are no longer in the Special Weapons and Tactics squad!"))

/datum/antagonist/swat/greet()
	to_chat(owner.current, span_alertsyndie("You're in the Special Weapons and Tactics squad."))
	to_chat(owner, span_notice("You are a [swat_team ? swat_team.swat_name : "swat"] officer!"))
	spawn(3 SECONDS)
	owner.announce_objectives()


/datum/antagonist/swat/proc/give_alias()
	var/my_name = "Tyler"
	var/list/swat_ranks = list("Private", "Private First Class", "Lance Corporal", "Corporal")
	var/selected_rank = pick(swat_ranks)
	if(owner.current.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	owner.current.fully_replace_character_name(null,"[selected_rank] [my_name] [my_surname]")

/datum/antagonist/swat/forge_objectives()
	spawn(2 SECONDS)
	if(swat_team)
		objectives |= swat_team.objectives

/datum/antagonist/swat/leader/give_alias()
	var/my_name = "Tyler"
	if(owner.current.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	owner.current.fully_replace_character_name(null,"Squad Leader [my_name] [my_surname]")

/datum/team/swat/antag_listing_name()
	if(swat_name)
		return "[swat_name] Officers"
	else
		return "Officers"


/datum/antagonist/swat/leader/greet()
	to_chat(owner, "<B>You are the SWAT Officer in charge of this mission. You are responsible for guiding your team's operation.</B>")
	to_chat(owner, "<B>If you feel you are not up to this task, give your command to another officer.</B>")
	spawn(3 SECONDS)
	owner.announce_objectives()
	addtimer(CALLBACK(src, PROC_REF(swatteam_name_assign)), 1)

/datum/antagonist/swat/leader/proc/swatteam_name_assign()
	if(!swat_team)
		return
	swat_team.rename_team(ask_name())

/datum/antagonist/swat/leader/proc/ask_name()
	var/randomname = pick(GLOB.last_names)
	var/newname = stripped_input(owner.current,"You are the squa leader. Please choose a name for your team.", "Name change",randomname)
	if (!newname)
		newname = randomname
	else
		newname = reject_bad_name(newname)
		if(!newname)
			newname = randomname

/datum/antagonist/swat/create_team(datum/team/swat/new_team)
	if(!new_team)
		if(!always_new_team)
			for(var/datum/antagonist/swat/N in GLOB.antagonists)
				if(!N.owner)
					stack_trace("Antagonist datum without owner in GLOB.antagonists: [N]")
					continue
		swat_team = new /datum/team/swat
		swat_team.update_objectives()
		return
	if(!istype(swat_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	swat_team = new_team

/datum/antagonist/swat/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_SWAT
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has swat'd [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has swat'd [key_name(new_owner)].")

/datum/random_gen/swat
	var/hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue

	var/male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")

	var/male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns")

	var/female_hair = list("Ahoge",
										"Long Bedhead",
										"Beehive",
										"Beehive 2",
										"Bob Hair",
										"Bob Hair 2",
										"Bob Hair 3",
										"Bob Hair 4",
										"Bobcurl",
										"Braided",
										"Braided Front",
										"Braid (Short)",
										"Braid (Low)",
										"Bun Head",
										"Bun Head 2",
										"Bun Head 3",
										"Bun (Large)",
										"Bun (Tight)",
										"Double Bun",
										"Emo",
										"Emo Fringe",
										"Feather",
										"Gentle",
										"Long Hair 1",
										"Long Hair 2",
										"Long Hair 3",
										"Long Over Eye",
										"Long Emo",
										"Long Fringe",
										"Ponytail",
										"Ponytail 2",
										"Ponytail 3",
										"Ponytail 4",
										"Ponytail 5",
										"Ponytail 6",
										"Ponytail 7",
										"Ponytail (High)",
										"Ponytail (Short)",
										"Ponytail (Long)",
										"Ponytail (Country)",
										"Ponytail (Fringe)",
										"Poofy",
										"Short Hair Rosa",
										"Shoulder-length Hair",
										"Volaju")

/datum/antagonist/swat/proc/randomize_appearance()
	var/datum/random_gen/swat/h_gen = new
	var/mob/living/carbon/human/H = owner.current

	H.name = H.real_name
	H.dna.real_name = H.real_name
	H.gender = pick(MALE, FEMALE)
	H.physique = H.gender
	H.age = rand(18, 36)

	H.set_haircolor(pick(h_gen.hair_colors))
	H.set_facial_haircolor(H.hair_color)
	if(H.gender == MALE)
		H.set_hairstyle(pick(h_gen.male_hair))
		if(prob(25) || H.age >= 25)
			H.set_facial_hairstyle(pick(h_gen.male_facial))
		else
			H.set_facial_hairstyle("Shaved")
	else
		H.set_hairstyle(pick(h_gen.female_hair))
		H.set_facial_hairstyle("Shaved")

	H.set_eye_color(random_eye_color())

	H.underwear = random_underwear(H.gender)
	var/obj/item/organ/eyes/organ_eyes = H.get_organ_by_type(/obj/item/organ/eyes)
	if(organ_eyes)
		H.underwear_color = organ_eyes.eye_color_left
	if(prob(50) || H.gender == FEMALE)
		H.undershirt = random_undershirt(H.gender)
	if(prob(25))
		H.socks = random_socks()

	H.update_body()

/datum/team/swat/proc/rename_team(new_name)
	swat_name = new_name
	name = "[swat_name] Team"

/proc/swat_name()
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

	return name

/datum/objective/swat
	name = "swat"
	explanation_text = "Follow the orders of your commander."
	martyr_compatible = TRUE

/datum/team/swat
	var/swat_name
	var/core_objective = /datum/objective/swat
	member_name = "Swat Officer"

/datum/team/swat/New()
	..()
	swat_name = swat_name()

/datum/team/swat/proc/update_objectives()
	if(core_objective)
		var/datum/objective/O = new core_objective
		O.team = src
		objectives += O


/datum/team/swat/roundend_report()
	var/list/parts = list()
	parts += span_header("[swat_name] Operatives:")

	var/text = "<br>[span_header("The SWAT were:")]"
	text += printplayerlist(members)
	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

