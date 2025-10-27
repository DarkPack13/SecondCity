/datum/outfit/job/sabbatist
	name = "Sabbatist"
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	suit = /obj/item/clothing/suit/vampire/trench
	id = /obj/item/watch
	backpack_contents = list(/obj/item/passport=1, /obj/item/vampire_stake=3, /obj/item/gun/ballistic/revolver/darkpack/magnum=1, /obj/item/knife/vamp=1, /obj/item/vamp/keys/hack=1, /obj/item/scythe/vamp=1, /obj/item/vamp/keys/sabbat=1)
	description = "You are a member of the Sabbat. You are charged with rebellion against the Elders and the Camarilla, against the Jyhad, against the Masquerade and the Traditions, and the recognition of Caine as the true Dark Father of all Kindred kind. <br> <b> NOTE: BY PLAYING THIS ROLE YOU AGREE TO AND HAVE READ THE SERVER'S RULES ON ESCALATION FOR ANTAGS. KEEP THINGS INTERESTING AND ENGAGING FOR BOTH SIDES. KILLING PLAYERS JUST BECAUSE YOU CAN MAY RESULT IN A ROLEBAN. </b>"

/datum/outfit/job/sabbatist/post_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist)
	GLOB.sabbatites += H

	var/my_name = "Tyler"
	if(H.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	H.fully_replace_character_name(null,"[my_name] [my_surname]")
	var/list/landmarkslist = list()
	for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
		if(S.name == name)
			landmarkslist += S
	var/obj/effect/landmark/start/D = pick(landmarkslist)
	H.forceMove(D.loc)

/obj/effect/landmark/start/sabbatist
	name = "Sabbatist"
	delete_after_roundstart = FALSE

/datum/antagonist/sabbatist
	name = "Sabbatist"
	roundend_category = "sabbattites"
	antagpanel_category = FACTION_SABBAT
	pref_flag = ROLE_SABBAT
	antag_moodlet = /datum/mood_event/revolution
	antag_hud_name = "rev"

/datum/antagonist/sabbatist/on_removal()
	..()
	to_chat(owner.current, span_userdanger("You are no longer the part of Sabbat!"))

/datum/antagonist/sabbatist/greet()
	to_chat(owner.current, span_alertsyndie("You are now part of the Sabbat."))
	owner.announce_objectives()
