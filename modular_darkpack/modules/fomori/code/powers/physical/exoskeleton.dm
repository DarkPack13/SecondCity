/datum/bodypart_overlay/simple/fomor_exoskeleton
	icon_state = "exoskeleton"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = BENEATH_HAIR_LAYER
	var/bodyzone = BODY_ZONE_CHEST
	var/obj/item/bodypart/assigned_bodyzone

/datum/bodypart_overlay/simple/fomor_exoskeleton/head
	icon_state = "exoskeleton-head"
	bodyzone = BODY_ZONE_HEAD

/datum/bodypart_overlay/simple/fomor_exoskeleton/r_arm
	icon_state = "exoskeleton-r_arm"
	bodyzone = BODY_ZONE_R_ARM
	layers = MUTATIONS_LAYER

/datum/bodypart_overlay/simple/fomor_exoskeleton/l_arm
	icon_state = "exoskeleton-l_arm"
	bodyzone = BODY_ZONE_L_ARM
	layers = HALO_LAYER

/datum/bodypart_overlay/simple/fomor_exoskeleton/r_leg
	icon_state = "exoskeleton-r_leg"
	bodyzone = BODY_ZONE_R_LEG

/datum/bodypart_overlay/simple/fomor_exoskeleton/l_leg
	icon_state = "exoskeleton-l_leg"
	bodyzone = BODY_ZONE_L_LEG

/datum/bodypart_overlay/simple/fomor_fangs/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	return ..() && !(bodypart_owner.owner?.obscured_slots & HIDEFACE)

/datum/action/cooldown/power/fomori_power/exoskeleton
	name = "Exoskeleton"
	desc = "Form a thick carapace around your body, protecting you from harm and increasing your strength."
	button_icon_state = "exoskeleton"
	rank = 1 // of 1

	//Snowflake code
	var/list/overlay_list = list()

	var/chest_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton
	var/head_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton/head
	var/r_arm_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton/r_arm
	var/l_arm_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton/l_arm
	var/r_leg_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton/r_leg
	var/l_leg_overlay = /datum/bodypart_overlay/simple/fomor_exoskeleton/l_leg

/datum/action/cooldown/power/fomori_power/exoskeleton/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)

	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
		carbon_owner.st_remove_stat_mod(STAT_STAMINA, 1, "exoskeleton")
		carbon_owner.st_remove_stat_mod(STAT_STRENGTH, 1, "exoskeleton")
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg', 50)
		owner.visible_message(span_warning("[owner]'s skin sheds it's thick carapace, returning to a normal state!"), \
			span_warning("Your skin returns to normal."), \
			span_hear("You hear organic matter ripping and tearing!"))
	else
		deployed = TRUE
		carbon_owner.st_add_stat_mod(STAT_STAMINA, 1, "exoskeleton")
		carbon_owner.st_add_stat_mod(STAT_STRENGTH, 1, "exoskeleton")
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_activate.ogg', 50)
		owner.visible_message(span_warning("[owner]'s skin becomes a thick carapace!"), \
			span_warning("Your skin forms a thick carapace."), \
			span_hear("You hear organic matter ripping and tearing!"))
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

///for adding fomor features i.e. fangs, horns
/datum/action/cooldown/power/fomori_power/exoskeleton/add_feature()
	var/mob/living/carbon/human/fomor = owner

	overlay_list = list(
		new chest_overlay, new head_overlay, new r_arm_overlay,
		new l_arm_overlay, new r_leg_overlay, new l_leg_overlay)

	for(var/datum/bodypart_overlay/simple/fomor_exoskeleton/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		if(isnull(bp_overlay.assigned_bodyzone))
			qdel(bp_overlay)
			continue
		bp_overlay.assigned_bodyzone.add_bodypart_overlay(bp_overlay)

///removes the fomor feature
/datum/action/cooldown/power/fomori_power/exoskeleton/remove_feature()
	var/mob/living/carbon/human/fomor = owner
	for(var/datum/bodypart_overlay/simple/fomor_exoskeleton/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		bp_overlay.assigned_bodyzone.remove_bodypart_overlay(bp_overlay)
		qdel(bp_overlay)
	overlay_list = list()
