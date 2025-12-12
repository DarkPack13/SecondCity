/obj/item/letter
	name = "letter"
	icon_state = "mail"
	base_icon_state = "mail"
	icon = 'modular_darkpack/modules/postal/icons/postal.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/postal/icons/postal_onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY
	// Should we spawn our mailspawner?
	var/prefilled = FALSE
	// If TRUE and our contents are a grenade, detonate it instantly
	var/instant_nadetrap = FALSE
	// Are we sealed (locked)?
	var/sealed = FALSE
	// Item that is placed inside the letter when it spawns
	var/mailspawner = /obj/effect/spawner/random/mail
	// If not null, only openable by this mob.
	var/mob/living/carbon/recipient = null
	// Name to display in parenthesis
	var/nickname
	// List of people who've tried to find out what's inside the letter
	var/list/examined

/obj/item/letter/Initialize(mapload)
	. = ..()
	desc = pick("We just got a letter! We just got a letter! We just got a letter, I wonder who it's from?",
		"You've got mail!",
		"The bills have arrived.",
		"This is the mail that never fails.",
		"This is the mail that never fails; it makes you want to wag your tail.",
		"Oh boy, my embarassing medication is here!")

	create_storage(
	max_slots = 1,
	max_specific_storage = WEIGHT_CLASS_SMALL,
	canthold = list(/obj/item/mark),
	rustle_sound = 'sound/items/handling/paper_pickup.ogg',
	remove_rustle_sound = 'sound/items/handling/paper_drop.ogg')
	RegisterSignal(atom_storage, COMSIG_STORAGE_STORED_ITEM, PROC_REF(on_insert))
	RegisterSignal(atom_storage, COMSIG_STORAGE_REMOVED_ITEM, PROC_REF(on_remove))

	if(prefilled)
		new mailspawner(src)
	if(sealed)
		name = "sealed [name]"
		icon_state = "[base_icon_state]_sealed"
		atom_storage.set_locked(STORAGE_FULLY_LOCKED)

/obj/item/letter/proc/on_insert(datum/storage/storage, obj/item/to_insert, mob/user, force)
	SIGNAL_HANDLER

	update_weight_class(to_insert.w_class)

/obj/item/letter/proc/on_remove(datum/storage/storage, obj/item/to_remove, atom/remove_to_loc, silent)
	SIGNAL_HANDLER

/obj/item/letter/attack_self(mob/user)
	if(atom_storage.get_total_weight())
		user.visible_message(span_notice("[user] empties [src]."),\
		span_notice("You empty [src]."),\
		span_hear("You hear someone rustle a piece of paper."))
		playsound(src,'sound/items/handling/paper_pickup.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)
		if(!user.put_in_inactive_hand(src))
			user.dropItemToGround(src)
		var/letter_item = locate(/obj/item) in contents
		user.put_in_hands(letter_item)
		if(istype(letter_item, /obj/item/grenade))
			letter_item.arm_grenade(user)
			if(instant_nadetrap)
				letter_item.detonate()
	else
		to_chat(user, span_warning("[src] is empty."))
	if(sealed)
		new /obj/item/paper/crumpled(get_turf(src))
		qdel(src)

/*/obj/item/letter/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers) // Uncomment when i'm less stupid
	. = ..()
	if(istype(attacking_item, /obj/item/mark) && !sealed)
		to_chat(user, span_notice("You start sealing [src] with [attacking_item]..."))
		if(do_after(user, 1 SECONDS, src))
			to_chat(user, span_notice("You seal [src] with [attacking_item]."))
			name = "sealed [name]"
			sealed = TRUE
			atom_storage.set_locked(STORAGE_FULLY_LOCKED)
		else
			to_chat(user, span_warning("You stop sealing [src]."))
	else if(istype(attacking_item, /obj/item/mark) && sealed)
		to_chat(user, span_warning("[src] is already sealed."))

	return TRUE*/
