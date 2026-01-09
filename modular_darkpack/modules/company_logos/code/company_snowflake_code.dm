/proc/snowflake_icon2html(atom/thing, client/target, icon_state, dir = SOUTH, frame = 1, moving = FALSE, sourceonly = FALSE, extra_classes = null, keyonly = FALSE, non_standard_size = FALSE)
	if (!thing)
		return

	var/key
	var/icon/icon2collapse = thing

	if (!target)
		return
	if (target == world)
		target = GLOB.clients

	var/list/targets
	if (!islist(target))
		targets = list(target)
	else
		targets = target
	if(!length(targets))
		return

	//check if the given object is associated with a dmi file in the icons folder. if it is then we don't need to do a lot of work
	//for asset generation to get around byond limitations
	var/icon_path = get_icon_dmi_path(thing)

	if (!isicon(icon2collapse))
		if (isfile(thing)) //special snowflake
			var/name = SANITIZE_FILENAME("[generate_asset_name(thing)].png")
			if (!SSassets.cache[name])
				SSassets.transport.register_asset(name, thing)
			for (var/thing2 in targets)
				SSassets.transport.send_assets(thing2, name)
			if(keyonly)
				return name
			if(sourceonly)
				return SSassets.transport.get_asset_url(name)
			return "<img class='[extra_classes] icon icon-misc' src='[SSassets.transport.get_asset_url(name)]'>"

		//its either an atom, image, or mutable_appearance, we want its icon var
		icon2collapse = thing.icon

		if (isnull(icon_state))
			icon_state = thing.icon_state
			//Despite casting to atom, this code path supports mutable appearances, so let's be nice to them
			if(isnull(icon_state) || (isatom(thing) && thing.flags_1 & HTML_USE_INITAL_ICON_1))
				icon_state = initial(thing.icon_state)
				if (isnull(dir))
					dir = initial(thing.dir)

		if (isnull(dir))
			dir = thing.dir

		// Commented out because this is seemingly our source of bad icon operations
		/* if (ishuman(thing)) // Shitty workaround for a BYOND issue.
			var/icon/temp = icon2collapse
			icon2collapse = icon()
			icon2collapse.Insert(temp, dir = SOUTH)
			dir = SOUTH*/
	else
		if (isnull(dir))
			dir = SOUTH
		if (isnull(icon_state))
			icon_state = ""

	icon2collapse = icon(icon2collapse, icon_state, dir, frame, moving)

	if(!non_standard_size)
		var/width = icon2collapse.Width()
		var/height = icon2collapse.Height()
		if(width != height)
			var/new_dimension = min(width, height)
			snowflake_center_icon(icon2collapse, new_dimension, new_dimension)

	var/list/name_and_ref = generate_and_hash_rsc_file(icon2collapse, icon_path)//pretend that tuples exist

	var/rsc_ref = name_and_ref[1] //weird object thats not even readable to the debugger, represents a reference to the icons rsc entry
	var/file_hash = name_and_ref[2]
	key = "[name_and_ref[3]].png"

	if(!SSassets.cache[key])
		SSassets.transport.register_asset(key, rsc_ref, file_hash, icon_path)
	for (var/client_target in targets)
		SSassets.transport.send_assets(client_target, key)
	if(keyonly)
		return key
	if(sourceonly)
		return SSassets.transport.get_asset_url(key)
	return "<img class='[extra_classes] icon icon-[icon_state]' src='[SSassets.transport.get_asset_url(key)]'>"

/proc/snowflake_center_icon(icon/icon, final_width, final_height)
	var/width = icon.Width() || world.icon_size
	var/height = icon.Height() || world.icon_size

	if(final_width <= 0)
		final_width = width
	if(final_height <= 0)
		final_height = height

	var/left = INFINITY
	var/right = 0
	var/bottom = INFINITY
	var/top = 0

	// Find the inner dimensions (non-alpha pixels)
	for(var/x in 1 to width)
		for(var/y in 1 to height)
			if(icon.GetPixel(x, y))
				left = min(x, left)
				right = max(x, right)
				bottom = min(y, bottom)
				top = max(y, top)

	if(!right)
		// Fully transparent
		icon.Crop(1, 1, final_width, final_height)
		return icon

	var/inner_width = right - left
	var/inner_height = top - bottom
	var/left_padding = left - floor((final_width - inner_width) * 0.5)
	var/bottom_padding = bottom - floor((final_height - inner_height) * 0.5)

	icon.Crop(left_padding, bottom_padding, left_padding + final_width - 1, bottom_padding + final_height - 1)
	return icon
