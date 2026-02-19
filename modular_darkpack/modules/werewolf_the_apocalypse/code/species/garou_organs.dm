// Organs and limbs are applied where it makes sense to limited behavoir.
// e.g only the proper dogs on all 4s get the brain as that is to restrict there use of tools and force biting.

/obj/item/bodypart/head/fera
	// limb_id = SPECIES_FERA
	head_flags = NONE
	unarmed_attack_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_bite.ogg'

/obj/item/bodypart/chest/fera
	// limb_id = SPECIES_FERA

/obj/item/bodypart/arm/left/fera
	// limb_id = SPECIES_FERA
	unarmed_attack_verbs = list("claw")
	unarmed_attack_verbs_continuous = list("claws")
	appendage_noun = "paw"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_bite.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/right/fera
	// limb_id = SPECIES_FERA
	unarmed_attack_verbs = list("claw")
	unarmed_attack_verbs_continuous = list("claws")
	appendage_noun = "paw"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_bite.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/left/fera
	// limb_id = SPECIES_FERA

/obj/item/bodypart/leg/right/fera
	// limb_id = SPECIES_FERA


// Specificly to restrict use of tools... because that was moved to the brain..
/obj/item/organ/brain/fera
	name = "exotic brain"
	organ_traits = list(TRAIT_LITERATE, TRAIT_CAN_STRIP)

/obj/item/organ/brain/fera/get_attacking_limb(mob/living/carbon/human/target)
	if(!HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER) || HAS_TRAIT(owner, TRAIT_FERAL_BITER))
		return owner.get_bodypart(BODY_ZONE_HEAD)
	return ..()

/obj/item/organ/tongue/fera
	name = "exotic tongue"
	languages_native = list(/datum/language/garou_tongue)

// Garou tongues can speak all default + garou tongue
/obj/item/organ/tongue/fera/get_possible_languages()
	return ..() + /datum/language/garou_tongue
