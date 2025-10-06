/obj/structure/flora/tree/vamp
	name = "tree"
	desc = "Cute and tall flora."
	icon = 'modular_darkpack/modules/decor/icons/trees.dmi'
	icon_state = "tree1"
	SET_BASE_PIXEL(-32,0)
	var/burned = FALSE

/obj/structure/flora/tree/vamp/Initialize(mapload)
	. = ..()
	icon_state = "tree[rand(1, 11)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				icon_state = "[initial(icon_state)][rand(1, 11)]-snow"

/obj/structure/flora/tree/vamp/get_seethrough_map()
	return SEE_THROUGH_MAP_DEFAULT

/obj/structure/flora/tree/vamp/proc/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 3)]"

/obj/structure/flora/tree/vamp/pine
	name = "pine"
	desc = "Cute and tall flora."
	icon = 'modular_darkpack/modules/decor/icons/pines.dmi'
	icon_state = "pine1"

/obj/structure/flora/tree/vamp/pine/Initialize(mapload)
	. = ..()
	icon_state = "pine[rand(1, 4)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				icon_state = "pine[rand(1, 4)]-snow"
	if(prob(2))
		burnshit()

/obj/structure/flora/tree/vamp/pine/get_seethrough_map()
	return SEE_THROUGH_MAP_THREE_X_THREE

/obj/structure/flora/tree/vamp/pine/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"
