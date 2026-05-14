// W20 p. 259
/datum/status_effect/stacking/silver_bullets
	id = "silver_bullet_stacks"
	tick_interval = 1 TURNS
	delay_before_decay = 1 SCENES
	stacks = 1
	stack_threshold = 5
	max_stacks = 5
	// This renders ONTOP of the mob. Not as a status effect. Which is prob what we need to do.
	// overlay_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/silver_dam_status.dmi'
	// overlay_state = "silver"

/datum/status_effect/stacking/silver_bullets/threshold_cross_effect()
	var/datum/splat/werewolf/shifter/splat = get_shifter_splat(owner)
	if(splat)
		splat.adjust_gnosis(-1, TRUE)


/obj/projectile/bullet/proc/fera_silver_damage(mob/living/carbon/human/target)
	if(!istype(target))
		return
	var/datum/splat/werewolf/shifter/shot_pup_splat = get_shifter_splat(target)
	if(shot_pup_splat)
		var/mob/living/carbon/human/shot_pup = target
		shot_pup.apply_status_effect(STATUS_EFFECT_SILVER_BULLET_STACKS)

		if(!shot_pup_splat.is_breed_form())
			damage_type = AGGRAVATED

/obj/item/proc/fera_silver_damage(mob/living/carbon/human/target, gnosis_damage = 0)
	if(!istype(target))
		return
	var/datum/splat/werewolf/shifter/shot_pup_splat = get_shifter_splat(target)
	if(shot_pup_splat)
		var/mob/living/carbon/human/shot_pup = target
		shot_pup_splat.adjust_gnosis(-gnosis_damage, TRUE)

		// W20 p. 290 - Werewolves dont take silver damage in breed form because they arent spirits
		if(!shot_pup_splat.is_breed_form())
			// w20 core 256 - all damage becomes agg in non-breed form to garou and cannot be soaked
			damtype = AGGRAVATED
