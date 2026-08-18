// mimmics /mob/living/carbon/human/species to allow for quick testing
/mob/living/carbon/human/splat
	abstract_type = /mob/living/carbon/human/splat
	var/auto_splats = list()

/mob/living/carbon/human/splat/Initialize(mapload)
	. = ..()
	for(var/splat in auto_splats)
		add_splat(splat)
