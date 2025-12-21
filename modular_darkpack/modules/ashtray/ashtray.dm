/obj/item/storage/ashtray
	name = "ashtray"
	desc = "A small bowl for holding and disposing of smokestuffs."
	icon = 'modular_zapoc/modules/apoc_decor/icons/ashtray.dmi'
	icon_state = "ashtray"
	base_icon_state = "ashtray"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	grid_width = 1 GRID_BOXES
	grid_height = 1 GRID_BOXES
	storage_max_columns = 4
	storage_max_rows = 4
	var/recolored = FALSE
	var/newcolor = "#303030"
	var/mutable_appearance/base_ashtray

/obj/item/storage/ashtray/Initialize()
	. = ..()
	color = null

	base_ashtray = mutable_appearance(icon, "[base_icon_state]")
	base_ashtray.color = newcolor

	add_overlay(base_ashtray)

/obj/item/storage/ashtray/proc/evaluate_ashtray_contents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	var/mutable_appearance/overlay_half = mutable_appearance(icon, "[base_icon_state]_overlay-half")
	var/mutable_appearance/overlay_full = mutable_appearance(icon, "[base_icon_state]_overlay-full")

	cut_overlay(list(overlay_half, overlay_full))

	if(contents.len >= STR.max_items/2)
		add_overlay(overlay_half)
	else if(contents.len == STR.max_items)
		add_overlay(overlay_full)

/obj/item/storage/ashtray/Entered()
	. = ..()
	evaluate_ashtray_contents()

/obj/item/storage/ashtray/Exited()
	. = ..()
	evaluate_ashtray_contents()

/obj/item/storage/ashtray/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.set_holdable(
		list(
			/obj/item/match,
			/obj/item/cigbutt,
			/obj/item/clothing/mask/cigarette,
			/obj/item/rollingpaper
			), list(/obj/item/clothing/mask/cigarette/pipe))

/obj/item/storage/ashtray/attack_self(mob/user)
	. = ..()

	if(!recolored)
		var/option_select = alert(user, "Choose an option", "[src]", "Dump", "Recolor", "Don't ask again")
		switch(option_select)
			if("Recolor")

				var/newercolor = input(user, "Choose a Color.","[src]",color) as color

				var/list/rgb = hex2rgb(newercolor)
				var/list/hsl = rgb2hsl(rgb[1], rgb[2], rgb[3])
				var/color_is_dark = hsl[3] < 0.25

				if (color_is_dark)
					to_chat(user, "<span class='warning'>A color that dark on an object like this? Surely not...</span>")
					return

				var/color_confirm = alert(user, "Confirm recolor? This can only be done once!", "[src]", "Yes", "No")

				if(color_confirm == "No")
					return

				newcolor = newercolor
				cut_overlay(base_ashtray)
				base_ashtray.color = newcolor
				add_overlay(base_ashtray)
				recolored = TRUE
			if("Don't ask again")
				recolored = TRUE
			if("Dump")
				dump_ashtray(user)
	else
		dump_ashtray(user)


/obj/item/storage/ashtray/proc/dump_ashtray(mob/user)
	var/ciggie_butts

	if(contents.len)
		user.visible_message(span_notice("[user] dumps [src] out onto the ground."), \
			span_notice("You dump [src] out onto the ground."))
		for(var/i in contents)
			if(istype(i, /obj/item/cigbutt))
				ciggie_butts += 1
				qdel(i)

		if(ciggie_butts > 8)
			new /obj/effect/decal/cleanable/ash/large(get_turf(user))
			ciggie_butts = 0
		else if (ciggie_butts)
			new /obj/effect/decal/cleanable/ash(get_turf(user))
			ciggie_butts = 0

		emptyStorage()
		playsound(user, 'modular_zapoc/master_files/sound/items/cig_snuff.ogg', rand(10,50), TRUE)
	else
		to_chat(user, span_warning("You dump [src] out onto the ground. Too bad it has nothing in it."))
