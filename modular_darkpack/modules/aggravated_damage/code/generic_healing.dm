// Generic helpers to simulate the healing of the TTRPG

/// Returns amount of dots healed
/mob/living/proc/heal_storyteller_health(dots_to_heal, heal_aggravated = FALSE, heal_scars = FALSE, heal_blood = FALSE)
	if(dots_to_heal <= 0)
		return 0

	var/healed_dots = 0

	if(heal_scars && dots_to_heal > 0)
		healed_dots += heal_storyteller_scars(dots_to_heal)

	if(heal_aggravated)
		while(dots_to_heal > 0 && get_agg_loss()+get_fire_loss() > 0)
			heal_ordered_damage(1 TTRPG_DAMAGE, list(BURN, AGGRAVATED))
			dots_to_heal--
			healed_dots++

	while(dots_to_heal > 0 && get_brute_loss()+get_tox_loss()+get_oxy_loss() > 0)
		heal_ordered_damage(1 TTRPG_DAMAGE, list(BRUTE, TOX, OXY))
		dots_to_heal--
		healed_dots++

	if(heal_blood)
		adjust_blood_volume(dots_to_heal * 2, maximum = BLOOD_VOLUME_NORMAL) // Idk. this one doesnt cost anything.

	if(healed_dots)
		updatehealth()

	return healed_dots

/mob/living/proc/heal_storyteller_scars(dots_to_heal)
	return

/mob/living/carbon/heal_storyteller_scars(dots_to_heal)
	var/healed_dots = 0

	for(var/datum/wound/our_wound in all_wounds)
		if(dots_to_heal <= 0)
			break
		our_wound.remove_wound()
		dots_to_heal--
		healed_dots++

	// W20 p. 259: describes "battle scars" to be inclusive of stuff like organ damage, brain damage or lost limbs.
	for(var/obj/item/organ/target_organ as anything in organs)
		if(!target_organ.damage)
			continue
		if(target_organ.apply_organ_damage(-dots_to_heal TTRPG_DAMAGE, required_organ_flag = ORGAN_ORGANIC))
			dots_to_heal--
			healed_dots++

	return healed_dots


// Its not FULLY 1 to 1 with the amount of dots I think. I think the rounding can cut off a dice or two? but its close enough for guessing how much vitate it would cost to heal for example.
/// Returns amount of "dots" of damage the mob currently has.
/mob/living/proc/get_storyteller_damage(heal_aggravated = FALSE, heal_scars = FALSE, heal_blood = FALSE)
	var/damage_dots = 0
	if(heal_aggravated)
		damage_dots += round(get_agg_loss()+get_fire_loss(), 1 TTRPG_DAMAGE) / 1 TTRPG_DAMAGE
	damage_dots += round(get_brute_loss()+get_tox_loss()+get_oxy_loss(), 1 TTRPG_DAMAGE) / 1 TTRPG_DAMAGE

	if(heal_scars)
		damage_dots += get_storyteller_scars_damage()

	return damage_dots

/mob/living/proc/get_storyteller_scars_damage()
	return

/mob/living/carbon/get_storyteller_scars_damage()
	var/damage_dots = 0

	for(var/datum/wound/our_wound in all_wounds)
		damage_dots++

	// W20 p. 259: describes "battle scars" to be inclusive of stuff like organ damage, brain damage or lost limbs.
	for(var/obj/item/organ/target_organ as anything in organs)
		if(!target_organ.damage)
			continue
		damage_dots++

	return damage_dots
