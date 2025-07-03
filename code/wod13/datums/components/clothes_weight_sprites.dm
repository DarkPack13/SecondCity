/datum/component/clothes_weight_sprites
	var/clothes_weight_icon

/datum/component/clothes_weight_sprites/Initialize(clothes_weight_sprite)
	src.clothes_weight_icon = clothes_weight_sprite

/datum/component/clothes_weight_sprites/RegisterWithParent()
	. = ..()

	if (!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	if (!clothes_weight_icon)
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/human_parent = parent
	for (var/obj/item/equipped_item in human_parent.get_equipped_items())
		apply_weight_icon(equipped_item)

	RegisterSignal(parent, COMSIG_MOB_VISUAL_EQUIPPED_ITEM, PROC_REF(handle_equipped_item))
	RegisterSignal(parent, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(handle_unequipped_item))

/datum/component/clothes_weight_sprites/UnregisterFromParent()
	. = ..()

	var/mob/living/carbon/human/human_parent = parent
	for (var/obj/item/equipped_item in human_parent.get_equipped_items())
		clear_weight_icon(equipped_item)

	UnregisterSignal(parent, COMSIG_MOB_VISUAL_EQUIPPED_ITEM)
	UnregisterSignal(parent, COMSIG_MOB_UNEQUIPPED_ITEM)

/datum/component/clothes_weight_sprites/proc/handle_equipped_item(mob/living/source, obj/item/equipped_item, slot)
	SIGNAL_HANDLER

	apply_weight_icon(equipped_item)

/datum/component/clothes_weight_sprites/proc/handle_unequipped_item(mob/living/source, obj/item/unequipped_item, slot)
	SIGNAL_HANDLER

	clear_weight_icon(unequipped_item)

/datum/component/clothes_weight_sprites/proc/apply_weight_icon(obj/item/equipped_item)
	if (!icon_exists(clothes_weight_icon, equipped_item.icon_state))
		return

	equipped_item.worn_icon = clothes_weight_icon
	equipped_item.update_icon()
	equipped_item.update_slot_icon()

/datum/component/clothes_weight_sprites/proc/clear_weight_icon(obj/item/unequipped_item)
	unequipped_item.worn_icon = initial(unequipped_item.worn_icon)
	unequipped_item.update_icon()
	unequipped_item.update_slot_icon()



