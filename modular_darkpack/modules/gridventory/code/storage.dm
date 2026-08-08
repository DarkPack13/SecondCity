/datum/storage/proc/get_grid_box_size()
	return world.icon_size

/// Returns the anchor coordinate string ("x,y") an item is placed at, or null.
/datum/storage/proc/item_to_grid_anchor(obj/item/thing)
	var/list/coords = LAZYACCESS(first_coordinates_item, thing)
	if(!coords)
		return null
	return "[coords[1]],[coords[2]]"

/datum/storage/proc/screen_loc_to_grid_coordinates(screen_loc)
	if(!grid)
		return FALSE

	var/click_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/click_pixel_x = text2num(copytext(click_x, findtext(click_x, ":") + 1))
	click_x = text2num(copytext(click_x, 1, findtext(click_x, ":")))

	var/click_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/click_pixel_y = text2num(copytext(click_y, findtext(click_y, ":") + 1))
	click_y = text2num(copytext(click_y, 1, findtext(click_y, ":")))

	var/screen_x_pixels = (click_x * world.icon_size) + click_pixel_x
	screen_x_pixels -= (src.screen_start_x * world.icon_size) + src.screen_pixel_x
	screen_x_pixels = FLOOR(screen_x_pixels / grid_box_size, 1)

	var/screen_y_pixels = (click_y * world.icon_size) + click_pixel_y
	screen_y_pixels -= (src.screen_start_y * world.icon_size) + src.screen_pixel_y
	screen_y_pixels = FLOOR(screen_y_pixels / grid_box_size, 1)

	return "[screen_x_pixels],[screen_y_pixels]"

/**
 * Converts a grid coordinate string into a screen_loc.
 * If an item is passed, centers larger-than-1-cell items the same way the old code did.
 */
/datum/storage/proc/grid_coordinates_to_screen_loc(coordinates, obj/item/sized_for)
	if(!grid)
		return FALSE

	var/coordinate_x = text2num(copytext(coordinates, 1, findtext(coordinates, ",")))
	var/coordinate_y = text2num(copytext(coordinates, findtext(coordinates, ",") + 1))

	var/screen_x_pixels = (coordinate_x * grid_box_size) + (src.screen_start_x * world.icon_size) + src.screen_pixel_x
	var/screen_y_pixels = (coordinate_y * grid_box_size) + (src.screen_start_y * world.icon_size) + src.screen_pixel_y

	if(sized_for)
		var/used_gridwidth = get_used_grid_size(sized_for, TRUE)
		var/used_gridheight = get_used_grid_size(sized_for, FALSE)
		screen_x_pixels += (world.icon_size / 2) * ((used_gridwidth / world.icon_size) - 1)
		screen_y_pixels += (world.icon_size / 2) * ((used_gridheight / world.icon_size) - 1)

	var/screen_x = FLOOR(screen_x_pixels / world.icon_size, 1)
	var/final_pixel_x = FLOOR(screen_x_pixels - FLOOR(screen_x_pixels, world.icon_size), 1)
	var/screen_y = FLOOR(screen_y_pixels / world.icon_size, 1)
	var/final_pixel_y = FLOOR(screen_y_pixels - FLOOR(screen_y_pixels, world.icon_size), 1)

	return "[screen_x]:[final_pixel_x],[screen_y]:[final_pixel_y]"

/// Handles the dimensional_shrink enchantment shrinking an item's effective grid footprint.
/datum/storage/proc/get_used_grid_size(obj/item/thing, width = TRUE)
	var/size = width ? thing.grid_width : thing.grid_height
	return size

/datum/storage/proc/validate_grid_coordinates(coordinates, grid_width = world.icon_size, grid_height = world.icon_size, obj/item/dragged_item)
	if(!grid)
		return FALSE
	var/grid_box_ratio = world.icon_size / grid_box_size
	var/screen_x = text2num(copytext(coordinates, 1, findtext(coordinates, ",")))
	var/screen_y = text2num(copytext(coordinates, findtext(coordinates, ",") + 1))

	var/validate_x = FLOOR((grid_width / grid_box_size) - 1, 1)
	var/validate_y = FLOOR((grid_height / grid_box_size) - 1, 1)

	for(var/current_x in 0 to validate_x)
		for(var/current_y in 0 to validate_y)
			var/final_x = screen_x + current_x
			var/final_y = screen_y + current_y
			var/final_coordinates = "[final_x],[final_y]"
			if(final_x >= (screen_max_columns * grid_box_ratio))
				return FALSE
			if(final_y >= (screen_max_rows * grid_box_ratio))
				return FALSE
			var/existing_item = LAZYACCESS(grid_coordinates_to_item, final_coordinates)
			if(existing_item && (!dragged_item || existing_item != dragged_item))
				return FALSE
	return TRUE

