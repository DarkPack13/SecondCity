
//------------HELMET------------
/obj/item/clothing/mask/gas/darkpack_ert
	name = "\improper Military Gas Mask"
	desc = "A close-fitting tactical gas mask designed to protect against biological hazards and public accountability."
	icon_state = "gasmask_NG"
	icon = 'modular_darkpack/modules/ert/icons/clothing.dmi'
	inhand_icon_state = null
	worn_icon = 'modular_darkpack/modules/ert/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/onfloor.dmi')
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDEHAIR | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	fishing_modifier = 2
	pepper_tint = FALSE


/obj/item/clothing/mask/gas/darkpack_ert/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('modular_darkpack/modules/ert/icons/worn.dmi', "gasmask_emissive", src, alpha = src.alpha)

/obj/item/clothing/mask/gas/darkpack_ert/pentex
	name = "\improper Corporate Gas Mask"
	desc = "Provides protection from smoke, smog, and whatever biological horror is rampaging through your clandestine laboratory."
	icon_state = "gasmask_pentex"

//------------WEAPONS------------
/obj/item/gun/ballistic/rocketlauncher/darkpack
	name = "\improper RPG-7 Weapons System" //Currently soley for admin shenanigans, potentially implemented at a later date
	desc = "A reusable rocket propelled grenade launcher."
	icon = 'modular_darkpack/modules/ert/icons/64x32weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/ert/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/ert/icons/lefthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/onfloor48.dmi')
	worn_icon = 'modular_darkpack/modules/ert/icons/worn.dmi' //this is technically a bad idea, but whatever
	icon_state = "rpg7"
	inhand_icon_state = "rpg7"
	worn_icon_state = "rpg7"
	pin = /obj/item/firing_pin

