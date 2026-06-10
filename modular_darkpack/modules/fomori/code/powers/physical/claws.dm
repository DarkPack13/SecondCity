/obj/item/knife/fomor_claws // Just a normal knife, but part of our hands!
	name = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items48x32.dmi'
	icon_state = "claw"
	inhand_icon_state = "claw"
	lefthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_left.dmi'
	righthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_right.dmi'
	icon_angle = 0
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_speed = 0
	throw_range = 0

	abstract_type = /obj/item/knife/fomor_claws

/obj/item/knife/fomor_claws/Initialize(mapload,silent) // Largely copied from changeling armblade
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)

/datum/bodypart_overlay/simple/fomor_claws
	icon_state = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_inhand_right.dmi'
	layers = MUTATIONS_LAYER
	var/bodyzone = BODY_ZONE_R_ARM
	var/obj/item/bodypart/assigned_bodyzone

/datum/bodypart_overlay/simple/fomor_claws/l_arm
	icon_state = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_inhand_left.dmi'
	bodyzone = BODY_ZONE_L_ARM


/datum/action/cooldown/power/fomori_power/weapon/claws
	name = "Claws"
	desc = "Use the grotesque claws on your hands to slice and dice."
	button_icon_state = "claws"
	rank = 1 // of 1
	weapon_type = /obj/item/knife/fomor_claws
	unsheathe_sound = 'sound/items/weapons/parry.ogg'
	sheathe_text = "Your claws retract into your arms."

	var/list/overlay_list = list()
	var/r_arm_overlay = /datum/bodypart_overlay/simple/fomor_claws
	var/l_arm_overlay = /datum/bodypart_overlay/simple/fomor_claws/l_arm

/datum/action/cooldown/power/fomori_power/weapon/claws/Activate(atom/target)
	. = ..()
	if(deployed)
		owner.visible_message(span_warning("A pair of grotesque claws extend from [owner]\'s hands!"), \
			span_warning("Your claws extend from your hands."), \
			span_hear("You hear organic matter ripping and tearing!"))

/datum/action/cooldown/power/fomori_power/weapon/claws/add_feature()
	var/mob/living/carbon/human/fomor = owner

	overlay_list = list(new r_arm_overlay, new l_arm_overlay)

	for(var/datum/bodypart_overlay/simple/fomor_claws/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		if(isnull(bp_overlay.assigned_bodyzone))
			qdel(bp_overlay)
			continue
		bp_overlay.assigned_bodyzone.add_bodypart_overlay(bp_overlay)

/datum/action/cooldown/power/fomori_power/weapon/claws/remove_feature()
	var/mob/living/carbon/human/fomor = owner
	for(var/datum/bodypart_overlay/simple/fomor_claws/bp_overlay in overlay_list)
		bp_overlay.assigned_bodyzone = fomor?.get_bodypart(bp_overlay.bodyzone)
		bp_overlay.assigned_bodyzone.remove_bodypart_overlay(bp_overlay)
		qdel(bp_overlay)
	overlay_list = list()

#warn CLAWS SOFT FINISHED - Needs melee damage stats
