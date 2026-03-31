/obj/ritual_rune/abyss/calling_the_hungry_shade
	name = "calling the hungry shade"
	desc = "call forth a hungry, and furious, shade of the Abyss, and seek to tame it. Beware if you fail - it will attack you instead!"
	icon_state = "rune8"
	word = "Spirit of Hunger."
	level = 3
	cost = 1

/obj/ritual_rune/abyss/calling_the_hungry_shade/complete()
	var/mob/living/carbon/human/H = last_activator
	var/roll = SSroll.storyteller_roll(last_activator.st_get_stat(STAT_INTELLIGENCE) + last_activator.st_get_stat(STAT_OCCULT), 9, last_activator)
	switch(roll)
		if(ROLL_SUCCESS)
			H.add_beastmaster_minion(/mob/living/basic/shadow_guard/hungry_shade)
			//BG.melee_damage_lower = BG.melee_damage_lower+activator_bonus
			//BG.melee_damage_upper = BG.melee_damage_upper+activator_bonus
			playsound(loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			if(length(H.beastmaster_minions) > H.st_get_stat(STAT_OCCULT))
				var/mob/living/beastmaster_minion = pick(H.beastmaster_minions)
				beastmaster_minion.death()
			qdel(src)
		if(ROLL_FAILURE)
			var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
			shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
			shade.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, H)
			shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
			to_chat(H, span_warning("The ritual slips from your grasp - something answers the call regardless!"))
			playsound(loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			qdel(src)
		if(ROLL_BOTCH)
			var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
			shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
			shade.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, H)
			shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
			to_chat(H, span_warning("You lose control over the ritual!"))
			H.apply_damage(30, AGGRAVATED)
			playsound(loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			qdel(src)
