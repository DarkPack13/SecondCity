/datum/preference/choiced/garou_breed
	savefile_key = "garou_breed"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Breed"
	relevant_inherent_trait = TRAIT_VTM_GAROU_BREEDS
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/garou_breed/init_possible_values()
	return assoc_to_keys(GLOB.garou_breeds)

/datum/preference/choiced/garou_breed/icon_for(value)
	var/datum/universal_icon/garou_icon
	switch(value)
		if(BREED_HOMID)
			garou_icon = uni_icon()
		if(BREED_LUPUS)
			garou_icon = uni_icon()
		if(BREED_CRINOS)
			garou_icon = uni_icon()
	return garou_icon

/datum/preference/choiced/garou_breed/apply_to_human(mob/living/carbon/human/target, value)
	target.garou_breed = value

/datum/preference/choiced/ethereal_color/icon_for(value)
	var/static/datum/universal_icon/ethereal_base
	if (isnull(ethereal_base))
		ethereal_base = uni_icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_head")
		ethereal_base.blend_icon(uni_icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_chest"), ICON_OVERLAY)
		ethereal_base.blend_icon(uni_icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_l_arm"), ICON_OVERLAY)
		ethereal_base.blend_icon(uni_icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_r_arm"), ICON_OVERLAY)

		var/datum/universal_icon/eyes = uni_icon('icons/mob/human/human_face.dmi', "eyes_l")
		eyes.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		eyes.blend_color(COLOR_BLACK, ICON_MULTIPLY)
		ethereal_base.blend_icon(eyes, ICON_OVERLAY)

		ethereal_base.scale(64, 64)
		ethereal_base.crop(15, 64 - 31, 15 + 31, 64)

	var/datum/universal_icon/icon = ethereal_base.copy()
	icon.blend_color(GLOB.color_list_ethereal[value], ICON_MULTIPLY)
	return icon
