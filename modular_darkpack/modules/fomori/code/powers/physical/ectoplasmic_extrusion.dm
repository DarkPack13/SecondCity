/obj/item/bodypart/arm/left/ectoplasmic_extrusion
	stump_typepath = null
	body_part = null
	body_zone = "l_arm_2"
	aux_zone = "l_arm_2"
	held_index = 3

/obj/item/bodypart/arm/right/ectoplasmic_extrusion
	stump_typepath = null
	body_part = null
	body_zone = "r_arm_2"
	aux_zone = "r_arm_2"
	held_index = 4

/obj/item/bodypart/arm/left/ectoplasmic_extrusion/upper
	body_zone = "l_arm_3"
	aux_zone = "l_arm_3"
	held_index = 5

/obj/item/bodypart/arm/right/ectoplasmic_extrusion/upper
	body_zone = "r_arm_3"
	aux_zone = "r_arm_3"
	held_index = 6

/datum/bodypart_overlay/simple/ectoplasmic_extrusion // Freak Legion pg.32
	icon_state = "ectoplasmic_extrusion"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = list(EXTERNAL_ADJACENT = LOW_FACEMASK_LAYER)

/datum/action/cooldown/power/fomori_power/ectoplasmic_extrusion
	name = "Ectoplasmic Extrusion"
	desc = "(UNIMPLEMENTED) Sprout grotesque tendrils from your back to use as extra hands or as a weapon."
	button_icon_state = "ectoplasmic_extrusion"
	rank = 1

	ttrpg_sources = list(/datum/source_book/freak_legion = 32)

	var/obj/item/bodypart/arm/left/ectoplasmic_extrusion/upper/upper_left
	var/obj/item/bodypart/arm/right/ectoplasmic_extrusion/upper/upper_right

	var/obj/item/bodypart/arm/left/ectoplasmic_extrusion/lower_left
	var/obj/item/bodypart/arm/right/ectoplasmic_extrusion/lower_right

	fomor_part = /datum/bodypart_overlay/simple/ectoplasmic_extrusion
	feature_bodypart = BODY_ZONE_CHEST

/datum/action/cooldown/power/fomori_power/ectoplasmic_extrusion/Remove(mob/removed_from)
	remove_ectoplasmic_extrusions()
	..()

/datum/action/cooldown/power/fomori_power/ectoplasmic_extrusion/Activate(atom/target)
	. = ..()
	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
		remove_ectoplasmic_extrusions()
	else
		deployed = TRUE
		add_ectoplasmic_extrusions()
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

/datum/action/cooldown/power/fomori_power/ectoplasmic_extrusion/proc/add_ectoplasmic_extrusions()
	var/mob/living/carbon/human/human_owner = owner
	upper_left = new
	upper_right = new
	lower_left = new
	lower_right = new
	var/ecto_list = list(upper_left, upper_right, lower_left, lower_right)
	human_owner.hand_bodyparts.len = 6
	human_owner.held_items.len = 6
	for(var/obj/item/bodypart/new_part in ecto_list)
		human_owner.hand_bodyparts[ecto_list[new_part]] = new_part
		new_part.try_attach_limb(human_owner, TRUE)

	human_owner.hud_used.build_hand_slots(update_hud = TRUE)
	var/atom/movable/screen/healthdoll/doll = human_owner.hud_used.screen_objects[HUD_MOB_HEALTHDOLL]
	if(doll)
		doll.update_body_zones()

/datum/action/cooldown/power/fomori_power/ectoplasmic_extrusion/proc/remove_ectoplasmic_extrusions()
	var/mob/living/carbon/human/human_owner = owner
	var/ecto_list = list(upper_left, upper_right, lower_left, lower_right)
	for(var/obj/item/bodypart/new_part in ecto_list)
		human_owner.dropItemToGround(human_owner.held_items[new_part])
		human_owner.hand_bodyparts[new_part] = null
		new_part.drop_limb(dismembered = FALSE, move_to_floor = FALSE)

	human_owner.hand_bodyparts.len = 2
	human_owner.held_items.len = 2

	human_owner.hud_used.build_hand_slots(update_hud = TRUE)
	var/atom/movable/screen/healthdoll/doll = human_owner.hud_used.screen_objects[HUD_MOB_HEALTHDOLL]
	if(doll)
		doll.update_body_zones()
