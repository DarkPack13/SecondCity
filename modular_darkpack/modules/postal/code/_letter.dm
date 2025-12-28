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
	// Name of the sender, assigned by the mailbox
	var/sender_name
	// How hard it is to feel out what's inside
	var/hidden_difficulty = 1

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
		hidden_difficulty = rand(1,8) // Blitheringly obvious up to Cthulu's Realm - The lower your DEX+PER, the more likely it is to be impossible.
	if(sealed)
		name = "sealed [name]"
		icon_state = "[base_icon_state]_sealed"
		atom_storage.set_locked(STORAGE_FULLY_LOCKED)

/obj/item/letter/examine(mob/user)
	. = ..()
	if(contents.len)
		. += span_warning("It has something in it. <b>Right-click</b> with an empty hand to try to figure out what...")
	if(sealed)
		. += span_notice("[src] is sealed.")
	if(sender_name)
		. += span_notice("It looks like it's from [sender_name]")

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
			var/obj/item/grenade/letter_nade = letter_item
			if(instant_nadetrap)
				letter_nade.detonate()
			else
				letter_nade.arm_grenade(user, msg = FALSE)

	else
		to_chat(user, span_warning("[src] is empty."))

	if(sealed)
		new /obj/item/paper/crumpled(get_turf(src))
		qdel(src)

/obj/item/letter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/mark) && !sealed)
		to_chat(user, span_notice("You start sealing [src] with [tool]..."))
		if(do_after(user, 1 SECONDS, src))
			to_chat(user, span_notice("You seal [src] with [tool]."))
			name = "sealed [name]"
			sealed = TRUE
			atom_storage.set_locked(STORAGE_FULLY_LOCKED)
			icon_state = "[base_icon_state]_sealed"
			hidden_difficulty = SSroll.storyteller_roll(user.st_get_stat(STAT_DEXTERITY)+user.st_get_stat(STAT_SUBTERFUGE, hidden_difficulty, user, numerical = TRUE))
			qdel(tool)
		else
			to_chat(user, span_warning("You stop sealing [src]."))
	else if(istype(tool, /obj/item/mark) && sealed)
		to_chat(user, span_warning("[src] is already sealed."))

	if((istype(tool, /obj/item/pen) || istype(tool, /obj/item/toy/crayon)))
		if(!nickname)
			nickname = sanitize(tgui_input_text(user, "Address to who/what?", "[src]", max_length = 32))
			name += " ([nickname])"

		if(!sender_name)
			sender_name = sanitize(tgui_input_text(user, "Address from who/what?", "[src]", max_length = 32))

	return TRUE

/obj/item/letter/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(user in examined)
		to_chat(span_warning("You've already tried and already come up short. Only one way to find out now..."))
		return

	to_chat(span_warning("You begin feeling around [src] trying to figure out what's inside..."))
	if(do_after(user, user.st_get_stat(STAT_DEXTERITY) SECONDS, src))
		mypower = SSroll.storyteller_roll(user.st_get_stat(STAT_DEXTERITY)+user.st_get_stat(STAT_AWARENESS, hidden_difficulty, user, numerical = TRUE))
	else
		to_chat(span_warning("You stop trying to feel out what's inside [src]."))
