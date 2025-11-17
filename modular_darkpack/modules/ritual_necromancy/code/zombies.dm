#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/zombie
	name = "Zombie"
	id = "zombie"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LIMBATTACHMENT, TRAIT_VIRUSIMMUNE, TRAIT_NOBLEED, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_NOMETABOLISM, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE, TRAIT_FAKEDEATH)
	use_skintones = TRUE
	limbs_id = "rotten2"
	mutantbrain = /obj/item/organ/brain/vampire //to prevent brain transplant surgery
	mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	brutemod = 0.5
	heatmod = 1
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	bodytemp_normal = T0C // They have no natural body heat, the environment regulates body temp
	dust_anim = "dust-h"

/datum/species/zombie/check_roundstart_eligible()
	return FALSE

/datum/species/zombie/on_species_gain(mob/living/carbon/human/C)
	..()
	C.skin_tone = "albino"
	C.hairstyle = "Bald"
	C.base_body_mod = ""
	C.update_body_parts()
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/zombieinfo/infor = new()
	infor.host = C
	infor.Grant(C)
	C.set_body_sprite("rotten2")

	C.maxHealth = 300 //tanky
	C.health = 300

	C.yang_chi = 0
	C.max_yang_chi = 0
	C.yin_chi = 6
	C.max_yin_chi = 6

	//zombies resist vampire bites better than mortals
	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_zombie_bitten))
	ADD_TRAIT(C, TRAIT_MASQUERADE_VIOLATING_FACE, "zombie")

/datum/species/zombie/proc/on_zombie_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(iszombie(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)
	for(var/datum/action/zombieinfo/infor in C.actions)
		if(infor)
			infor.Remove(C)

#undef REGENERATION_DELAY
