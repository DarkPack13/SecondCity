/obj/item/bodypart/arm/left/darkpack/prosthetic
	name = "left prosthetic arm"
	desc = "A prosthetic arm made with carbon fiber with a mix of titanium and aluminum frame for support and rigidity. While it lacks use of its fingers for the most part it allows for limited mobility and accessability."
	icon = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	icon_static = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	limb_id = BODYPART_ID_PROS
	icon_state = "prosthetic_l_arm"
	bodytype = BODYTYPE_PEG		//We use peg for easy amputation + limits surgery types capable on it. New body type not really needed; we make do.
	should_draw_greyscale = FALSE
	attack_verb_simple = list("bashed", "smashed")
	unarmed_effectiveness = 5	//Base is 10, we halve it.
	brute_modifier = 1.1		//Slightly more damage than normal; same burn damage though as normal.
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_PROSTHETIC_LIMB)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_METAL|BIO_JOINTED)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/arm/left/darkpack/prosthetic/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/arm/right/darkpack/prosthetic
	name = "right prosthetic arm"
	desc = "A prosthetic arm made with carbon fiber with a mix of titanium and aluminum frame for support and rigidity. While it lacks use of its fingers for the most part it allows for limited mobility and accessability."
	icon = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	icon_static = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	limb_id = BODYPART_ID_PROS
	icon_state = "prosthetic_r_arm"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	attack_verb_simple = list("bashed", "smashed")
	unarmed_effectiveness = 5
	brute_modifier = 1.1
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_PROSTHETIC_LIMB)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_METAL|BIO_JOINTED)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/arm/right/darkpack/prosthetic/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/left/darkpack/prosthetic
	name = "left prosthetic leg"
	desc = "A prosthetic leg, complete with a comfortable cup structure for mounting and support while sporting a mix of titanium and aluminum frame for support and rigidity. It feels a bit clunky to walk in but far easier than that of canes or crutches for support."
	icon = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	icon_static = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	limb_id = BODYPART_ID_PROS
	icon_state = "prosthetic_l_leg"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	unarmed_effectiveness = 10	//Base is 15, we halve it.
	brute_modifier = 1.1
	speed_modifier = 0.15		//+15% slowdown, kinda impactful.
	bodypart_traits = list(TRAIT_PARALYSIS)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_METAL|BIO_JOINTED)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/leg/left/darkpack/prosthetic/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/right/darkpack/prosthetic
	name = "right prosthetic leg"
	desc = "A prosthetic leg, complete with a comfortable cup structure for mounting and support while sporting a mix of titanium and aluminum frame for support and rigidity. It feels a bit clunky to walk in but far easier than that of canes or crutches for support."
	icon = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	icon_static = 'modular_darkpack/modules/surgery/icons/bodyparts/prosthetics.dmi'
	limb_id = BODYPART_ID_PROS
	icon_state = "prosthetic_r_leg"
	bodytype = BODYTYPE_PEG
	should_draw_greyscale = FALSE
	unarmed_effectiveness = 10
	brute_modifier = 1.1
	speed_modifier = 0.15
	bodypart_traits = list(TRAIT_PARALYSIS)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = (BIO_METAL|BIO_JOINTED)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	butcher_replacement = null

/obj/item/bodypart/leg/right/darkpack/prosthetic/Initialize(mapload, ...)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

// Helper technically - just a carbon check used in item_attack.dm for checking if the mob has the unique prosthetic bodypart trait.
/mob/living/carbon/human/proc/check_prosthetics()
	if(HAS_TRAIT_NOT_FROM(src, TRAIT_PROSTHETIC_LIMB, RIGHT_ARM_TRAIT) && HAS_TRAIT_NOT_FROM(src, TRAIT_PROSTHETIC_LIMB, LEFT_ARM_TRAIT))
		return TRUE
	return IS_LEFT_INDEX(active_hand_index) ? HAS_TRAIT_FROM(src, TRAIT_PROSTHETIC_LIMB, LEFT_ARM_TRAIT) : HAS_TRAIT_FROM(src, TRAIT_PROSTHETIC_LIMB, RIGHT_ARM_TRAIT)
