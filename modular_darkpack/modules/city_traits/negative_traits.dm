/datum/station_trait/thunder_storm
	name = "Thunder Storm"
	trait_type = STATION_TRAIT_NEGATIVE
	darkpack_allowed = TRUE

/datum/station_trait/thunder_storm/on_round_start()
	SSweather.run_weather(/datum/weather/rain_storm/endless)

/datum/weather/rain_storm/endless
	probability = 0
	turf_weather_chance = 0.0001
	turf_thunder_chance = THUNDER_CHANCE_RARE
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS
