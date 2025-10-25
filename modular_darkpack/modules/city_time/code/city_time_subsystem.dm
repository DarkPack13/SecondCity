/proc/station_time_passed(display_only = FALSE, wtime=world.time)
	return ((((wtime - SSticker.round_start_time) * SSticker.station_time_rate_multiplier)) % 864000) - (display_only? GLOB.timezoneOffset : 0)

SUBSYSTEM_DEF(city_time)
	name = "City Time"
	wait = 5 SECONDS
	priority = FIRE_PRIORITY_DEFAULT

	var/first_warning = FALSE
	var/second_warning = FALSE
	var/time_till_daytime = 5.5 HOURS
	var/daytime_started = FALSE

	var/time_till_roundend = 6.5 HOURS
	var/roundend_started = FALSE

	var/last_xp_drop = 0
	/// Time between xp drops in INGAME time
	var/time_between_xp_drops = 1 HOURS

	/// If the light color is currently shifting. Stops another transition from starting.
	var/shifting_colors = FALSE

/datum/controller/subsystem/city_time/Initialize(start_timeofday)
	. = ..()
	time_till_daytime = CONFIG_GET(number/time_till_day)
	time_till_roundend = CONFIG_GET(number/time_till_roundend)

/datum/controller/subsystem/city_time/fire()
	// TODO: [Rebase] - Move XP gains onto its own subsystem
	if(last_xp_drop + time_between_xp_drops < station_time_passed())
		last_xp_drop = station_time_passed()
		/*
		for(var/mob/living/carbon/werewolf/W in GLOB.player_list)
			if(W?.stat != DEAD && W?.key)
				var/datum/preferences/char_sheet = GLOB.preferences_datums[ckey(W.key)]
				char_sheet?.add_experience(2)
		*/
		/*
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H?.stat != DEAD && H?.key)
				var/datum/preferences/char_sheet = GLOB.preferences_datums[ckey(H.key)]
				if(char_sheet)
					char_sheet.add_experience(2)

					var/role = H.mind?.assigned_role

					if(role in list("Prince", "Sheriff", "Hound", "Seneschal", "Chantry Regent", "Baron", "Dealer", "Primogen Ventrue", "Primogen Lasombra", "Primogen Banu Haqim", "Primogen Nosferatu", "Primogen Malkavian", "Endron Branch Lead", "Endron Internal Affairs Agent", "Endron Executive", "Endron Chief of Security", "Painted City Councillor", "Painted City Keeper", "Painted City Warder", "Painted City Truthcatcher", "Amberlgade Councillor", "Amberglade Keeper", "Amberglade Truthcatcher", "Amberglade Warder"))
						char_sheet.add_experience(2)

					if(!HAS_TRAIT(H, TRAIT_NON_INT))
						if(H.total_erp > 3000)
							char_sheet.add_experience(3)
							H.total_erp = 0
						if(H.total_erp > 1500)
							char_sheet.add_experience(2)
							H.total_erp = 0
						if(H.total_cleaned > 25)
							char_sheet.add_experience(1)
							H.total_cleaned = 0
						if(role == "Graveyard Keeper")
							if(SSgraveyard.total_good > SSgraveyard.total_bad)
								char_sheet.add_experience(1)

					char_sheet.save_preferences()
					char_sheet.save_character()
	*/

	if(station_time_passed() > time_till_daytime - 30 MINUTES && !first_warning && !shifting_colors)
		first_warning = TRUE
		shifting_colors = TRUE
		transition_light("#584d88")
		to_chat(world, span_ghostalert("The night is ending..."))

	if(station_time_passed() > time_till_daytime - 15 MINUTES && !second_warning && !shifting_colors)
		second_warning = TRUE
		shifting_colors = TRUE
		transition_light("#dd80b0")
		to_chat(world, span_ghostalert("First rays of the sun illuminate the sky..."))

	if(station_time_passed() > time_till_daytime && !daytime_started && !shifting_colors)
		daytime_started = TRUE
		shifting_colors = TRUE
		transition_light("#faeacb", 1, 0.75)
		to_chat(world, span_ghostalert("THE NIGHT IS OVER."))

	if(station_time_passed() > time_till_roundend && !roundend_started)
		roundend_started = TRUE

	if(daytime_started)
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			H.apply_status_effect(/datum/status_effect/day_time_notif)
			H.apply_status_effect(/datum/status_effect/sunlight_burning)

/datum/controller/subsystem/city_time/proc/extend_round(amount)
	time_till_daytime += amount * SSticker.station_time_rate_multiplier
	time_till_roundend += amount * SSticker.station_time_rate_multiplier
	log_admin("the round was extended to [SScity_time.time_till_roundend]/[DisplayTimeText(SScity_time.time_till_roundend)].")
	message_admins("the round was extended to [SScity_time.time_till_roundend]/[DisplayTimeText(SScity_time.time_till_roundend)].")

/// Full length of time it takes to transition the lights
#define TRANSITION_TIME 2.5 MINUTES
/// How many cycles the transition is broken up into. Expensive to increase but makes the transition smoother
#define COLOR_CYCLES 15
/datum/controller/subsystem/city_time/proc/transition_light(end_color = GLOB.base_starlight_color, end_range = GLOB.starlight_range, end_power = GLOB.starlight_power)
	set waitfor = FALSE
	var/start_color = GLOB.base_starlight_color
	var/start_range = GLOB.starlight_range
	var/start_power = GLOB.starlight_power

	for(var/i in 1 to COLOR_CYCLES)
		var/walked_color = hsl_gradient(i/COLOR_CYCLES, 0, start_color, 1, end_color)
		var/walked_range = LERP(start_range, end_range, i/COLOR_CYCLES)
		var/walked_power = LERP(start_power, end_power, i/COLOR_CYCLES)
		set_starlight(walked_color, walked_range, walked_power)
		sleep(TRANSITION_TIME/COLOR_CYCLES)
	set_base_starlight(end_color, end_range, end_power)
	shifting_colors = FALSE
#undef COLOR_CYCLES
#undef TRANSITION_TIME
