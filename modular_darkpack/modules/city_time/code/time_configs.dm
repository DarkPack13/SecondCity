/// The difference betwen midnight (of the host computer) and 0 world.ticks.
GLOBAL_VAR_INIT(timezoneOffset, 0)

/datum/config_entry/number/shift_time_start_hour
	default = 12
	min_val = 0
	max_val = 23

// In deciseconds and using city_time_rate_multiplier
/datum/config_entry/number/time_till_day
	default = 198000
	protection = CONFIG_ENTRY_LOCKED

// In deciseconds and using city_time_rate_multiplier
/datum/config_entry/number/time_till_roundend
	default = 216000
	protection = CONFIG_ENTRY_LOCKED
