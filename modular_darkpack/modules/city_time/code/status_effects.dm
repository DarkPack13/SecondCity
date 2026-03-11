/datum/status_effect/day_time_notif
	id = "day_time_notif"
	alert_type = /atom/movable/screen/alert/status_effect/day_time_notif

/atom/movable/screen/alert/status_effect/day_time_notif
	name = "The sun is out"
	desc = "God, you must be tired..."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "asleep"

/atom/movable/screen/alert/status_effect/day_time_notif/examine(mob/user)
	. = ..()
	var/area/my_area = get_area(user)
	. += span_notice("You are currently [my_area.outdoors ? "outdoors" : "indoors"]")
	if(iskindred(user))
		. += span_warning("The sun will sear your flesh and bring final death.")

/datum/status_effect/sunlight_burning
	id = "sunlight_burning"
	alert_type = /atom/movable/screen/alert/status_effect/sunlight_burning

/datum/status_effect/sunlight_burning/on_apply()
	if(!SScity_time.daytime_started)
		return FALSE
	var/area/my_area = get_area(owner)
	if(!istype(my_area) || !my_area.outdoors)
		return FALSE

	var/datum/splat/vampire/kindred/kindred_owner = iskindred(owner)
	if(!kindred_owner)
		return FALSE
	// Humanity 10 vamps are immume to the light. atleast for the amount of time our day lasts.
	if(CONFIG_GET(flag/humanity_sunlight_resistance) && !kindred_owner.enlightenment && (owner.st_get_stat(STAT_MORALITY) >= 10))
		return FALSE

	to_chat(owner, span_danger("THE SUN SEARS YOUR FLESH"))
	return TRUE

/datum/status_effect/sunlight_burning/tick(seconds_per_tick)
	. = ..()
	if(SScity_time.daytime_started)
		var/area/my_area = get_area(owner)
		if(istype(my_area) && my_area.outdoors && iskindred(owner))
			owner.apply_damage(10, BURN)
			return TRUE
	qdel(src)

/atom/movable/screen/alert/status_effect/sunlight_burning
	name = "YOU ARE BURNING FROM THE SUN"
	desc = "Get inside!"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "fire"

/datum/config_entry/flag/humanity_sunlight_resistance
