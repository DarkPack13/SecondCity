/obj/machinery/door/airlock/elevator
	name = "elevator door"
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	icon_state = "closed"
	abstract_type = /obj/machinery/door/airlock/elevator
	doorOpen = 'modular_darkpack/modules/elevators/sounds/elevatoropen.ogg'
	doorClose = 'modular_darkpack/modules/elevators/sounds/elevatorclose.ogg'
	doorDeni = null
	boltUp = null
	boltDown = null

	overlays_file = null

/obj/machinery/door/airlock/elevator/Initialize(mapload) // I took this from transport_module.dm and the comment there says 'linter and stuff' so I hope this fixes my checks
	if(!isnull(transport_linked_id))
		elevator_mode = TRUE
	return ..()

/obj/machinery/door/airlock/elevator/left
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/left

/obj/machinery/door/airlock/elevator/right
	icon = 'modular_darkpack/modules/elevators/icons/doorright.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/right

/obj/machinery/door/airlock/elevator/multi_tile
	icon = 'modular_darkpack/modules/elevators/icons/doordouble.dmi'
	assemblytype = /obj/structure/door_assembly/elevator/multi_tile
	multi_tile = TRUE

/obj/machinery/door/airlock/elevator/multi_tile/setDir(newdir)
	. = ..()
	set_bounds()

/obj/structure/door_assembly/elevator
	name = "door assembly"
	base_name = "elevator door"
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'
	icon_state = "construction"
	abstract_type = /obj/structure/door_assembly/elevator
	overlays_file = null
	anchored = FALSE
	density = TRUE

/obj/structure/door_assembly/elevator/left
	icon = 'modular_darkpack/modules/elevators/icons/doorleft.dmi'

/obj/structure/door_assembly/elevator/right
	icon = 'modular_darkpack/modules/elevators/icons/doorright.dmi'

/obj/structure/door_assembly/elevator/multi_tile
	name = "door assembly"
	icon = 'modular_darkpack/modules/elevators/icons/doordouble.dmi'
	airlock_type = /obj/machinery/door/airlock/elevator/multi_tile
	dir = EAST
	multi_tile = TRUE
