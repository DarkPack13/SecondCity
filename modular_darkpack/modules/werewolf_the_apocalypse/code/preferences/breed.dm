/datum/preference/choiced/subsplat/fera_breed
	abstract_type = /datum/preference/choiced/subsplat/fera_breed
	main_feature_name = "Breed"
	var/splat_id

/datum/preference/choiced/subsplat/fera_breed/init_possible_values()
	var/list/pref_list = list()
	// Key is type path not singleton
	for(var/datum/subsplat/werewolf/breed_form/key as anything in GLOB.breed_forms)
		if(key::fera_restriction != splat_id)
			continue
		UNTYPED_LIST_ADD(pref_list, key::name)
	return pref_list

/datum/preference/choiced/subsplat/fera_breed/icon_for(value)
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

/datum/preference/choiced/subsplat/fera_breed/apply_to_human(mob/living/carbon/human/target, value)
	var/joining_round = !isdummy(target)
	target.set_breed_form(value, joining_round)

/datum/preference/choiced/subsplat/fera_breed/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/splat/splat_path = preferences.read_preference(/datum/preference/choiced/splats)
	if(!ispath(splat_path) || splat_path::id != splat_id)
		return FALSE


/datum/preference/choiced/subsplat/fera_breed/garou
	savefile_key = "garou_breed"
	splat_id = SPLAT_GAROU


/datum/preference/choiced/subsplat/fera_breed/coeax
	savefile_key = "corax_breed"
	splat_id = SPLAT_CORAX
