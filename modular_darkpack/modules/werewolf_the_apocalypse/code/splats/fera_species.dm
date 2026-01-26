//Required so werewolves can almost entirely override body rendering
/mob/living/carbon/human/update_body_parts(update_limb_data)
	if(dna?.species?.handle_body(src))
		return
	..()

/datum/species/proc/handle_body(mob/living/carbon/human/human)
	return

/datum/species/human/shifter
	name = "Fera"
	plural_form = "Fera"
	id = SPECIES_FERA
	species_language_holder = /datum/language_holder/garou
	var/biter = FALSE
	var/list/form_bonus_stats = list()

/datum/species/human/shifter/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(biter)
		human_who_gained_species.AddElement(/datum/element/human_biter)

/datum/species/human/shifter/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	if(biter)
		human.RemoveElement(/datum/element/human_biter)


/datum/species/human/shifter/homid
	id = SPECIES_FERA_HOMID


/datum/species/human/shifter/bestial
	id = SPECIES_FERA_BESTIAL
	form_bonus_stats = list(
		STAT_STRENGTH = 3,
		STAT_STAMINA = 2,
		STAT_MANIPULATION = -2,
		STAT_APPEARANCE = -1
	)

/datum/species/human/shifter/bestial/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	human_who_gained_species.update_mob_height()
	human_who_gained_species.update_transform(1.25)

/datum/species/human/shifter/bestial/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	human.update_mob_height()
	human.update_transform()

/datum/species/human/shifter/bestial/update_species_heights(mob/living/carbon/human/holder)
	if(HAS_TRAIT(holder, TRAIT_DWARF))
		return HUMAN_HEIGHT_MEDIUM

	if(HAS_TRAIT(holder, TRAIT_TOO_TALL))
		return HUMAN_HEIGHT_TALLEST

	return HUMAN_HEIGHT_TALL


/datum/species/human/shifter/war
	id = SPECIES_FERA_WAR
	mutanttongue = /obj/item/organ/tongue/garou
	no_equip_flags = ITEM_SLOT_ON_BODY
	form_bonus_stats = list(
		STAT_STRENGTH = 4,
		STAT_STAMINA = 3,
		STAT_DEXTERITY = 1,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
		// STAT_APPEARANCE = 0 // NOT YET SUPPORTED
	)

/datum/species/human/shifter/war/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	human.overlays_standing[BODYPARTS_LAYER] = list(image('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/crinos.dmi', "black"))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE


/datum/species/human/shifter/dire
	id = SPECIES_FERA_DIRE
	mutanttongue = /obj/item/organ/tongue/garou
	no_equip_flags = ITEM_SLOT_ON_BODY
	biter = TRUE
	form_bonus_stats = list(
		STAT_STRENGTH = 3,
		STAT_STAMINA = 3,
		STAT_DEXTERITY = 2,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
	)

/datum/species/human/shifter/dire/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	human.overlays_standing[BODYPARTS_LAYER] = list(image('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/hispo.dmi', "black"))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE


/datum/species/human/shifter/feral
	id = SPECIES_FERA_FERAL
	mutanttongue = /obj/item/organ/tongue/garou
	no_equip_flags = ITEM_SLOT_ON_BODY
	biter = TRUE
	form_bonus_stats = list(
		STAT_STRENGTH = 1,
		STAT_STAMINA = 2,
		STAT_DEXTERITY = 2,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
	)

/datum/species/human/shifter/feral/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	human.overlays_standing[BODYPARTS_LAYER] = list(image('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/lupus.dmi', "black"))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE
