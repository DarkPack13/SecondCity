//Bygone Bestiary Page 108
/datum/quirk/strong_stomach/cast_iron_stomach
	name = "Cast-Iron Stomach"
	desc = {"You can eat anything remotely similar to food and
			gain nourishment from it. Carrion, straw, bones; it's all dinner.
			As for the smell, well, you get used to it... "}
	value = 1

/datum/quirk/strong_stomach/cast_iron_stomach/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = NONE

/datum/quirk/strong_stomach/cast_iron_stomach/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
