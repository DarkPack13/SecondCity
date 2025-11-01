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
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
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
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "pine[rand(1, 4)]-snow"
	if(prob(2))
		burnshit()

/obj/structure/flora/tree/vamp/pine/get_seethrough_map()
	return SEE_THROUGH_MAP_THREE_X_THREE

/obj/structure/flora/tree/vamp/pine/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"


/obj/structure/flora/grass/tall
	icon_state = "tallgrass_1"
	icon = 'modular_darkpack/modules/decor/icons/flora32x48.dmi'

/obj/structure/flora/grass/tall/style_2
	icon_state = "tallgrass_2"

/obj/structure/flora/grass/tall/style_3
	icon_state = "tallgrass_3"

/obj/structure/flora/grass/tall/style_4
	icon_state = "tallgrass_4"

/obj/structure/flora/grass/tall/style_random/Initialize(mapload)
	. = ..()
	icon_state = "tallgrass_[rand(1, 4)]"
	update_appearance()

/obj/structure/flora/grass/tall/dry
	icon_state = "drytallgrass_1"

/obj/structure/flora/grass/tall/dry/style_2
	icon_state = "drytallgrass_2"

/obj/structure/flora/grass/tall/dry/style_3
	icon_state = "drytallgrass_3"

/obj/structure/flora/grass/tall/dry/style_4
	icon_state = "drytallgrass_4"

/obj/structure/flora/grass/tall/dry/style_random/Initialize(mapload)
	. = ..()
	icon_state = "drytallgrass_[rand(1, 4)]"
	update_appearance()

/obj/structure/flora/grass/short
	icon_state = "grass_1"
	icon = 'modular_darkpack/modules/decor/icons/flora32x48.dmi'

/obj/structure/flora/grass/short/style_2
	icon_state = "grass_2"

/obj/structure/flora/grass/short/style_3
	icon_state = "grass_3"

/obj/structure/flora/grass/short/style_4
	icon_state = "grass_4"

/obj/structure/flora/grass/short/style_random/Initialize(mapload)
	. = ..()
	icon_state = "grass_[rand(1, 4)]"
	update_appearance()

/obj/structure/flora/bush/redflower
	icon_state = "redplant_1"
	icon = 'modular_darkpack/modules/decor/icons/flora32x48.dmi'

/obj/structure/flora/bush/redflower/style_2
	icon_state = "redplant_2"

/obj/structure/flora/bush/redflower/style_3
	icon_state = "redplant_3"

/obj/structure/flora/bush/redflower/style_4
	icon_state = "redplant_4"

/obj/structure/flora/bush/redflower/style_random/Initialize(mapload)
	. = ..()
	icon_state = "redplant_[rand(1, 4)]"
	update_appearance()


/obj/effect/spawner/random/flora
	icon_state = "flower"
	abstract_type = /obj/effect/spawner/random/flora

/obj/effect/spawner/random/flora/all
	loot = list(
		/obj/effect/spawner/random/flora/grass = 5,
		/obj/effect/spawner/random/flora/bushes = 3,
		/obj/effect/spawner/random/flora/rocks = 1
	)

/obj/effect/spawner/random/flora/grass
	loot = list(
		/obj/structure/flora/grass/short/style_random = 1,
		/obj/structure/flora/bush/sparsegrass/style_random = 1
	)

/obj/effect/spawner/random/flora/bushes
	loot = list(
		/obj/structure/flora/grass/tall/style_random = 1,
		/obj/structure/flora/grass/tall/dry/style_random = 1,
		/obj/structure/flora/grass/short/style_random = 1,
		/obj/structure/flora/bush/redflower/style_random = 1
	)

/obj/effect/spawner/random/flora/rocks
	loot = list(/obj/structure/small_vamprocks = 5, /obj/structure/vamprocks = 1)
