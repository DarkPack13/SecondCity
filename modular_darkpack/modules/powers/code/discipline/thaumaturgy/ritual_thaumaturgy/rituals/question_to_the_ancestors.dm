// **************************************************************** QUESTION TO THE ANCESTORS *************************************************************

/obj/ritualrune/question
	name = "Question to the Ancestors Rune"
	desc = "Summon souls from the dead. Ask a question and get answers. Requires a bloodpack."
	icon_state = "rune5"
	word = "VOCA-ANI'MA"
	thaumlevel = 3
	sacrifices = list(/obj/item/reagent_containers/blood)

/mob/living/simple_animal/hostile/ghost/tremere
	maxHealth = 1
	health = 1
	melee_damage_lower = 1
	melee_damage_upper = 1
	faction = list(VAMPIRE_CLAN_TREMERE)

/obj/ritualrune/question/complete()
	var/text_question = tgui_input_text(usr, "Enter your question to the Ancestors:", "Question to Ancestors")
	visible_message("<span class='notice'>A call rings out to the dead from the [src.name] rune...</span>")
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you wish to answer a question? (You are allowed to spread meta information) The question is : [text_question]", null, null, null, 20 SECONDS, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, span_ghostalert("Question rune has been triggered."))
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		var/mob/living/simple_animal/hostile/ghost/tremere/TR = new(loc)
		TR.key = C.key
		TR.name = C.name
		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
		qdel(src)
	else
		visible_message(span_notice("No one answers the [src.name] rune's call."))


