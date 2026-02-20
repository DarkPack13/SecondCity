/mob/living/proc/make_ghoul(mob/living/domitor)
	RETURN_TYPE(/datum/splat/vampire/ghoul)

	return add_splat(/datum/splat/vampire/ghoul, domitor)

/mob/living/carbon/human/splat/ghoul
	auto_splats = list(/datum/splat/vampire/ghoul)