/// Finds the first open coordinate that fits an item's footprint, or null if none.
/datum/storage/proc/find_first_open_grid_coordinates(obj/item/thing)
	var/grid_box_ratio = world.icon_size / grid_box_size
	var/used_gridwidth = get_used_grid_size(thing, TRUE)
	var/used_gridheight = get_used_grid_size(thing, FALSE)
	for(var/current_y in 0 to ((screen_max_rows * grid_box_ratio) - 1))
		for(var/current_x in 0 to ((screen_max_columns * grid_box_ratio) - 1))
			var/candidate = "[current_x],[current_y]"
			if(validate_grid_coordinates(candidate, used_gridwidth, used_gridheight, thing))
				return candidate
	return null

/datum/storage/proc/grid_add_item(obj/item/storing, coordinates)
	var/coordinate_x = text2num(copytext(coordinates, 1, findtext(coordinates, ",")))
	var/coordinate_y = text2num(copytext(coordinates, findtext(coordinates, ",") + 1))
	LAZYSET(first_coordinates_item, storing, list(coordinate_x, coordinate_y))

	var/used_gridwidth = get_used_grid_size(storing, TRUE)
	var/used_gridheight = get_used_grid_size(storing, FALSE)
	for(var/current_x in 0 to FLOOR((used_gridwidth / grid_box_size) - 1, 1))
		for(var/current_y in 0 to FLOOR((used_gridheight / grid_box_size) - 1, 1))
			var/calculated = "[coordinate_x + current_x],[coordinate_y + current_y]"
			LAZYADDASSOCLIST(grid_coordinates_to_item, calculated, storing)
			LAZYINITLIST(item_to_grid_coordinates)
			LAZYINITLIST(item_to_grid_coordinates[storing])
			LAZYADD(item_to_grid_coordinates[storing], calculated)


/datum/storage/proc/grid_remove_item(obj/item/removed)
	LAZYREMOVE(first_coordinates_item, removed)
	if(!LAZYACCESS(item_to_grid_coordinates, removed))
		return FALSE
	for(var/location in item_to_grid_coordinates[removed])
		LAZYREMOVE(grid_coordinates_to_item, location)
	LAZYREMOVE(item_to_grid_coordinates, removed)
	removed.underlays = null
	return TRUE

/datum/storage/proc/get_bound_underlay(obj/item/thing)
	var/used_gridwidth = get_used_grid_size(thing, TRUE)
	var/used_gridheight = get_used_grid_size(thing, FALSE)
	var/key = "[used_gridwidth]x[used_gridheight]"
	. = LAZYACCESS(underlay_appearances_by_size, key)
	if(!.)
		. = generate_bound_underlay(used_gridwidth, used_gridheight)
		underlay_appearances_by_size[key] = .

/// Ported as-is from the old component; builds and caches the sized bound-box underlay icon.
/datum/storage/proc/generate_bound_underlay(grid_width = world.icon_size, grid_height = world.icon_size)
	var/mutable_appearance/final_appearance = mutable_appearance()
	final_appearance.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	var/icon/final_icon = icon('icons/hud/storage.dmi', "blank")
	final_icon.Scale(grid_width, grid_height)

	var/static/list/scale_both = list("block_under")
	var/static/list/scale_x_states = list("up", "down")
	var/static/list/scale_y_states = list("right", "left")

	var/width_offset = world.icon_size * ((grid_width / world.icon_size) - 1)
	var/height_offset = world.icon_size * ((grid_height / world.icon_size) - 1)

	var/icon/scaled_icon
	for(var/scaled_both in scale_both)
		scaled_icon = icon('icons/hud/storage.dmi', scaled_both)
		scaled_icon.Scale(grid_width, grid_height)
		final_icon.Blend(scaled_icon, ICON_OVERLAY)

	var/multiplier = 0
	for(var/scaled_x in scale_x_states)
		multiplier = !multiplier
		scaled_icon = icon('icons/hud/storage.dmi', scaled_x)
		scaled_icon.Scale(grid_width, world.icon_size)
		final_icon.Blend(scaled_icon, ICON_OVERLAY, 1, 1 + (height_offset * multiplier))

	multiplier = 0
	for(var/scaled_y in scale_y_states)
		multiplier = !multiplier
		scaled_icon = icon('icons/hud/storage.dmi', scaled_y)
		scaled_icon.Scale(world.icon_size, grid_height)
		final_icon.Blend(scaled_icon, ICON_OVERLAY, 1 + (width_offset * multiplier), 1)

	var/corner_pos_x = 1 + (grid_width - world.icon_size)
	var/corner_pos_y = 1 + (grid_height - world.icon_size)
	final_icon.Blend(icon('icons/hud/storage.dmi', "corner_left_down"), ICON_OVERLAY, 1, 1)
	final_icon.Blend(icon('icons/hud/storage.dmi', "corner_right_down"), ICON_OVERLAY, corner_pos_x, 1)
	final_icon.Blend(icon('icons/hud/storage.dmi', "corner_left_up"), ICON_OVERLAY, 1, corner_pos_y)
	final_icon.Blend(icon('icons/hud/storage.dmi', "corner_right_up"), ICON_OVERLAY, corner_pos_x, corner_pos_y)

	final_appearance.icon = final_icon
	final_appearance.transform = final_appearance.transform.Translate(-width_offset / 2, -height_offset / 2)
	return final_appearance
