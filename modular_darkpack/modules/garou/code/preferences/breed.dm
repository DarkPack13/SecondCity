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
			garou_icon = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_head_m")
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_chest_m"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_arm"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_arm"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_leg"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_leg"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_hand"), ICON_OVERLAY)
			garou_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_hand"), ICON_OVERLAY)
			garou_icon.blend_color(skintone2hex("caucasian1"), ICON_MULTIPLY)
		if(BREED_LUPUS)
			garou_icon = uni_icon('modular_darkpack/modules/garou/icons/lupus.dmi', "black")
		if(BREED_CRINOS)
			garou_icon = uni_icon('modular_darkpack/modules/garou/icons/crinos.dmi', "black")
			garou_icon.scale(64, 64)
	return garou_icon

/datum/preference/choiced/garou_breed/apply_to_human(mob/living/carbon/human/target, value)
	target.garou_breed = value
