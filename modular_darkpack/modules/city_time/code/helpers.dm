///returns the current IC station time in a world.time format
/proc/city_time(wtime = world.time)
	return (((wtime - SSticker.round_start_time) * SSticker.city_time_rate_multiplier) + SSticker.gametime_offset) % (24 HOURS)

/* // use server_timestamp(ic_time = TRUE)
///returns the current IC station time in a human readable format
/proc/city_time_timestamp(format = "hh:mm:ss", wtime)
	return time2text(city_time(wtime), format, NO_TIMEZONE)
*/

/proc/city_time_passed(display_only = FALSE, wtime=world.time)
	return ((((wtime - SSticker.round_start_time) * SSticker.city_time_rate_multiplier)) % 864000) - (display_only? GLOB.timezoneOffset : 0)
