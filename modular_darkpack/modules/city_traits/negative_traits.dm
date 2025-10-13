/datum/station_trait/thunder_storm
	name = "Thunder Storm"
	trait_type = STATION_TRAIT_NEGATIVE
	darkpack_allowed = TRUE

/datum/station_trait/thunder_storm/on_round_start()
	SSweather.run_weather(/datum/weather/rain_storm/eternal)

/datum/weather/rain_storm/eternal
	probability = 0
	turf_weather_chance = 0.0001
	turf_thunder_chance = THUNDER_CHANCE_RARE
	weather_duration_lower = INFINITY
	weather_duration_upper = INFINITY
