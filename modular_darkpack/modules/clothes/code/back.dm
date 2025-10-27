/obj/item/storage/backpack/satchel
	var/icon_hidden = FALSE

/obj/item/storage/backpack/satchel/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/storage/backpack/satchel/proc/conceal(mob/user)
	icon_hidden = !icon_hidden
	worn_icon_state = icon_hidden ? "nothing" : initial(worn_icon_state)

	to_chat(user, span_notice("You [icon_hidden ? "conceal" : "reveal"] [src].</span>"))

	user.update_worn_back()



/obj/item/storage/backpack/satchel/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(!ishuman(user)) // You're not a *dog*, are you?
		return ..()

	var/mob/living/carbon/human/H = user
	if(src == H.back && H.w_uniform && !user.get_active_held_item())
		context[SCREENTIP_CONTEXT_ALT_RMB] =  "[icon_hidden ? "Reveal" : "Conceal"]"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/storage/backpack/satchel/click_alt_secondary(mob/user)
	if(!ishuman(user)) // You're not a *dog*, are you?
		return ..()

	var/obj/item/storage/backpack/satchel/S = src
	var/mob/living/carbon/human/H = user
	if(S == H.back && H.w_uniform && !user.get_active_held_item()) // Make sure the bag is on our back, we have clothes on, and there isn't anything in our hands
		S.add_fingerprint(H)
		S.conceal(H)
		return COMPONENT_NO_AFTERATTACK
	else // It's not on our back AND/OR we don't have clothes AND/OR we have something in our hands
		return ..()
