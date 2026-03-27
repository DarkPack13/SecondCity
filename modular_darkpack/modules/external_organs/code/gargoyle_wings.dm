/obj/item/organ/wings/gargoyle
	name = "gargoyle wings"
	desc = "The wings of a creature that can fly."

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_WINGS

	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/gargoyle

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

/obj/item/organ/wings/gargoyle/on_mob_insert(mob/living/carbon/human/wing_owner)
    . = ..()
    var/datum/action/cooldown/toggle_gargoyle_flight/flight_action = new(wing_owner)
    flight_action.Grant(wing_owner)

/obj/item/organ/wings/gargoyle/on_mob_remove(mob/living/carbon/human/wing_owner, special)
    . = ..()
    if(HAS_TRAIT(wing_owner, TRAIT_MOVE_FLYING))
        REMOVE_TRAIT(wing_owner, TRAIT_MOVE_FLYING, "gargoyle wings")
        wing_owner.RemoveElement(/datum/element/simple_flying)

    for(var/datum/action/cooldown/toggle_gargoyle_flight/flight_action in wing_owner.actions)
        flight_action.Remove(wing_owner)
        qdel(flight_action)

/obj/item/organ/wings/gargoyle/proc/open_wings()
	var/datum/bodypart_overlay/mutant/wings/gargoyle/overlay = bodypart_overlay
	overlay.open_wings()
	owner.update_body_parts()

/obj/item/organ/wings/gargoyle/proc/close_wings()
	var/datum/bodypart_overlay/mutant/wings/gargoyle/overlay = bodypart_overlay
	overlay.close_wings()
	owner.update_body_parts()

/datum/bodypart_overlay/mutant/wings/gargoyle
	layers = ALL_EXTERNAL_OVERLAYS
	feature_key = FEATURE_WINGS
	imprint_on_next_insertion = FALSE
	VAR_PRIVATE/wings_open = FALSE

/datum/bodypart_overlay/mutant/wings/gargoyle/on_mob_insert(obj/item/organ/parent, mob/living/carbon/receiver)
	. = ..()
	imprint_on_next_insertion = FALSE

/datum/bodypart_overlay/mutant/wings/gargoyle/proc/open_wings()
	wings_open = TRUE
	cache_key = jointext(generate_icon_cache(), "_")

/datum/bodypart_overlay/mutant/wings/gargoyle/proc/close_wings()
	wings_open = FALSE
	cache_key = jointext(generate_icon_cache(), "_")

/datum/bodypart_overlay/mutant/wings/gargoyle/get_image(image_layer, obj/item/bodypart/limb)
	var/suffix = mutant_bodyparts_layertext(image_layer)
	var/icon_state = wings_open ? "m_wingsopen_gargoyle_[suffix]" : "m_wings_gargoyle_[suffix]"
	var/mutable_appearance/appearance = mutable_appearance(
		'modular_darkpack/modules/external_organs/icons/gargoyle_wings.dmi',
		icon_state,
		layer = image_layer
	)
	appearance.pixel_x = -16
	return appearance

/datum/bodypart_overlay/mutant/wings/gargoyle/set_appearance()
	return

/datum/bodypart_overlay/mutant/wings/gargoyle/color_image(image/overlay, layer, obj/item/bodypart/limb)
	return

/datum/bodypart_overlay/mutant/wings/gargoyle/generate_icon_cache()
	return list("gargoyle_wings", wings_open ? "open" : "closed")
