/datum/bodypart_overlay/simple/fomor_claws
	icon_state = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_inhand_right.dmi'
	layers = POWERS_LAYER
	var/bodyzone = BODY_ZONE_R_ARM
	var/obj/item/bodypart/assigned_bodyzone

/datum/bodypart_overlay/simple/fomor_claws/l_arm
	icon_state = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_inhand_left.dmi'
	bodyzone = BODY_ZONE_L_ARM


/datum/action/cooldown/power/fomori_power/claws
	name = "Claws"
	desc = "Use the grotesque claws on your hands to slice and dice."
	button_icon_state = "claws"
	rank = 1
	fomor_part = "none" // So we get caught by code that checks if we have a fomor_part

	ttrpg_sources = list(/datum/source_book/freak_legion = 31)

	var/list/overlay_list = list()
	var/r_arm_overlay = /datum/bodypart_overlay/simple/fomor_claws
	var/l_arm_overlay = /datum/bodypart_overlay/simple/fomor_claws/l_arm

/datum/action/cooldown/power/fomori_power/claws/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/fomor = owner
	var/obj/item/bodypart/hand_l = fomor?.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/hand_r = fomor?.get_bodypart(BODY_ZONE_R_ARM)

	toggle_feature(deployed)

	if(deployed)
		hand_l?.unarmed_attack_effect = initial(hand_l?.unarmed_attack_effect)
		hand_r?.unarmed_attack_effect = initial(hand_r?.unarmed_attack_effect)
		hand_l?.unarmed_sharpness = initial(hand_l?.unarmed_sharpness)
		hand_r?.unarmed_sharpness = initial(hand_r?.unarmed_sharpness)
		if(HAS_TRAIT(owner, TRAIT_FOMORI_HIDDEN_POWER))
			playsound(owner, 'sound/items/sheath.ogg', 50)
			owner.visible_message(span_warning("The grotesque claws retract back into [owner]\'s hands!"), \
				span_warning("Your claws retract into your hands."), \
				span_hear("You hear organic matter ripping and tearing!"))
		else
			to_chat(owner, span_warning("You lower your claws, regaining some of your dexterity."))
		deployed = FALSE
	else
		ADD_TRAIT(owner, TRAIT_CLUMSY, "fomor_claws")
		hand_l?.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		hand_r?.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		hand_l?.unarmed_sharpness = SHARP_EDGED
		hand_r?.unarmed_sharpness = SHARP_EDGED
		if(HAS_TRAIT(owner, TRAIT_FOMORI_HIDDEN_POWER))
			playsound(owner, 'sound/items/unsheath.ogg', 50)
			owner.visible_message(span_warning("A pair of grotesque claws extend from [owner]\'s hands!"), \
				span_warning("Your claws extend from your hands."), \
				span_hear("You hear organic matter ripping and tearing!"))
		else
			to_chat(owner, span_warning("You ready your claws, sacrificing some of your dexterity for deadliness."))
		deployed = TRUE

/datum/action/cooldown/power/fomori_power/claws/add_feature()
	var/mob/living/carbon/human/fomor = owner

	overlay_list = list(new r_arm_overlay, new l_arm_overlay)

	for(var/datum/bodypart_overlay/simple/fomor_claws/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		if(isnull(bp_overlay.assigned_bodyzone))
			qdel(bp_overlay)
			continue
		bp_overlay.assigned_bodyzone.add_bodypart_overlay(bp_overlay)

/datum/action/cooldown/power/fomori_power/claws/remove_feature()
	var/mob/living/carbon/human/fomor = owner
	for(var/datum/bodypart_overlay/simple/fomor_claws/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		bp_overlay.assigned_bodyzone.remove_bodypart_overlay(bp_overlay)
		qdel(bp_overlay)
	overlay_list = list()
