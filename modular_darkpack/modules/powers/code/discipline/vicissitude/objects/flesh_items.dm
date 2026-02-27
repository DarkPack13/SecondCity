/datum/material/vicissitude_flesh
	name = "flesh"
	desc = "What remains of a person, when you really get down to it."
	color = "#d8965b"
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE, MAT_CATEGORY_ITEM_MATERIAL = TRUE)
	sheet_type = /obj/item/stack/sheet/meat
	value_per_unit = 0.05
	beauty_modifier = -0.3
	strength_modifier = 0.7
	item_sound_override = 'sound/effects/meatslap.ogg'
	turf_sound_override = FOOTSTEP_MEAT

/obj/item/stack/human_flesh
	name = "human flesh"
	desc = "What the fuck..."
	singular_name = "human flesh"
	icon = 'modular_darkpack/modules/powers/icons/flesh_stack.dmi'
	icon_state = "human"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	mats_per_unit = list(/datum/material/vicissitude_flesh = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/human_flesh
	max_amount = 50

/obj/item/stack/human_flesh/fifty
	amount = 50

/obj/item/stack/human_flesh/twenty
	amount = 20

/obj/item/stack/human_flesh/ten
	amount = 10

/obj/item/stack/human_flesh/five
	amount = 5

/obj/item/autosurgeon/vicissitude
	name = "little brother"
	desc = "A talented fleshcrafted creature that can insert an implant or organ into its master without the hassle of extensive surgery. \
		Its mouth is eagerly awaiting implants or organs. However, it's quite greedy, so a screwdriver must be used to pry away accidentally added items."
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'

/obj/structure/fleshwall
	name = "flesh wall"
	desc = "Wall from FLESH."
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "fleshwall"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100

/obj/structure/tzijelly
	name = "jelly thing"
	desc = "an important part of the meat matrix."
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzijelly"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100

/obj/item/ground_heir
	name = "bag of ground"
	desc = "Heroic strength is forged here..."
	icon_state = "dirt"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

// Why is this NOT a floor type.
/obj/effect/decal/gut_floor
	name = "gut floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "tzimisce_floor"

/obj/effect/decal/gut_floor/Initialize(mapload)
	. = ..()
	if(isopenturf(get_turf(src)))
		var/turf/open/T = get_turf(src)
		if(T)
			T.slowdown = 1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/obj/structure/chair/old/tzimisce
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzimisce_stool"

/obj/item/guts
	name = "guts"
	desc = "Just blood and guts..."
	icon_state = "guts"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "spine"
	desc = "If only I had control..."
	icon_state = "spine"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
