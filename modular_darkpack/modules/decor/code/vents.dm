/obj/structure/roofstuff
	name = "roof ventilation"
	desc = "Air to inside."
	icon = 'modular_darkpack/modules/decor/icons/vents.dmi'
	icon_state = "roof1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/can_be_snowy = TRUE

/obj/structure/roofstuff/Initialize(mapload)
	. = ..()
	if(can_be_snowy && check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"

/obj/structure/roofstuff/alt1
	icon_state = "roof2"
	density = FALSE

/obj/structure/roofstuff/alt2
	icon_state = "roof3"

// Use this instead of alt3
/obj/structure/roofstuff/vent_end
	icon_state = "roof4"
	smoothing_groups = SMOOTH_GROUP_VENTS

/obj/structure/roofstuff/vent
	icon_state = "vent-0"
	base_icon_state = "vent"
	smoothing_groups = SMOOTH_GROUP_VENTS
	can_be_snowy = FALSE

/obj/structure/roofstuff/vent/south
	icon_state = "vent-3"

/obj/structure/roofstuff/vent/autotiling
	MAP_SWITCH(icon_state = "vent-0", icon_state = "vent_autotile")
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_VENTS
	canSmoothWith = SMOOTH_GROUP_VENTS

/obj/structure/roofstuff/vent/autotiling/update_icon(updates=ALL)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & USES_SMOOTHING))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)
