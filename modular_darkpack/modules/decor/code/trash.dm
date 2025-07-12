
/obj/effect/decal/cleanable/trash
	name = "trash"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "trash1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/trash/Initialize(mapload)
	. = ..()
	icon_state = "trash[rand(1, 30)]"

/obj/effect/decal/cleanable/litter
	name = "litter"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "paper1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/litter/Initialize(mapload)
	. = ..()
	icon_state = "paper[rand(1, 6)]"

/obj/effect/decal/cleanable/cardboard
	name = "cardboard"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "cardboard1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/cardboard/Initialize(mapload)
	. = ..()
	icon_state = "cardboard[rand(1, 5)]"
	var/matrix/M = matrix()
	M.Turn(rand(0, 360))
	transform = M
