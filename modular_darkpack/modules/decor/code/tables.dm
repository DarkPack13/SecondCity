
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

/obj/structure/table/countertop
	name = "countertop"
	desc = "A countertop with a solid base."
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	abstract_type = /obj/structure/table/countertop
	max_integrity = 200
	can_flip = FALSE

/obj/structure/table/countertop/bubway
	desc = "A corperate countertop for serving food."
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	smoothing_groups = SMOOTH_GROUP_BUB_TABLES
	canSmoothWith = SMOOTH_GROUP_BUB_TABLES


/obj/structure/table/countertop/bacotell
	desc = "A corperate countertop for serving food."
	icon = 'icons/obj/smooth_structures/darkpack/bacotell_table.dmi'
	icon_state = "bacotell_table-0"
	base_icon_state = "bacotell_table"
	smoothing_groups = SMOOTH_GROUP_BACO_TABLES
	canSmoothWith = SMOOTH_GROUP_BACO_TABLES

/obj/structure/table/countertop/beige
	icon = 'icons/obj/smooth_structures/beigetop_table.dmi'
	icon_state = "beigetop_table-0"
	base_icon_state = "beigetop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/black
	icon = 'icons/obj/smooth_structures/blacktop_table.dmi'
	icon_state = "blacktop_table-0"
	base_icon_state = "blacktop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/green
	icon = 'icons/obj/smooth_structures/greentop_table.dmi'
	icon_state = "greentop_table-0"
	base_icon_state = "greentop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/purple
	icon = 'icons/obj/smooth_structures/purpletop_table.dmi'
	icon_state = "purpletop_table-0"
	base_icon_state = "purpletop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/red
	icon = 'icons/obj/smooth_structures/redtop_table.dmi'
	icon_state = "redtop_table-0"
	base_icon_state = "redtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/teal
	icon = 'icons/obj/smooth_structures/tealtop_table.dmi'
	icon_state = "tealtop_table-0"
	base_icon_state = "tealtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/yellow
	icon = 'icons/obj/smooth_structures/yellowtop_table.dmi'
	icon_state = "yellowtop_table-0"
	base_icon_state = "yellowtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/fastfood
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table.dmi'
	icon_state = "fastfood_table-0"
	base_icon_state = "fastfood_table"
	smoothing_groups = SMOOTH_GROUP_FF_TABLES
	canSmoothWith = SMOOTH_GROUP_FF_TABLES

/obj/structure/table/countertop/fastfood/addon1
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi'
	icon_state = "fastfood_table_addon1-0"
	base_icon_state = "fastfood_table_addon1"

/obj/structure/table/countertop/fastfood/addon2
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi'
	icon_state = "fastfood_table_addon2-0"
	base_icon_state = "fastfood_table_addon2"

/obj/structure/table/countertop/fastfood/addon3
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi'
	icon_state = "fastfood_table_addon3-0"
	base_icon_state = "fastfood_table_addon3"

/obj/structure/table/countertop/fastfood/rand // Should probably use sparingly...
	var/list/possible_icons = list('icons/obj/smooth_structures/darkpack/fastfood_table.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi')
	var/list/possible_icon_states = list("fastfood_table-0", "fastfood_table_addon1-0",
		"fastfood_table_addon2-0", "fastfood_table_addon3-0")
	var/list/possible_base_icon_states = list("fastfood_table", "fastfood_table_addon1",
		"fastfood_table_addon2", "fastfood_table_addon3")

/obj/structure/table/countertop/fastfood/rand/Initialize(mapload)
	. = ..()
	icon = pick(possible_icons)
	icon_state = possible_icon_states[possible_icons.Find(icon)]
	base_icon_state = possible_base_icon_states[possible_icons.Find(icon)]
