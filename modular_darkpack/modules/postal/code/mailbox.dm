/obj/structure/mailbox
	name = "mailbox"
	desc = "Checking what's inside is a felony, unless you're the one who owns it."
	icon = 'modular_darkpack/modules/postal/icons/postal.dmi'
	icon_state = "mailbox"
	base_icon_state = "mailbox"
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/address = "101 Ahelp Street"
	var/open_sound = 'sound/machines/closet/closet_open.ogg'
	var/max_items = 9
	var/max_specific_storage = WEIGHT_CLASS_SMALL
	var/max_total_storage = WEIGHT_CLASS_TINY * 9
	var/storage_type = /datum/storage
	var/rustle_sound = 'sound/machines/closet/closet_open.ogg'
	var/remove_rustle_sound = 'sound/items/handling/toolbox/toolbox_rustle.ogg'
	var/mailspawner_type = /obj/effect/spawner/random/mail
	var/empty = FALSE

/obj/structure/mailbox/Initialize(mapload)
	. = ..()
	create_storage(max_items, max_specific_storage, max_total_storage, null, null, storage_type, open_sound, remove_rustle_sound)
	generate_random_address()
	if(!empty)
		for(var/i = 0 to 4)
			if(prob(25))
				new mailspawner_type(src)
	update_icon_state()

/obj/structure/mailbox/attack_hand(mob/user)
	. = ..()
	if(!user.combat_mode)
		atom_storage.open_storage(user)
		return TRUE

/obj/structure/mailbox/update_icon_state()
	icon_state = "[base_icon_state][contents.len ? "_filled" : null]"
	return ..()

/obj/structure/mailbox/examine(mob/user)
	. = ..()
	. += span_notice("The mailbox has an address on it. [address].")

/obj/structure/mailbox/proc/generate_random_address()
	var/num = rand(0, 9999)
	var/street = pick(GLOB.streetnames)
	address = "[num] [street]"

/obj/structure/mailbox/glitterbomb

/obj/structure/mailbox/empty
	empty = TRUE
