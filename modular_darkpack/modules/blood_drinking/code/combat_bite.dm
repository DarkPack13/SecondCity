// Thanks to @hex37 for most of this
/**
 * Biting for purposes other than drinking blood
 *
 * Arguments:
 * * pulling - The mob we're biting
 * * damage_type - What kind of damage we're doing as a list. If blank, grabs from vars. (ex. list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, AGGRAVATED = 0))
 */
/mob/living/carbon/proc/combat_bite(list/damage_types)
	if(!COOLDOWN_FINISHED(src, drinkblood_use_cd) || !COOLDOWN_FINISHED(src, drinkblood_click_cd))
		return
	COOLDOWN_START(src, drinkblood_click_cd, 1 SECONDS)
	if(!damage_types)
		damage_types = combat_bite_damages

	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if(skipface)
		to_chat(src, span_warning("Take your mask off first!"))
		return

	if(grab_state > GRAB_PASSIVE)
		if(isliving(pulling))
			var/mob/living/bit_living = pulling
			visible_message(span_warning("[src] starts biting [bit_living] with [p_their()] sharp teeth!"), span_warning("You start biting [bit_living] with your sharp teeth!"), span_warning("You hear the sound of flesh tearing!"))
			bit_living.emote("scream")
			if(ishuman(bit_living))
				var/mob/living/carbon/human/bit_human = bit_living
				bit_human.add_bite_animation()

			do_combat_bite(bit_living, damage_types, TRUE)

/mob/living/carbon/proc/do_combat_bite(mob/living/chewed_on, list/damage_types, first_bite = FALSE)

	COOLDOWN_START(src, drinkblood_use_cd, 3 SECONDS)

	if(isnpc(chewed_on))
		var/mob/living/carbon/human/npc/NPC = chewed_on
		NPC.danger_source = null
		chewed_on.Stun(10) // NPCs can't resist right away

	if(chewed_on.health < (values_sum(damage_types)*1.5))
		to_chat(src, span_userdanger("Your victim is near death."))

	if(!do_after(src, 2 SECONDS, target = chewed_on, timed_action_flags = NONE, progress = FALSE))
		stop_chewing(chewed_on)
		return

	if(iscarbon(chewed_on))
		var/mob/living/carbon/chewtoy = chewed_on
		var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/damage/bite
		roll_datum.difficulty = combat_bite_difficulty
		var/roll_result = roll_datum.st_roll(src, chewtoy)+1
		if(roll_result)
			for(var/damage_type, damage_amount in damage_types)
				if(roll_result > 0)
					chewtoy.apply_damage((damage_amount*roll_result), damage_type, sharpness = SHARP_POINTY)
			playsound(get_turf(src), 'sound/items/weapons/bite.ogg', 50, TRUE)

			if(chewtoy.reagents) // We might ingest some blood on accident
				if(length(chewtoy.reagents.reagent_list))
					if(prob(15)) // We might ingest some blood on accident
						chewtoy.reagents.trans_to(src, min(10, chewtoy.reagents.total_volume), transferred_by = chewed_on, methods = INGEST)

	if(grab_state > GRAB_PASSIVE)
		stop_sound_channel(CHANNEL_BLOOD)
		do_combat_bite(chewed_on, damage_types)

/mob/living/carbon/proc/stop_chewing()
	stop_sound_channel(CHANNEL_BLOOD)
	COOLDOWN_RESET(src, drinkblood_use_cd)
	return
