/mob/living/carbon/human/proc/handle_drink_dry(mob/living/drunk_from_mob)
	if(get_kindred_splat(drunk_from_mob) && get_kindred_splat(src))
		handle_diablerie(drunk_from_mob)
	else if(ishuman(drunk_from_mob))
		handle_overfeeding(drunk_from_mob)
	else
		if(drunk_from_mob.stat != DEAD)
			drunk_from_mob.death()
