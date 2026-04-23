/datum/splat/fomori
	name = "Fomori"
	desc = "An unfortunate vessel possesed by an evil spirit known as a Bane."
	id = SPLAT_FOMORI

	splat_priority = SPLAT_PRIO_FOMORI

	power_type = /datum/action/cooldown/power/fomori_power

/mob/living/carbon/human/splat/fomori
	auto_splats = list(/datum/splat/fomori)
