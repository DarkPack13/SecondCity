/// Current phase of the moon, randomly chosen
GLOBAL_VAR_INIT(moon_state, get_moon_phase())

#define LUNAR_CYCLE 29.530588
/proc/get_moon_phase()
	// First known fullmoon since the BYOND EPOCH.
	var/ref_year = 2000
	var/ref_month = 1
	var/ref_day = 20

	var/year = text2num(station_time_timestamp("YYYY"))
	var/month = text2num(station_time_timestamp("MM"))
	var/day = text2num(station_time_timestamp("DD"))

	var/ref_days = ref_year * 365 + ref_month * 30 + ref_day
	var/current_days = year * 365 + month * 30 + day

	var/days_since_full = current_days - ref_days

	var/phase_day = days_since_full % LUNAR_CYCLE
	if(phase_day < 0)
		phase_day += LUNAR_CYCLE

	return moon_phase_name(phase_day)
#undef LUNAR_CYCLE

/proc/moon_phase_name(phase_day)
	if(phase_day < 1.84566)
		return MOON_NEW
	if(phase_day < 5.53699)
		return MOON_WAXING_CRESENT
	if(phase_day < 9.22831)
		return MOON_FIRST_QUARTER
	if(phase_day < 12.91963)
		return MOON_WAXING_GIBBOUS
	if(phase_day < 16.61096)
		return MOON_FULL
	if(phase_day < 20.30228)
		return MOON_WANING_GIBBOUS
	if(phase_day < 23.99361)
		return MOON_LAST_QUARTER
	if(phase_day < 27.68493)
		return MOON_WANING_CRESCENT
	return MOON_FULL

/// List of all Tribe totems
GLOBAL_LIST_EMPTY(totems)


/// Associative list of auspice names to typepaths
GLOBAL_LIST_INIT(auspices_list, init_subsplat_list(/datum/subsplat/werewolf/auspice))
/// Associative list of auspice typepaths to singletons
GLOBAL_LIST_INIT_TYPED(auspices, /datum/subsplat/werewolf/auspice, init_subtypes_w_path_keys(/datum/subsplat/werewolf/auspice, list()))

/// Associative list of tribe names to typepaths
GLOBAL_LIST_INIT(tribes_list, init_subsplat_list(/datum/subsplat/werewolf/tribe))
/// Associative list of tribe typepaths to singletons
GLOBAL_LIST_INIT_TYPED(fera_tribes, /datum/subsplat/werewolf/tribe, init_subtypes_w_path_keys(/datum/subsplat/werewolf/tribe, list()))

/// Associative list of breed form names to typepaths
GLOBAL_LIST_INIT(breed_forms_list, init_subsplat_list(/datum/subsplat/werewolf/breed_form))
/// Associative list of breed_form typepaths to singletons
GLOBAL_LIST_INIT_TYPED(breed_forms, /datum/subsplat/werewolf/breed_form, init_subtypes_w_path_keys(/datum/subsplat/werewolf/breed_form, list()))

GLOBAL_LIST_INIT(glyph_list, init_glyphs())
