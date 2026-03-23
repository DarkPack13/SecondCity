/mob/living/carbon/human/proc/handle_drink_dry(var/mob/living/mob)
	if(get_kindred_splat(mob) && !get_kindred_splat(src))
		handle_diablerie(mob)
	else if(ishuman(mob))
		handle_overfeeding(mob)
	else
		if(mob.stat != DEAD)
			mob.death()
