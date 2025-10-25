/obj/effect/celerity
	name = "Afterimage"
	desc = "..."
	anchored = TRUE

/obj/effect/celerity/Initialize(mapload, mob/living/creator)
	. = ..()

	name = creator?.name
	appearance = creator?.appearance
	dir = creator?.dir

	animate(src, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 0.5 SECONDS)

	// Delete this effect after half a second
	QDEL_IN(src, 0.5 SECONDS)
