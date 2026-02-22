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

/obj/item/card/swat
	name = "Dogtags"
	desc = "The dogtags of an elite law enforcement officer. It prints the officer's name in case they're captured or killed."
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "dogtags"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/lieutenant
	name = "Officer Badge"
	desc = "The shiny badge of an elite law enforcement officer. It shines with golden authority."
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "leader"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/first_aid
	name = "First Aid Officer Card"
	desc = "The professional laminated card of a field medic. Did you know it's a war crime to specifically target field medics?"
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "first_aid"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "grey_id"
