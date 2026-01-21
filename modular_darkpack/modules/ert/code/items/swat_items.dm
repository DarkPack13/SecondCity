/obj/item/storage/belt/police/swat
	name = "swat belt"
	desc = "Can hold SWAT gear like handcuffs."
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/police/swat/full

/obj/item/storage/belt/police/swat/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/vamp(src)
