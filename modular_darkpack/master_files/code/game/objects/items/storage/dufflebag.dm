// DARKPACK - Unique dufflebag type, has exemptions for certain weapons/items and a cap of 2 exemptions.
/obj/item/storage/backpack/duffelbag/darkpack
	storage_type = /datum/storage/duffel/darkpack

// Subtype for surgery, just so it acts like the unqiue variant
/obj/item/storage/backpack/duffelbag/darkpack/surgery
	name = "surgical duffel bag"
	desc = "A large duffel bag for holding extra supplies - this one has a material inlay with space for various sharp-looking tools."
	icon_state = "duffel-medical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/darkpack/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/blood_filter(src)
