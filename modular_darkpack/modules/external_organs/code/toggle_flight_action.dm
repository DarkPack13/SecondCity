/datum/action/cooldown/toggle_gargoyle_flight
    name = "Spread Wings"
    desc = "Spread or fold your stone wings to take flight."
    button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
    button_icon_state = "fly"

/datum/action/cooldown/toggle_gargoyle_flight/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/user = owner
	var/obj/item/organ/wings/gargoyle/wings = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(!wings)
		return

	if(HAS_TRAIT(user, TRAIT_MOVE_FLYING))
		REMOVE_TRAIT(user, TRAIT_MOVE_FLYING, "gargoyle wings")
		user.RemoveElement(/datum/element/simple_flying)
		wings.close_wings()
		name = "Spread Wings"
		to_chat(user, span_notice("You fold your stone wings."))
	else
		ADD_TRAIT(user, TRAIT_MOVE_FLYING, "gargoyle wings")
		user.AddElement(/datum/element/simple_flying)
		wings.open_wings()
		name = "Fold Wings"
		to_chat(user, span_notice("You spread your stone wings and take flight!"))
