/// Splats preference
/datum/preference/choiced/splats
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "splats"
	priority = PREFERENCE_PRIORITY_SPECIES
	randomize_by_default = FALSE

/datum/preference/choiced/splats/deserialize(input, datum/preferences/preferences)
	if(input == "none")
		return "none"
	return GLOB.splat_list[sanitize_inlist(input, get_choices_serialized(), "none")]

/datum/preference/choiced/splats/serialize(input)
	if(!ispath(input))
		return "none"
	var/datum/splat/splats = input
	return initial(splats.id)

/datum/preference/choiced/splats/create_default_value()
	return "none"

/datum/preference/choiced/splats/create_random_value(datum/preferences/preferences)
	return pick(get_choices())

/datum/preference/choiced/splats/init_possible_values()
	var/list/values = list()

	for (var/splats_id in get_selectable_splats())
		values += GLOB.splat_list[splats_id]
	values += "none"

	return values

/datum/preference/choiced/splats/apply_to_human(mob/living/carbon/human/target, value)
	if(ispath(value))
		target.add_splat(value)
		// target.add_splat(value, icon_update = FALSE, pref_load = TRUE)

/datum/preference/choiced/splats/compile_constant_data()
	var/list/data = list()

	data["none"] = list()
	data["none"]["name"] = "Nothing"
	data["none"]["desc"] = "A normal human..."
	data["none"]["lore"] = list("You know this one...")
	data["none"]["icon"] = "none"
	data["none"]["perks"] = list(
		SPECIES_POSITIVE_PERK = list(),
		SPECIES_NEUTRAL_PERK = list(),
		SPECIES_NEGATIVE_PERK = list(),
	)

	for (var/splats_id in get_selectable_splats())
		var/splats_type = GLOB.splat_list[splats_id]
		var/datum/splat/splats = GLOB.splat_prototypes[splats_type]

		data[splats_id] = list()
		data[splats_id]["name"] = splats.name
		data[splats_id]["desc"] = splats.get_splats_description()
		data[splats_id]["lore"] = splats.get_splats_lore()
		data[splats_id]["icon"] = sanitize_css_class_name(splats.name)
		// data[splats_id]["use_skintones"] = (TRAIT_USES_SKINTONES in splats.inherent_traits)
		// data[splats_id]["sexes"] = splats.sexes
		// data[splats_id]["enabled_features"] = splats.get_features()
		data[splats_id]["perks"] = splats.get_splats_perks()
		// data[splats_id]["diet"] = splats.get_splats_diet()

	return data
