// Presently a dummy placeholder, might want to do stuff like flavor the ui, change the dice roll, make fomori_powers private by default or the like
/datum/storyteller_roll/fomori_power

/datum/action/cooldown/power/fomori_power
	background_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	background_icon_state = "bg_fomori_power"
	button_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	//button_icon_state = ""
	overlay_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'

	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

	// Snowflake toggle behavior
	var/deployed = FALSE

	// Body feature for horns, fangs, etc.
	var/datum/bodypart_overlay/simple/fomor_part
	// What bodypart are we putting our feature on?
	var/feature_bodypart = BODY_ZONE_HEAD

	// What organ are we adding?
	var/obj/item/organ/fomor_organ
	// Where are we inserting it?
	var/fomor_organ_slot
	// Do we violate the veil if seen? Only used for the overlays
	var/masq_violating_overlay = TRUE

/atom/movable/screen/alert/status_effect/fomori_power
	icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	icon_state = "bg_fomori_power"
	overlay_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'


///checks if we lose a limb a feature is attached to
/datum/action/cooldown/power/fomori_power/proc/on_removed_limb(datum/source, obj/item/bodypart/removed_limb, special, dismembered)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/carbon_owner = astype(owner, /mob/living/carbon)
	var/obj/item/bodypart/bodypart =  carbon_owner.get_bodypart(feature_bodypart)

	if(fomor_part && istype(removed_limb, bodypart.type))
		remove_feature()

///for adding fomor features i.e. fangs, horns
/datum/action/cooldown/power/fomori_power/proc/add_feature()
	var/mob/living/carbon/human/fomor = owner
	var/obj/item/bodypart/bodypart = fomor?.get_bodypart(feature_bodypart)

	if(isnull(bodypart))
		return

	if(isnull(fomor_part))
		return

	fomor_part = new fomor_part() //creates our overlay
	bodypart.add_bodypart_overlay(fomor_part)
	if(masq_violating_overlay)
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

///removes the fomor feature
/datum/action/cooldown/power/fomori_power/proc/remove_feature()
	var/mob/living/carbon/human/fomor = owner
	var/obj/item/bodypart/bodypart = fomor?.get_bodypart(feature_bodypart)
	bodypart?.remove_bodypart_overlay(fomor_part)
	QDEL_NULL(fomor_part)
	fomor_part = initial(fomor_part)

///toggles the feature, TRUE for remove and FALSE for add
/datum/action/cooldown/power/fomori_power/proc/toggle_feature(current_state)
	if(!HAS_TRAIT(owner, TRAIT_FOMORI_HIDDEN_POWER))
		return FALSE

	if(current_state)
		remove_feature()
	else
		add_feature()

	return TRUE
