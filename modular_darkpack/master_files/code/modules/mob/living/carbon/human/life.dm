/mob/living/carbon/human/Life(seconds_per_tick)
	if(!get_kindred_splat(src))
		if(prob(5))
			adjust_agg_loss(-5, TRUE)
	. = ..()

	// SPLATS
	for(var/datum/splat/splat in splats)
		splat.splat_life(seconds_per_tick)
