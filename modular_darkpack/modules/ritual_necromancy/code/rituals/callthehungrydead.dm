/obj/ritual_rune/necromancy/question //No bloodpack requirement, but the wraiths aren't implied to owe answers.
	name = "call the hungry dead"
	desc = "Summon a wraith from the Shadowlands to converse."
	icon_state = "rune4"
	word = "METEH' GHM'IEN"
	level = 2

/mob/living/basic/ghost/giovanni
	maxHealth = 100 //Can be annoying right back if they're pestered for nothing.
	health = 100
	melee_damage_lower = 30
	melee_damage_upper = 30
	faction = list(VAMPIRE_CLAN_GIOVANNI)

/obj/ritual_rune/necromancy/question/complete()
	var/text_question = tgui_input_text(last_activator, "Enter your summons to the wraiths:", "Call the Hungry Dead", encode = FALSE)
	visible_message(span_notice("A call rings out to the dead from the rune..."))
	var/mob/living/basic/ghost/TR = new(loc)
	TR.AddComponent(\
		/datum/component/ghost_direct_control,\
		poll_candidates = TRUE,\
		role_name = "a Bound Wraith",\
		poll_length = 30 SECONDS,\
		poll_question = "Do you wish to speak to a necromancer?\nTheir summons is: [text_question]",\
		assumed_control_message = "You are an Ancestor Spirit summoned to answer: [text_question]",\
		after_assumed_control = CALLBACK(src, PROC_REF(ghost_name_prompt), TR)\
	)
	//TR.key = TR.key
	//TR.name = TR.name
	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy2.ogg', 50, FALSE)
	visible_message(span_notice("[TR.name] slowly fades into view over the rune..."))
	qdel(src)

/obj/ritual_rune/necromancy/question/proc/ghost_name_prompt(mob/living/basic/ghost/tremere/ghost_mob)
	message_admins("[key_name_admin(ghost_mob)] has become a Bound Wraith.")

	var/choice = tgui_alert(ghost_mob, "Do you want to pick a new name as a Wraith?", "Wraith Choose Name", list("Yes", "No"), 10 SECONDS)
	if(choice == "Yes")
		var/chosen_ghost_name = tgui_input_text(ghost_mob, "What is your new name as a Wraith?", "Wraith Name Input")
		if(chosen_ghost_name)
			ghost_mob.real_name = chosen_ghost_name
			ghost_mob.name = chosen_ghost_name
