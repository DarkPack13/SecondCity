/obj/ritualrune/blood_wall
	name = "Blood Wall"
	desc = "Creates the Blood Wall to protect tremere or his domain."
	icon_state = "rune3"
	word = "SOT'PY-O"
	thaumlevel = 2

/obj/ritualrune/blood_wall/complete()
	new /obj/structure/bloodwall(loc)
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
	qdel(src)

/obj/structure/bloodwall
	name = "blood wall"
	desc = "Wall from BLOOD."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "bloodwall"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
