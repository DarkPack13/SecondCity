#if !defined(CBT)
/obj/effect/mapping_helpers/viewport_helper
	name = "viewport helper"
	desc = "If you see this, the maptainers are all dead or dying. Mappers! Make sure to delete this later."
	icon = 'modular_darkpack/modules/mapping_helpers/icons/viewport_helper.dmi'
	icon_state = "viewport"
	layer = INFINITY
	pixel_x = -288
	pixel_y = -224

/obj/effect/mapping_helpers/viewport_helper/Initialize(mapload)
	. = ..()
	if(mapload)
		CRASH("Viewport helper at X:[x], Y:[y]")
	qdel(src)

/obj/effect/mapping_helpers/viewport_helper/transparent
	icon_state = "transparent"
#endif
