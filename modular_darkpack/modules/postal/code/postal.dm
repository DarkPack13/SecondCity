/obj/lettermachine
	name = "letter machine"
	desc = "Work as letterman! Find a job!"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	icon_state = "mail"
	density = TRUE
	anchored = TRUE
	plane = GAME_PLANE
	layer = CAR_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/money = 0

/obj/lettermachine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(money >= 10)
		new /obj/item/letter(loc)
		say("New letter delivered!")
		money = max(0, money-10)
	else
		say("Not enough money on [src] balance!")

/obj/lettermachine/attackby(obj/item/I, mob/user, params)
	if(iscash(I))
		money += I.get_item_credit_value()
		to_chat(user, span_notice("You insert [I.get_item_credit_value()] dollars into [src]."))
		say("[I] inserted.")
		qdel(I)
	if(istype(I, /obj/item/mark))
		new /obj/item/stack/dollar(loc, 30)
		say("[I] delivered!")
		qdel(I)
	return ..()

/obj/lettermachine/examine(mob/user)
	. = ..()
	. += span_info("It contains [money] dollars.")

/obj/item/letter
	name = "letter"
	icon_state = "letter"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	var/datum/weakref/mail_target_weakref

/obj/item/mark
	name = "letter mark"
	icon_state = "mark"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY

/obj/item/letter/Initialize(mapload)
	. = ..()
	var/list/mail_recipients = list()
	for(var/mob/living/carbon/human/alive in GLOB.player_list)
		if(alive.stat != DEAD)
			mail_recipients += alive
	if(length(mail_recipients))
		var/mob/mail_target = pick(mail_recipients)
		name = "letter ([mail_target.real_name])"
		mail_target_weakref = WEAKREF(mail_target)

/obj/item/letter/examine(mob/user)
	. = ..()
	var/mob/mail_target = mail_target_weakref.resolve()
	. += "This letter is adressed to <b>[mail_target?.real_name]</b>"

/obj/item/letter/attack_self(mob/user)
	. = ..()
	var/mail_target = mail_target_weakref.resolve()
	if(user == mail_target)
		playsound(loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		var/IT = pick(
			/obj/item/storage/pill_bottle/unknown,
			/obj/item/storage/pill_bottle/ephedrine,
			/obj/item/storage/pill_bottle/potassiodide,
			/obj/item/vampire_stake,
			/obj/item/stack/dollar/rand,
			/obj/item/knife/vamp,
			/obj/item/melee/vamp/tire,
			/obj/item/reagent_containers/blood,
			/obj/item/gun/ballistic/revolver/darkpack/snub,
			/obj/item/vamp/keys/hack,
		)
		new IT(user.loc)
		new /obj/item/mark(user.loc)
		qdel(src)

