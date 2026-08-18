/obj/structure/railing/darkpack
	icon_state = null
	icon = 'modular_darkpack/modules/decor/icons/railings.dmi'
	abstract_type = /obj/structure/railing/darkpack

/obj/structure/railing/darkpack/metal
	name = "guard rail"
	desc = "A sturdy rail setup with multiple functions, including but not limited to: ensuring you dont fly off the top of a four story tall building"
	icon_state = "civ_full"

/obj/structure/railing/darkpack/metal/solo
	icon_state = "civ_solo"

/obj/structure/railing/darkpack/metal/industrial
	desc = "A sturdy rail setup with multiple functions, including but not limited to: ensuring you dont fly off the top of a four story tall building. It's got a slick orange taint, so you know it's to workplace regulations."
	icon_state = "indus_full"

/obj/structure/railing/darkpack/metal/industrial/solo
	icon_state = "indus_solo"

/obj/structure/railing/darkpack/sewer
	name = "guard rail"
	desc = "A rusty guard rail used to prevent you from falling into the region's sewage. Thank the lord it's there."
	icon_state = "railings_sewer"

/obj/structure/railing/darkpack/wood
	name = "wooden fence"
	desc = "A classic wooden fence. It doesn't get more homely than this."
	icon_state = "wood_full"
	base_icon_state = "wood_full"
	item_deconstruct = /obj/item/stack/sheet/mineral/wood
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/railing/darkpack/wood/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[base_icon_state]_snow"

/obj/structure/railing/darkpack/wood/ending
	icon_state = "wood_end"
	base_icon_state = "wood_end"

/obj/structure/railing/darkpack/wood/single
	icon_state = "wood_solo"
	base_icon_state = "wood_solo"

/obj/structure/railing/darkpack/wood/snow
	icon_state = "wood_snow_full"

/obj/structure/railing/darkpack/wood/snow/ending
	icon_state = "wood_snow_end"

/obj/structure/railing/darkpack/wood/snow/single
	icon_state = "wood_snow_solo"
