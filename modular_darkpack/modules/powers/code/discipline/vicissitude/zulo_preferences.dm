/datum/preference/choiced/zulo_form
	savefile_key = "zulo_form"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_REQUIRES_SUBSPLAT
	main_feature_name = "Zulo Form"
	relevant_inherent_trait = TRAIT_VTM_CLANS
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/zulo_form/has_relevant_feature(datum/preferences/preferences)
	. = ..()
	if(!.) // Make sure we acctually can select clan in the first place
		return FALSE
	var/clan_type = preferences.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(clan_type)
	if(!clan)
		return FALSE
	for(var/discipline in clan.clan_disciplines) // DARKPACK TODO - reimplement choosing disciplines
		if(ispath(discipline, /datum/discipline/vicissitude))
			return TRUE
	return FALSE

/datum/preference/choiced/zulo_form/init_possible_values()
	var/list/values = list()
	for(var/name in GLOB.zulo_forms)
		values[name] = GLOB.zulo_forms[name]
	return values
/* Sabby: this is the main modification I did to zulo_preferences.dm. I basically reworked below to pull the difference tzizu1
limp sprites form Paul's work on bodyparts_greyscale.dmi. Not sure if this will work or more needs to be done.
I also set scale to 64x64.

If you'd like reference for the of this, I basically took what is done in:

modular_darkpack/modules/werewolf_the_apocalypse/code/preferences/breed.dm

and went from there
*/
/datum/preference/choiced/subsplat/zulo_form/icon_for(value)
	var/datum/universal_icon/zulo_icon = uni_icon('icons/effects/effects.dmi', "nothing")
	switch(value)
		if("Beast") /* Sabby: can change this to "Zulo" later on in both here and zulo.dm */
			var/datum/universal_icon/form_icon = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_head")
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_chest"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_r_arm"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_l_arm"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_r_leg"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_l_leg"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_r_hand"), ICON_OVERLAY)
			form_icon.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "tzizu1_l_hand"), ICON_OVERLAY)
			form_icon.blend_color(skintone2hex("caucasian1"), ICON_MULTIPLY)
			form_icon.scale(64, 64)
			zulo_icon.blend_icon(form_icon, ICON_OVERLAY)
	return zulo_icon

// /datum/preference/choiced/subsplat/zulo_form/icon_for(value)
// 	var/icon_state = GLOB.zulo_forms[value]
// 	var/datum/universal_icon/zulo_icon = uni_icon('modular_darkpack/modules/powers/icons/zulo_forms.dmi', icon_state)
// 	zulo_icon.scale(32, 32)
// 	return zulo_icon

/datum/preference/choiced/subsplat/zulo_form/apply_to_human(mob/living/carbon/human/target, value)
	return
