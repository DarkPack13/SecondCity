// **************************************************************** QUESTION TO THE ANCESTORS *************************************************************

/obj/ritualrune/question
	name = "Question to the Ancestors Rune"
	desc = "Summon souls from the dead. Ask a question and get answers. Requires a bloodpack."
	icon_state = "rune5"
	word = "VOCA-ANI'MA"
	thaumlevel = 3
	sacrifices = list(/obj/item/reagent_containers/blood)

/mob/living/basic/hostile/ghost/tremere
	maxHealth = 1
	health = 1
	melee_damage_lower = 1
	melee_damage_upper = 1
	faction = list(VAMPIRE_CLAN_TREMERE)

/obj/ritualrune/question/complete()
	var/text_question = tgui_input_text(usr, "Enter your question to the Ancestors:", "Question to Ancestors")
	if(!text_question)
		return

	visible_message(span_notice("A call rings out to the dead from the [src.name] rune..."))

	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, span_ghostalert("Question rune has been triggered. Question: [text_question]"))

	var/mob/living/basic/hostile/ghost/tremere/TR = new(loc)

	var/list/candidates = SSpolling.poll_ghosts_for_targets(
		question = "Do you wish to answer a question? (You are allowed to spread meta information)\nThe question is: [span_notice(text_question)]",
		role = ROLE_SENTIENCE,
		poll_time = 20 SECONDS,
		checked_targets = list(TR),
	)

	if(length(candidates))
		var/mob/dead/observer/C = pick(candidates)
		TR.key = C.key
		TR.name = C.name
		playsound(loc, 'modular_darkpack/modules/powers/code/discipline/thaumaturgy/sounds/thaum.ogg', 50, FALSE)
		message_admins("[key_name_admin(C)] has become an Ancestor spirit to answer: [text_question]")
		qdel(src)
	else
		visible_message(span_notice("No one answers the [src.name] rune's call."))
		qdel(TR) // Delete the ghost mob if no one signed up
		qdel(src)
