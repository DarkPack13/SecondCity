#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/zombie
	name = "Zombie"
	id = "zombie"
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LIMBATTACHMENT, TRAIT_VIRUSIMMUNE, TRAIT_NOBLOOD, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE, TRAIT_FAKEDEATH)
	//mutantbrain = /obj/item/organ/brain/vampire //to prevent brain transplant surgery
	//mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	heatmod = 1
	mutanttongue = /obj/item/organ/tongue

/datum/species/zombie/check_roundstart_eligible()
	return FALSE

/datum/species/zombie/on_species_gain(mob/living/carbon/human/C)
	..()
	C.skin_tone = "albino"
	C.hairstyle = "Bald"
	C.update_body_parts()
	C.update_body(0)

	C.set_body_sprite("rotten2")

	C.maxHealth = 300 //tanky
	C.health = 300

	/* // DARKPACK TODO -- kj shit?
	C.yang_chi = 0
	C.max_yang_chi = 0
	C.yin_chi = 6
	C.max_yin_chi = 6
	*/

	//zombies resist vampire bites better than mortals
	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_zombie_bitten))
	ADD_TRAIT(C, TRAIT_MASQUERADE_VIOLATING_FACE, "zombie")

/datum/species/zombie/proc/on_zombie_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(iszombie(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS

// wtf is this? it applies the kiss status effect?
///datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	//. = ..()
	//UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)

#undef REGENERATION_DELAY
