/obj/structure/rack/clothing
	name = "clothing rack"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/decor/icons/rack.dmi'
	icon_state = "rack"

/obj/structure/rack/clothing/rand
	icon_state = "rack2"

/obj/structure/rack/clothing/rand/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"


/obj/structure/rack/clothing_hanger
	name = "clothing hanger"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/decor/icons/rack.dmi'
	icon_state = "hanger1"

/obj/structure/rack/clothing_hanger/rand
	icon_state = "hanger2"

/obj/structure/rack/clothing_hanger/rand/Initialize(mapload)
	. = ..()
	icon_state = "hanger[rand(1, 4)]"

/obj/structure/rack/fruit_stand
	name = "frust stand"
	icon = 'modular_darkpack/modules/decor/icons/rack.dmi'
	icon_state = "fruit_stand"


// Soft deprecated.
/obj/structure/rack/food
	name = "food rack"
	desc = "Have some food."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "rack1"
	pixel_w = -16

/obj/structure/rack/food/rand
	icon_state = "rack2"

/obj/structure/rack/food/rand/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"


/obj/structure/rack/tall
	abstract_type = /obj/structure/rack/tall
	icon_state = null
	icon = 'modular_darkpack/modules/decor/icons/rack32x64.dmi'

/obj/structure/rack/tall/wood_shelf
	icon_state = "wood_shelf"

/obj/structure/rack/tall/wood_shelf/alt
	icon_state = "wood_shelf-alt"

/obj/structure/rack/tall/metal_shelf
	icon_state = "metal_shelf"

/obj/structure/rack/tall/store_shelf
	icon_state = "store_shelf"

/obj/structure/rack/tall/store_shelf_metal
	icon_state = "store_shelf_metal"


/obj/structure/rack/wide
	icon_state = null
	icon = 'modular_darkpack/modules/decor/icons/rack64x64.dmi'
	abstract_type = /obj/structure/rack/wide


/obj/structure/rack/wide/Initialize(mapload)
	. = ..()
	switch(dir)
		if(SOUTH, NORTH)
			bound_width = 64
			bound_height = 32
		if(EAST, WEST)
			bound_width = 32
			bound_height = 64

/obj/structure/rack/wide/clothing_rack
	icon_state = "clothing_rack"

/obj/structure/rack/wide/metal_shelf
	icon_state = "metal_shelf"

/obj/structure/rack/wide/wood_shelf
	icon_state = "wood_shelf"

/obj/structure/rack/wide/wood_shelf/alt
	icon_state = "wood_shelf-alt"

/obj/structure/rack/wide/store_shelf
	icon_state = "store_shelf"

/obj/structure/rack/wide/med_shelf
	icon_state = "med_shelf"

/obj/structure/rack/wide/wood_shelf_big
	icon_state = "wood_shelf_big"

/obj/structure/rack/wide/showcase
	icon_state = "showcase"
