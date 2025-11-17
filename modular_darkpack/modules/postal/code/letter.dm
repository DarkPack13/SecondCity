/obj/item/letter
	name = "letter"
	icon_state = "mail"
	icon = 'modular_darkpack/modules/postal/icons/postal.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/postal/icons/postal_onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY
	// Should we spawn our mailspawner?
	var/prefilled = FALSE
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

	if(prefilled)
		new mailspawner(src)
		icon_state = "[base_icon_state]_filled"
	else
		create_storage(
		max_slots = 1,
		max_specific_storage = WEIGHT_CLASS_NORMAL,
		rustle_sound = 'sound/items/handling/paper_pickup.ogg',
		remove_rustle_sound = 'sound/items/handling/paper_drop.ogg')

		atom_storage.allow_quick_gather = TRUE
		atom_storage.collection_mode = COLLECT_ONE
		RegisterSignal(atom_storage, COMSIG_STORAGE_STORED_ITEM, PROC_REF(on_insert))
		RegisterSignal(atom_storage, COMSIG_STORAGE_REMOVED_ITEM, PROC_REF(on_remove))

/obj/item/letter/proc/on_insert(datum/storage/storage, obj/item/to_insert, mob/user, force)
	SIGNAL_HANDLER

	update_weight_class(to_insert.w_class)
	atom_storage.set_locked(STORAGE_FULLY_LOCKED)

/obj/item/letter/proc/on_remove(datum/storage/storage, obj/item/to_remove, atom/remove_to_loc, silent)
	SIGNAL_HANDLER

	if(!atom_storage.get_total_weight())
		new /obj/item/paper/crumpled(get_turf(src))
		qdel(src)

/obj/item/letter/attack_self(mob/user)
	if(!atom_storage.get_total_weight())
		to_chat(user, span_notice("[src] is empty."))
		return
	user.visible_message(span_notice("[user] empties [src]."), span_notice("You empty [src]."),\
	span_hear("You hear someone rustle a piece of paper."))
	playsound(src,'sound/items/handling/paper_pickup.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)
	user.dropItemToGround(src)
	var/letter_item = locate(/obj/item) in contents
	user.put_in_hands(letter_item)
	qdel(src)

/obj/item/letter/prefilled
	prefilled = TRUE

/obj/item/letter/prefilled/glitterbomb
	mailspawner = /obj/effect/spawner/random/entertainment/colorful_grenades

/obj/item/letter/prefilled/grenade
	mailspawner = /obj/item/grenade/frag

/* LETTER MARK */
/obj/item/mark // Created after a targeted letter is unsealed
	name = "letter mark"
	icon_state = "mark"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY



/*
/obj/item/letter/Initialize(mapload)
	. = ..()
	var/list/mail_recipients = list()
	for(var/mob/living/carbon/human/alive in GLOB.player_list)
		if(alive.stat != DEAD)
			mail_recipients += alive
	if(length(mail_recipients))
		mail_target = pick(mail_recipients)
		name = "letter ([mail_target.real_name])"

/obj/item/letter/examine(mob/user)
	. = ..()
	. += "This letter is adressed to <b>[mail_target.real_name]</b>"

/obj/item/letter/attack_self(mob/user)
	. = ..()
	if(user == mail_target)
		playsound(loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		var/IT = pick(
			/obj/item/storage/pill_bottle/estrogen,
			/obj/item/storage/pill_bottle/unknown,
			/obj/item/storage/pill_bottle/ephedrine,
			/obj/item/storage/pill_bottle/potassiodide,
			/obj/item/vampire_stake,
			/obj/item/stack/dollar/rand,
			/obj/item/knife/vamp,
			/obj/item/melee/vamp/tire,
			/obj/item/reagent_containers/blood,
			/obj/item/gun/ballistic/revolver/darkpack/snub,
			/obj/item/vamp/keys/hack
		)
		new IT(user.loc)
		new /obj/item/mark(user.loc)
		qdel(src)
*/
