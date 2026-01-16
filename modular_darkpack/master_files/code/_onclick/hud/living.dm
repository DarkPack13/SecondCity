/datum/hud/living/New(mob/living/owner)
	..()

	bloodpool_icon =  new /atom/movable/screen/bloodpool(null, src)
	infodisplay += bloodpool_icon
