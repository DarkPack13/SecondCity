/obj/item/organ/wings/functional/gargoyle
	name = "gargoyle wings"
	desc = "The stony wings of a gargoyle. It looks like a statue, but when you touch it, it feels almost... fleshy..."
	restyle_flags = EXTERNAL_RESTYLE_FLESH
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/gargoyle
	sprite_accessory_override = /datum/sprite_accessory/wings/gargoyle

/datum/bodypart_overlay/mutant/wings/functional/gargoyle

/datum/bodypart_overlay/mutant/wings/functional/gargoyle/get_image(image_layer, obj/item/bodypart/limb)
	// parent handles appearance we just need to offset
	var/mutable_appearance/appearance = ..()
	appearance.pixel_x = -16
	return appearance
