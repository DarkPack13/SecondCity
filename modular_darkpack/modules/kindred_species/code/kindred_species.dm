/**
 * This is the splat (supernatural type, game line in the World of Darkness) container
 * for all vampire-related code. I think this is stupid and I don't want any of this to
 * be the way it is, but if we're going to work with the code that's been written then
 * my advice is to centralise all stuff directly relating to vampires to here if it isn't
 * already in another organisational structure.
 *
 * The same applies to other splats, like /datum/species/garou or /datum/species/ghoul.
 * Halfsplats like ghouls are going to share some code with their fullsplats (vampires).
 * I dunno what to do about this except a reorganisation to make this stuff actually good.
 * The plan right now is to create a /datum/splat parent type and then have everything branch
 * from there, but that's for the future.
 */

/datum/species/human/kindred
	name = "Kindred"
	plural_form = "Kindred"
	id = SPECIES_KINDRED
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_RADIMMUNE,
		TRAIT_CAN_ENTER_TORPOR,
		TRAIT_VTM_MORALITY,
		TRAIT_VTM_CLANS,
		TRAIT_UNAGING,
		TRAIT_NO_DNA_COPY,
		TRAIT_DRINKS_BLOOD
	)
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN
	coldmod = 0.25
	heatmod = 2
	mutanttongue = /obj/item/organ/tongue/kindred
	exotic_bloodtype = BLOOD_TYPE_KINDRED
	var/datum/vampire_clan/clan
	var/enlightenment
	COOLDOWN_DECLARE(torpor_timer)

/mob/living/carbon/human/species/kindred
	race = /datum/species/human/kindred

/datum/species/human/kindred/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#333333", update = FALSE)
	human.set_hairstyle("Undercut Left", update = TRUE)
	human.set_eye_color("#ff0000")
	human.undershirt = "T-Shirt (Red)"
	human.update_body()
	human.equipOutfit(/datum/outfit/job/prince)

/datum/species/human/kindred/on_species_gain(mob/living/carbon/human/new_kindred, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()

	if(pref_load)
		GLOB.kindred_list |= new_kindred

	var/datum/action/cooldown/mob_cooldown/give_vitae/vitae = new()
	vitae.Grant(new_kindred)

	var/datum/action/cooldown/blood_power/bloodpower = new()
	bloodpower.Grant(new_kindred)

	// TODO: [Rebase] reimplement these vars and the actions
	/*
	var/datum/action/vampireinfo/infor = new()
	infor.host = new_kindred
	infor.Grant(new_kindred)

	add_verb(new_kindred, TYPE_VERB_REF(/mob/living/carbon/human, teach_discipline))
	*/

	//this needs to be adjusted to be more accurate for blood spending rates
	var/datum/discipline/bloodheal/giving_bloodheal = new(clamp(11 - new_kindred.generation, 1, 10))
	new_kindred.give_discipline(giving_bloodheal)

	//vampires die instantly upon having their heart removed
	RegisterSignal(new_kindred, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(handle_lose_organ))

	//vampires don't die while in crit, they just slip into torpor after 2 minutes of being critted
	RegisterSignal(new_kindred, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION), PROC_REF(handle_enter_critical_condition))

	//vampires resist vampire bites better than mortals
	RegisterSignal(new_kindred, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_vampire_bitten))

	// Apply bashing damage resistance
	RegisterSignal(new_kindred, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(damage_resistance))

	RegisterSignal(new_kindred, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(kindred_blood))

/datum/species/human/kindred/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()

	if(pref_load)
		GLOB.kindred_list -= human

	human.set_clan()

	UnregisterSignal(human, COMSIG_CARBON_LOSE_ORGAN)
	UnregisterSignal(human, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION))
	UnregisterSignal(human, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(human, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)
	UnregisterSignal(human, COMSIG_HUMAN_ON_HANDLE_BLOOD)

	// TODO: [Rebase] reimplement vampire actions
	/*
	for (var/datum/action/vampireinfo/VI in human.actions)
		VI.Remove(human)
	*/

	for (var/datum/action/A in human.actions)
		if (A.vampiric)
			A.Remove(human)

/datum/species/human/kindred/proc/damage_resistance(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER

	// Kindred take half "bashing" damage, which is normally blunt damage but includes pointy things like bullets because they're undead
	if ((damagetype == BRUTE) && (sharpness != SHARP_EDGED))
		damage_mods += 0.5

/**
 * Signal handler for lose_organ to near-instantly kill Kindred whose hearts have been removed.
 *
 * Arguments:
 * * source - The Kindred whose organ has been removed.
 * * organ - The organ which has been removed.
 */
/datum/species/human/kindred/proc/handle_lose_organ(mob/living/carbon/human/source, obj/item/organ/organ)
	SIGNAL_HANDLER

	if (!istype(organ, /obj/item/organ/heart))
		return
	// You don't want the character preview going sideways, and they lose organs a lot
	if (isdummy(source))
		return

	addtimer(CALLBACK(src, PROC_REF(lose_heart), source, organ), 0.5 SECONDS)

/datum/species/human/kindred/proc/lose_heart(mob/living/carbon/human/source, obj/item/organ/heart/heart)
	if (source.get_organ_by_type(/obj/item/organ/heart))
		return

	source.death()

/datum/species/human/kindred/proc/handle_enter_critical_condition(mob/living/carbon/human/source)
	SIGNAL_HANDLER

	to_chat(source, span_warning("You can feel yourself slipping into Torpor. You can use succumb to immediately sleep..."))
	addtimer(CALLBACK(source, TYPE_PROC_REF(/mob/living/carbon/human, torpor), "damage"), 2 MINUTES)

/datum/species/human/kindred/proc/slip_into_torpor(mob/living/carbon/human/kindred)
	if (!kindred || (kindred.stat == DEAD))
		return
	if (kindred.stat < SOFT_CRIT)
		return

	kindred.torpor("damage")

/**
 * On being bit by a vampire
 *
 * This handles vampire bite sleep immunity and any future special interactions.
 */
/datum/species/human/kindred/proc/on_vampire_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	return COMPONENT_RESIST_VAMPIRE_KISS


/obj/item/organ/tongue/kindred
	liked_foodtypes = NONE
	disliked_foodtypes = NONE
	// All food except raw meat is disgusting to Kindred
	toxic_foodtypes = ~(GORE | MEAT | RAW)

/proc/get_vamp_skin_color(value = "albino")
	switch(value)
		if("caucasian1")
			return "vamp1"
		if("caucasian2")
			return "vamp2"
		if("caucasian3")
			return "vamp3"
		if("latino")
			return "vamp4"
		if("mediterranean")
			return "vamp5"
		if("asian1")
			return "vamp6"
		if("asian2")
			return "vamp7"
		if("arab")
			return "vamp8"
		if("indian")
			return "vamp9"
		if("african1")
			return "vamp10"
		if("african2")
			return "vamp11"
		else
			return value


/datum/species/human/kindred/proc/kindred_blood(mob/living/carbon/human/kindred, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if(kindred.stat == DEAD)
		return HANDLE_BLOOD_HANDLED

	return HANDLE_BLOOD_NO_NUTRITION_DRAIN|HANDLE_BLOOD_NO_OXYLOSS

/datum/species/human/kindred/get_species_description()
	return "Blood sucking vampires of the dark realm!"

/datum/species/human/kindred/get_species_lore()
	return list(
		"Insert Kindred Lore Here",
	)

/datum/species/human/kindred/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "book-dead",
			SPECIES_PERK_NAME = "Kindred Clans",
			SPECIES_PERK_DESC = "Kindred belong to many clans, which you are able to choose in the preferences, all with their own special abilities and weaknesses!",
		),
	)

	return to_add

// Vampire blood is special, so it needs to be handled with its own entry.
/datum/species/human/kindred/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Example Negative Perk",
		SPECIES_PERK_DESC = "Lorem Ipsum",
	))

	return to_add

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/species/human/kindred/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "skull",
		SPECIES_PERK_NAME = "Minor Undead",
		SPECIES_PERK_DESC = "[name] are minor undead. \
			Minor undead enjoy some of the perks of being dead, like \
			not needing to breathe or eat, but do not get many of the \
			environmental immunities involved with being fully undead.",
	))

	return to_add
