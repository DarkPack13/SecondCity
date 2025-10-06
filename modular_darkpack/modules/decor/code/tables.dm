/obj/structure/table/bacotell
	name = "countertop"
	desc = "A corperate countertop for serving food."
	icon = 'icons/obj/smooth_structures/darkpack/bacotell_table.dmi'
	icon_state = "bacotell_table-0"
	base_icon_state = "bacotell_table"
	smoothing_groups = SMOOTH_GROUP_BACO_TABLES
	canSmoothWith = SMOOTH_GROUP_BACO_TABLES
	max_integrity = 200
	can_flip = FALSE

/obj/structure/table/bubway
	name = "countertop"
	desc = "A corperate countertop for serving food."
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	smoothing_groups = SMOOTH_GROUP_BUB_TABLES
	canSmoothWith = SMOOTH_GROUP_BUB_TABLES
	max_integrity = 200
	can_flip = FALSE

/obj/structure/table/modern
	name = "modern table"
	desc = "Obnoxious fiberglass table."
	icon = 'icons/obj/smooth_structures/alien_table.dmi'
	icon_state = "alien_table-0"
	base_icon_state = "alien_table"
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/sheet/iron
	buildstack = /obj/item/stack/sheet/plastic
	framestackamount = 1
	buildstackamount = 1
	smoothing_groups = SMOOTH_GROUP_ABDUCTOR_TABLES
	canSmoothWith = SMOOTH_GROUP_ABDUCTOR_TABLES
