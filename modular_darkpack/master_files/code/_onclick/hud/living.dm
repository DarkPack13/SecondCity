/datum/hud/living/New(mob/living/owner)
	..()

	bloodpool_icon = new(null, src)
	infodisplay += bloodpool_icon

