ADMIN_VERB(set_end_time, R_ADMIN, "Set End Time", "Set time for round to end", "Server")
	var/newtime = tgui_input_number(usr, "Set a new time for round to end in (in game) minutes","Set End Time",round(SScity_time.time_till_roundend/600))
	if(newtime)
		SScity_time.time_till_roundend = newtime*600
		log_admin("[key_name(usr)] set end time.")
		message_admins("[key_name_admin(usr)] has set end time to [SScity_time.time_till_roundend]/[DisplayTimeText(SScity_time.time_till_roundend)].")

ADMIN_VERB(set_day_time, R_ADMIN, "Set Day Time", "Set time for day to start", "Server")
	var/newtime = tgui_input_number(usr, "Set a new time for daytime to start in (in game) minutes","Set End Time",round(SScity_time.time_till_daytime/600))
	if(newtime)
		SScity_time.time_till_daytime = newtime*600
		log_admin("[key_name(usr)] set day time.")
		message_admins("[key_name_admin(usr)] has set day time to [SScity_time.time_till_daytime]/[DisplayTimeText(SScity_time.time_till_daytime)].")

ADMIN_VERB(admin_set_starlight, R_FUN, "Set Starlight", "Set base starlight.", ADMIN_CATEGORY_EVENTS)
	var/star_color = input(user, "", "Choose Color", GLOB.base_starlight_color) as color
	var/star_range = tgui_input_number(user, "Choose light range", "Light Range", default = GLOB.starlight_range, round_value = FALSE)
	var/star_power = tgui_input_number(user, "Choose light power", "Light Power", default = GLOB.starlight_power, round_value = FALSE)

	set_base_starlight(star_color, star_range, star_power)
