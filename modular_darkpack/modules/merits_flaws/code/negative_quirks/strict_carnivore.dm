//Werewolf: the Apocalypse 20th Anniversary Edition, 473
/datum/quirk/darkpack/strict_carnivore
	name = "Strict Carnivore"
	desc = {"Vegetarian is just another way of saying lazy hunter.
You can only subsist on meat — the closer to raw, the better.
You have real problems in areas where meat is scarce."}
	icon = FA_ICON_CLOUD_MEATBALL
	value = -1
	allowed_splats = list(SPLAT_GAROU)

/datum/quirk/strict_carnivore/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		tongue.liked_foodtypes = MEAT | SEAFOOD | GORE
		tongue.disliked_foodtypes = VEGETABLES | GRAIN | FRUIT | NUTS | CLOTH | GROSS

/datum/quirk/strict_carnivore/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
		tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
