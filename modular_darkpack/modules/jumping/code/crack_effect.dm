/obj/effect/temp_visual/dir_setting/crack_effect
	icon = 'modular_darkpack/modules/jumping/icons/ground_crack.dmi'
	icon_state = "crack"
	pixel_w = -32
	pixel_z = -32
	duration = 50
	alpha = 196
	plane = GAME_PLANE
	layer = LOW_OBJ_LAYER

/obj/effect/temp_visual/dir_setting/crack_effect/Initialize(mapload)
	. = ..()
	animate(src, alpha = 0, time = 50)
