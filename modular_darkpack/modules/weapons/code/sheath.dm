/obj/item/storage/belt/sheath/vamp
	name = "sheath"
	icon_state = "longsword_sheathe-full"
	base_icon_state = "longsword_sheathe"
	worn_icon_state = "longsword_sheathe"
	//inhand_icon_state = "longsword_sheathe"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	//lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	//righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

/obj/item/storage/belt/sheath/vamp/sabre
	desc = "An ornate sheath designed to hold an officer's blade."
	icon_state = "sabre_sheathe-full"
	base_icon_state = "sabre_sheathe"
	worn_icon_state = "sabre_sheathe"
	//inhand_icon_state = "sabre_sheathe"
	storage_type = /datum/storage/sabre_belt_vamp
	stored_blade = /obj/item/melee/sabre/vamp

/obj/item/storage/belt/sheath/vamp/rapier
	desc = "An ornate sheath designed to hold a duelist's blade."
	icon_state = "rapier_sheathe-full"
	base_icon_state = "rapier_sheathe"
	worn_icon_state = "rapier_sheathe"
	//inhand_icon_state = "rapier_sheathe"
	storage_type = /datum/storage/rapier_belt_vamp
	stored_blade = /obj/item/melee/sabre/rapier

/obj/item/storage/belt/sheath/vamp/sword
	desc = "An ornate sheath designed to hold a knight's blade."
	icon_state = "longsword_sheathe-full"
	base_icon_state = "longsword_sheathe"
	worn_icon_state = "longsword_sheathe"
	//inhand_icon_state = "longsword_sheathe"
	storage_type = /datum/storage/sword_belt_vamp
	stored_blade = /obj/item/claymore/longsword


/datum/storage/sabre_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/sabre_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/melee/sabre)


/datum/storage/rapier_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/rapier_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/melee/sabre)


/datum/storage/sword_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/sword_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/claymore)
