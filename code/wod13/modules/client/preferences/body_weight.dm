/datum/preference/choiced/body_weight
	savefile_key = "body_weight"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRORITY_LATE_BODY_TYPE
	main_feature_name = "Weight"
	should_generate_icons = TRUE

	var/list/options_to_sprites = list(
		"Slim" = SLIM_BODY_WEIGHT,
		"Average" = AVERAGE_BODY_WEIGHT,
		"Fat" = FAT_BODY_WEIGHT
	)

/datum/preference/choiced/body_weight/init_possible_values()
	return assoc_to_keys(options_to_sprites)

/datum/preference/choiced/body_weight/icon_for(value)
	var/sprite_name = options_to_sprites[value]
	var/datum/universal_icon/universal_icon = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "[sprite_name]human_chest_m")

	// Hardcoded sprite sizes so they all fill the same space more or less
	switch (sprite_name)
		if (SLIM_BODY_WEIGHT)
			universal_icon.crop(10, 10, 22, 22)
		if (AVERAGE_BODY_WEIGHT)
			universal_icon.crop(9, 9, 23, 23)
		if (FAT_BODY_WEIGHT)
			universal_icon.crop(8, 7, 24, 23)
	universal_icon.scale(32, 32)

	return universal_icon

/datum/preference/choiced/body_weight/apply_to_human(mob/living/carbon/human/target, value)
	var/sprite_name = options_to_sprites[value]
	target.set_body_weight(sprite_name)
