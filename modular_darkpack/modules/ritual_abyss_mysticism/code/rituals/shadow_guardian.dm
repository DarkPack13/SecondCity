/obj/ritual_rune/abyss/heart_that_beats_in_silence
	name = "the heart that beats in silence"
	desc = "Creates a shadowy abomination to protect the Lasombra and his domain."
	icon_state = "rune1"
	word = "ANI UMRA"
	level = 2
	cost = 1

/obj/ritual_rune/abyss/heart_that_beats_in_silence/complete()
	var/mob/living/carbon/human/H = last_activator
	var/dice = (last_activator.st_get_stat(STAT_INTELLIGENCE) + last_activator.st_get_stat(STAT_OCCULT))

	var/roll = SSroll.storyteller_roll(dice, 6, last_activator, numerical = FALSE)
	last_activator.apply_damage(30, AGGRAVATED)

	if(roll == ROLL_SUCCESS)
		H.add_beastmaster_minion(/mob/living/basic/shadow_guard)
		//BG.melee_damage_lower = BG.melee_damage_lower+activator_bonus
		//BG.melee_damage_upper = BG.melee_damage_upper+activator_bonus
		playsound(loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
		//if(length(H.beastmaster) > H.st_get_stat(STAT_OCCULT))
			//var/mob/living/simple_animal/hostile/beastmaster/B = pick(H.beastmaster)
			//B.death()
		qdel(src)

	else if(roll == ROLL_FAILURE)
		qdel(src)

	else if(roll == ROLL_BOTCH)
		to_chat(last_activator, span_warning("You lose control over the ritual!"))
		last_activator.apply_damage(30, AGGRAVATED)
		qdel(src)

