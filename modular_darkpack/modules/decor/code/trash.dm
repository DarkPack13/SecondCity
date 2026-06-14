
/obj/effect/decal/cleanable/trash
	name = "trash"
	icon = 'modular_darkpack/modules/decor/icons/trash.dmi'
	icon_state = "trash1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/trash/Initialize(mapload)
	. = ..()
	icon_state = "trash[rand(1, 30)]"

/obj/effect/decal/cleanable/trash/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)

/obj/effect/decal/cleanable/litter
	name = "litter"
	icon = 'modular_darkpack/modules/decor/icons/trash.dmi'
	icon_state = "paper1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/litter/Initialize(mapload)
	. = ..()
	icon_state = "paper[rand(1, 6)]"

/obj/effect/decal/cleanable/litter/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)

/obj/effect/decal/cleanable/cardboard
	name = "cardboard"
	icon = 'modular_darkpack/modules/decor/icons/trash.dmi'
	icon_state = "cardboard1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/cardboard/Initialize(mapload)
	. = ..()
	icon_state = "cardboard[rand(1, 5)]"
	var/matrix/M = matrix()
	M.Turn(rand(0, 360))
	transform = M

/obj/effect/decal/cleanable/cardboard/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)

/obj/effect/decal/cleanable/trash/big
	name = "trash"
	icon = 'modular_darkpack/modules/decor/icons/trash.dmi'
	icon_state = "bigtrash1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/trash/big/Initialize(mapload)
	. = ..()
	if(icon_state == src::icon_state)
		icon_state = "bigtrash[rand(1, 12)]"

/obj/effect/decal/cleanable/trash/big/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)

/obj/effect/decal/cleanable/trash/books
	name = "trash"
	icon = 'modular_darkpack/modules/decor/icons/trash.dmi'
	icon_state = "books1"
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/trash/big/Initialize(mapload)
	. = ..()
	if(icon_state == src::icon_state)
		icon_state = "books[rand(1, 13)]"

/obj/effect/decal/cleanable/trash/books/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)
