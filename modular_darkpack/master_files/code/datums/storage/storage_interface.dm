/datum/storage_interface
	var/atom/movable/screen/storage_hover/hovering

/datum/storage_interface/proc/update_hover(mob/user, params)
	if(!user.client)
		return
	user.client.screen -= hovering

	if(! parent_storage.can_be_reached_by(user) || !isliving(user))
		return
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item)
		return

	var/list/modifiers = params2list(params)
	var/screen_loc = LAZYACCESS(modifiers, SCREEN_LOC)
	var/coordinates = parent_storage.screen_loc_to_grid_coordinates(screen_loc)
	if(!coordinates)
		return

	var/used_gridwidth = parent_storage.get_used_grid_size(held_item, TRUE)
	var/used_gridheight = parent_storage.get_used_grid_size(held_item, FALSE)

	if(parent_storage.validate_grid_coordinates(coordinates, used_gridwidth, used_gridheight, held_item))
		hovering.color = COLOR_ASSEMBLY_GOLD
	else
		hovering.color = COLOR_RED_LIGHT

	hovering.transform = matrix()
	hovering.users |= user.client
	var/scale_x = used_gridwidth / world.icon_size
	var/scale_y = used_gridheight / world.icon_size
	hovering.transform = hovering.transform.Scale(scale_x, scale_y)
	var/translate_x = (world.icon_size / 2) * (scale_x - 1)
	var/translate_y = (world.icon_size / 2) * (scale_y - 1)
	hovering.transform = hovering.transform.Translate(translate_x, translate_y)

	hovering.screen_loc = parent_storage.grid_coordinates_to_screen_loc(coordinates)
	user.client.screen |= hovering

/datum/storage_interface/proc/add_items_grid(screen_start_x, screen_pixel_x, screen_start_y, screen_pixel_y, atom/real_location)
	var/turf/our_turf = get_turf(real_location)

	for(var/obj/item/thing as anything in real_location)
		if(QDELETED(thing))
			continue

		var/anchor = parent_storage.item_to_grid_anchor(thing)
		if(!anchor)
			continue // shouldn't happen once grid_add_item is called on insert, but don't render orphans

		thing.mouse_opacity = MOUSE_OPACITY_OPAQUE

		var/mutable_appearance/bound_underlay = parent_storage.get_bound_underlay(thing)
		thing.underlays = list(bound_underlay)

		thing.screen_loc = parent_storage.grid_coordinates_to_screen_loc(anchor, thing)
		SET_PLANE(thing, ABOVE_HUD_PLANE, our_turf)

		if(parent_storage.numerical_stacking)
			thing.maptext = "" // grid mode doesn't stack visually; each item occupies its own footprint

