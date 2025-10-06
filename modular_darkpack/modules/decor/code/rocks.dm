/obj/structure/vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "rock[rand(1, 9)]"

/obj/structure/small_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "smallrock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/small_vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "smallrock[rand(1, 6)]"

/obj/structure/big_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "rock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/big_vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "rock[rand(1, 4)]"

/obj/structure/stalagmite
	name = "stalagmite"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "stalagmite1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/stalagmite/Initialize(mapload)
	. = ..()
	icon_state = "stalagmite[rand(1, 5)]"
