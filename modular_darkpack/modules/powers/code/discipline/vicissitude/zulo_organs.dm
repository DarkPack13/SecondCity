////////////////////
// Sabby: this set Zulo form bodypart types used by /datum/species/tzimisce_zulo_form and its inheriting datums.
// mostly taken by using the same method as garou_organs.dm
////////////////////

/obj/item/bodypart/head/zulo
	abstract_type = /obj/item/bodypart/head/zulo
	head_flags = NONE
	is_dimorphic = FALSE

/obj/item/bodypart/chest/zulo
	is_dimorphic = FALSE

/obj/item/bodypart/arm/left/zulo
	is_dimorphic = FALSE
	unarmed_sharpness = SHARP_EDGED
	unarmed_attack_verbs = list("slash", "tear","gash","cut")
	unarmed_attack_verbs_continuous = list("slashes", "tears","gashes","cuts")
	appendage_noun = "claw"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/right/zulo
	is_dimorphic = FALSE
	unarmed_sharpness = SHARP_EDGED
	unarmed_attack_verbs = list("slash", "tear","gash","cut")
	unarmed_attack_verbs_continuous = list("slashes", "tears","gashes","cuts")
	appendage_noun = "claw"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/left/zulo
	is_dimorphic = FALSE
	unarmed_sharpness = SHARP_EDGED

/obj/item/bodypart/leg/right/zulo
	is_dimorphic = FALSE
	unarmed_sharpness = SHARP_EDGED

////////////////////
// If you'd like to create and add new Zulo form sprites in the future, follow this process:
// 1. Do your art on a program like Aseprite. Four cardinal directions. Cut its limbs into layers (check existing zulo_bodyparts.dmi for reference);
// 2. Make sure the art is 64x64 pixels or 32x32 pixels.
// 3. There is an extension to Aseprite 'aseprite-dmi' which lets you easily open and work with dmi files on it.
// 4. Open zulo_bodyparts.dmi for 64x64 pixel sprites, or bodyparts_greyscale.dmi for 32x32.
// 5. Save to new frames on the .dmi each of the six limb parts for all four cardinal directions.
// 6. Make sure to create a name for your new sprite there and use the naming pattern (i.e.: 4armstzi_head, 4armstzi_l_hand, etc.)
// 7. Create a new datum below as: 'obj/item/bodypart/head/zulo/[insert_name_of_new_sprite_here]'
// 8. Follow the pattern below to set limb_id (use the name you created for the dmi (such as '4armstzi')) and the path to the dmi.
// 9. Save and continue by following instructions on Zulo.dm
// 10. Go to zulo_forms.dmi (same folder as zulo_bodyparts).
// 11. Create a opy of your sprites that is fully flattened into one layer, no separate limbs.
// 12. Make sure it has four cardinal directions.
// 13. Add it to zulo_forms.dmi and keep the same name you used thus far.
// 14. Go to zulo.dm and follow the instructions there.
////////////////////
// Sabby: below is a clumsy solution that I'd love help improving in the future.
// Basically, the only way I could figure out to account for multiple future sprites while
// maintaining a carbon form was to create child limb objects for each (and future) sprite
// that exists and overrite the limb_id pointing of the parent obj.
// These set child limb datums for each bodypart and each possible sprite, sets it to a
// specific limb_id, to pull correctly from the .dmi.
//
// In turn, these limb datums and are pointed to by the /tzimisce_zulo_form/[name] datums
// at the bottom of zulo.dm. Those, for their part, are selected based on the global list
// created at the top of zulo.dm.
////////////////////

// Sabby: Noble form uses nobletzi limb sprites
/obj/item/bodypart/head/zulo/noble
	limb_id = "nobletzi"

/obj/item/bodypart/chest/zulo/noble
	limb_id = "nobletzi"

/obj/item/bodypart/arm/left/zulo/noble
	limb_id = "nobletzi"

/obj/item/bodypart/arm/right/zulo/noble
	limb_id = "nobletzi"


/obj/item/bodypart/leg/left/zulo/noble
	limb_id = "nobletzi"

/obj/item/bodypart/leg/right/zulo/noble
	limb_id = "nobletzi"

// Sabby: Beast form uses weretzi limb sprites
/obj/item/bodypart/head/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/chest/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/arm/left/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/arm/right/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/leg/left/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/leg/right/zulo/beast
	limb_id = "weretzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

// Sabby: Brust form uses 4armstzi limb sprites
/obj/item/bodypart/head/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/chest/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/arm/left/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/arm/right/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/leg/left/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'

/obj/item/bodypart/leg/right/zulo/brust
	limb_id = "4armstzi"
	icon_greyscale = 'modular_darkpack/modules/powers/icons/zulo_bodyparts.dmi'
