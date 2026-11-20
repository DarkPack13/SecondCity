
/// US States
/datum/preference/choiced/state_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "state_of_origin"
	priority = /datum/preference/choiced/country_of_origin::priority + 0.1
	can_randomize = FALSE
	must_be_accessible = TRUE

/datum/preference/choiced/state_of_origin/init_possible_values()
	return list(
		"Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
		"Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
		"Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
		"New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
		"South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming",
		"District of Columbia", "Puerto Rico", "Guam", "U.S. Virgin Islands", "American Samoa", "Northern Mariana Islands"
	)

/datum/preference/choiced/state_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(80))
		return ..()
	return pick(cached_values)

/datum/preference/choiced/state_of_origin/create_default_value()
	return DEFAULT_STATE_NAME

/datum/preference/choiced/state_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.state_of_origin = value

/datum/preference/choiced/state_of_origin/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/country = preferences.read_preference(/datum/preference/choiced/country_of_origin)
	return (country == "United States")

/// Canadian Provinces
/datum/preference/choiced/province_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "province_of_origin"
	priority = /datum/preference/choiced/country_of_origin::priority + 0.1
	can_randomize = FALSE
	must_be_accessible = TRUE

/datum/preference/choiced/province_of_origin/init_possible_values()
	return list(
		"British Columbia", "Alberta", "Saskatchewan", "Manitoba", "Ontario", "Quebec", "New Brunswick",
		"Nova Scotia", "Prince Edward Island", "Newfoundland and Labrador", "Yukon", "Northwest Territories",
		"Nunvaut",
	)

/datum/preference/choiced/province_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(50))
		return ..()
	return pick(cached_values)

/datum/preference/choiced/province_of_origin/create_default_value()
	return "Ontario"

/datum/preference/choiced/province_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/static/list/province_language_map
	if(!province_language_map)
		province_language_map = list(
			// french-speaking provinces
			"Quebec" = list(/datum/language/french),
			"New Brunswick" = list(/datum/language/french),
			"Yukon" = list(/datum/language/french),
		)
	var/list/languages = province_language_map[value]
	if(!languages)
		return
	for(var/language_type in languages)
		if(target.has_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE))
			continue
		target.grant_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE, source = "province_of_origin")

/datum/preference/choiced/province_of_origin/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/country = preferences.read_preference(/datum/preference/choiced/country_of_origin)
	return (country == "Canada")

/// UK Nations
/datum/preference/choiced/nation_of_origin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "nation_of_origin"
	priority = /datum/preference/choiced/country_of_origin::priority + 0.1
	can_randomize = FALSE
	must_be_accessible = TRUE

/datum/preference/choiced/nation_of_origin/init_possible_values()
	return list(
		"England", "Wales", "Scotland", "Northern Ireland"
	)

/datum/preference/choiced/nation_of_origin/create_informed_default_value(datum/preferences/preferences)
	if(prob(50))
		return ..()
	return pick(cached_values)

/datum/preference/choiced/nation_of_origin/create_default_value()
	return "England"

/datum/preference/choiced/nation_of_origin/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/static/list/nation_language_map
	if(!nation_language_map)
		nation_language_map = list(
			"Wales" = list(/datum/language/welsh),
			"Scotland" = list(/datum/language/scottish),
			"Northern Ireland" = list(/datum/language/irish),
		)
	var/list/languages = nation_language_map[value]
	if(!languages)
		return
	for(var/language_type in languages)
		if(target.has_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE))
			continue
		target.grant_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE, source = "nation_of_origin")

/datum/preference/choiced/nation_of_origin/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/country = preferences.read_preference(/datum/preference/choiced/country_of_origin)
	return (country == "United Kingdom")
