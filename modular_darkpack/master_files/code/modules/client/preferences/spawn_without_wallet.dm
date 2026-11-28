/datum/preference/toggle/spawn_without_wallet
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	should_update_preview = FALSE
	savefile_key = "spawn_without_wallet"
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/spawn_without_wallet/apply_to_human(mob/living/carbon/human/target, value)
	return
