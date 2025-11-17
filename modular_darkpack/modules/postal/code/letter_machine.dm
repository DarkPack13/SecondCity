/obj/lettermachine
	name = "letter machine"
	desc = "Work as letterman! Find a job!"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "mail"
	density = TRUE
	anchored = TRUE
	plane = GAME_PLANE
	layer = CAR_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/money = 0

/obj/lettermachine/attack_hand(mob/living/user)
	if(money >= 10)
		new /obj/item/letter(loc)
		say("New letter delivered!")
		money = max(0, money-10)
	else
		say("Not enough money on [src] balance!")
	..()

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
	return

/obj/lettermachine/examine(mob/user)
	. = ..()
	. += "[src] contains <b>[money] dollars</b>."
