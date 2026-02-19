/datum/preference/choiced/garou_breed
	savefile_key = "garou_breed"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Breed"
	relevant_inherent_trait = TRAIT_WTA_GAROU_BREED
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/garou_breed/init_possible_values()
	return assoc_to_keys(GLOB.breed_forms_list)

/datum/preference/choiced/garou_breed/icon_for(value)
	var/datum/universal_icon/garou_icon = uni_icon('icons/effects/effects.dmi', "nothing")
	switch(value)
		if(BREED_HOMID)
			var/datum/universal_icon/breed_homid = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_head_m")
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_chest_m"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_arm"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_arm"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_leg"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_leg"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_hand"), ICON_OVERLAY)
			breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_hand"), ICON_OVERLAY)
			breed_homid.blend_color(skintone2hex("caucasian1"), ICON_MULTIPLY)
			breed_homid.scale(32, 32)
			garou_icon.blend_icon(breed_homid, ICON_OVERLAY)
		if(BREED_LUPUS)
			var/datum/universal_icon/breed_lupus = uni_icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/lupus.dmi', "black")
			breed_lupus.scale(32, 32)
			garou_icon.blend_icon(breed_lupus, ICON_OVERLAY)
		if(BREED_CRINOS)
			var/datum/universal_icon/breed_crinos = uni_icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/crinos.dmi', "black")
			breed_crinos.scale(32, 32)
			garou_icon.blend_icon(breed_crinos, ICON_OVERLAY)
	return garou_icon

/datum/preference/choiced/garou_breed/apply_to_human(mob/living/carbon/human/target, value)
	target.set_breed_form(value, TRUE)
