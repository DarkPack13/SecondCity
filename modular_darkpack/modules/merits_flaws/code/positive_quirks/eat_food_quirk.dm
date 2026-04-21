/datum/quirk/darkpack/eat_food
	name = "Eat Food"
	desc = "Unlike most of the Undead, you retain the ability to eat and digest food normally, a semblance of your mortal life. While you gain no nourishment from it, you can consume food without the usual revulsion Kindred experience. Be warned: what goes down must come up, eventually."
	value = 1
	mob_trait = TRAIT_EAT_FOOD
	gain_text = span_notice("Your stomach stirs as you feel the organ come to life. You can now eat food.")
	lose_text = span_notice("The ability to eat food fades from you.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_UTENSILS

/datum/quirk/darkpack/eat_food/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(. == FALSE)
		return

	if(ishuman(new_holder))
		var/mob/living/carbon/human/human_holder = new_holder
		var/obj/item/organ/tongue/tongue = human_holder.get_organ_by_type(/obj/item/organ/tongue)
		tongue?.liked_foodtypes = initial(tongue.liked_foodtypes)
		tongue?.disliked_foodtypes = initial(tongue.disliked_foodtypes)
		tongue?.toxic_foodtypes = initial(tongue.toxic_foodtypes)
