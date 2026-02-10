/datum/species/garou
	name = "Werewolf"
	id = "garou"
	default_color = "FFFFFF"
	toxic_food = PINEAPPLE
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_PERFECT_ATTACKER)
	use_skintones = TRUE
	limbs_id = "human"
	wings_icon = "Dragon"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 0.75
	heatmod = 1
	burnmod = 1
	dust_anim = "dust-h"
	whitelisted = TRUE
	selectable = TRUE
	var/glabro = FALSE

/datum/species/garou/on_species_gain(mob/living/carbon/human/C)
	. = ..()
//	ADD_TRAIT(C, TRAIT_NOBLEED, HIGHLANDER)
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/gift/glabro/glabro = new()
	glabro.Grant(C)
	var/datum/action/gift/rage_heal/GH = new()
	GH.Grant(C)
	C.transformator = new(C)
	C.transformator.human_form = C

	//garou resist vampire bites better than mortals
	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(C.transformator.lupus_form, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(C.transformator.crinos_form, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))

/datum/species/garou/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(C.transformator.lupus_form, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(C.transformator.crinos_form, COMSIG_MOB_VAMPIRE_SUCKED)
	for(var/datum/action/gift/G in C.actions)
		G.Remove(C)

/datum/species/garou/check_roundstart_eligible()
	return FALSE

/proc/adjust_rage(amount, mob/living/carbon/C, sound = TRUE)
	if(amount > 0)
		if(C.auspice.rage < 10)
			if(sound)
				SEND_SOUND(C, sound('modular_darkpack/modules/deprecated/sounds/rage_increase.ogg', volume = 75))
			to_chat(C, span_userdanger("<b>RAGE INCREASES</b>"))
			C.auspice.rage = min(10, C.auspice.rage+amount)
	if(amount < 0)
		if(C.auspice.rage > 0)
			C.auspice.rage = max(0, C.auspice.rage+amount)
			if(sound)
				SEND_SOUND(C, sound('modular_darkpack/modules/deprecated/sounds/rage_decrease.ogg', volume = 75))
			to_chat(C, span_userdanger("<b>RAGE DECREASES</b>"))
	C.update_rage_hud()

/proc/adjust_gnosis(amount, mob/living/carbon/C, sound = TRUE)
	if(amount > 0)
		if(C.auspice.gnosis < C.auspice.start_gnosis)
			if(sound)
				SEND_SOUND(C, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', volume = 75))
			to_chat(C, span_boldnotice("<b>GNOSIS INCREASES</b>"))
			C.auspice.gnosis = min(C.auspice.start_gnosis, C.auspice.gnosis+amount)
	if(amount < 0)
		if(C.auspice.gnosis > 0)
			C.auspice.gnosis = max(0, C.auspice.gnosis+amount)
			if(sound)
				SEND_SOUND(C, sound('modular_darkpack/modules/deprecated/sounds/rage_decrease.ogg', volume = 75))
			to_chat(C, span_boldnotice("<b>GNOSIS DECREASES</b>"))
	C.update_rage_hud()

/**
 * On being bit by a vampire
 *
 * This handles vampire bite sleep immunity and any future special interactions.
 */
/datum/species/garou/proc/on_garou_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(isgarou(being_bitten) || iswerewolf(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS
