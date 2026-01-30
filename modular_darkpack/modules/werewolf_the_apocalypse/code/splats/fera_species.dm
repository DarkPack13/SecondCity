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
	var/mob_pixel_w = 0
	var/list/form_bonus_stats = list()
	/// Fallback dmi to refrence if we fail to get one from our splat
	var/fallback_icon

/datum/species/human/shifter/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(biter)
		human_who_gained_species.AddElement(/datum/element/force_paw)
	human_who_gained_species.pixel_w += mob_pixel_w
	for(var/key, value in form_bonus_stats)
		human_who_gained_species.st_add_stat_mod(key, value, type)

/datum/species/human/shifter/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	if(biter)
		human.RemoveElement(/datum/element/force_paw)
	human.pixel_w -= mob_pixel_w
	for(var/key, value in form_bonus_stats)
		human.st_remove_stat_mod(key, type)


/// Fetch the mobs fur color from their features.
/datum/species/human/shifter/proc/get_fur_color(mob/living/carbon/human/human)
	return human.dna.features[FEATURE_FUR_COLOR] ? human.dna.features[FEATURE_FUR_COLOR] : "black"


/// Fetch the mob dmi from our splat
/datum/species/human/shifter/proc/get_mob_icon(mob/living/carbon/human/human)
	var/datum/splat/werewolf/shifter/shifter_splat = isshifter(human)
	var/icon_to_use
	if(shifter_splat)
		icon_to_use = shifter_splat.mob_icons[id]

	return icon_to_use ? icon_to_use : fallback_icon



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
	fallback_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/glabro.dmi'

/datum/species/human/shifter/bestial/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	human_who_gained_species.update_mob_height()
	human_who_gained_species.update_transform(1.25)


	human_who_gained_species.remove_overlay(BODY_ADJ_LAYER)

	var/fur_color = get_fur_color(human_who_gained_species)
	var/mob_icon = get_mob_icon(human_who_gained_species)

	human_who_gained_species.overlays_standing[BODY_ADJ_LAYER] = list(image(mob_icon, fur_color))

	human_who_gained_species.apply_overlay(BODY_ADJ_LAYER)

/datum/species/human/shifter/bestial/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	human.update_mob_height()
	human.update_transform()
	human.remove_overlay(BODY_ADJ_LAYER)

/datum/species/human/shifter/bestial/update_species_heights(mob/living/carbon/human/holder)
	if(HAS_TRAIT(holder, TRAIT_DWARF))
		return HUMAN_HEIGHT_MEDIUM

	if(HAS_TRAIT(holder, TRAIT_TOO_TALL))
		return HUMAN_HEIGHT_TALLEST

	return HUMAN_HEIGHT_TALL


/datum/species/human/shifter/war
	id = SPECIES_FERA_WAR
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_BLOOD_OVERLAY,
	)
	mutanttongue = /obj/item/organ/tongue/fera
	no_equip_flags = ITEM_SLOT_ON_BODY
	form_bonus_stats = list(
		STAT_STRENGTH = 4,
		STAT_STAMINA = 3,
		STAT_DEXTERITY = 1,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
		// STAT_APPEARANCE = 0 // NOT YET SUPPORTED
	)
	mob_pixel_w = -8
	fallback_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/crinos.dmi'

/datum/species/human/shifter/war/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	var/fur_color = get_fur_color(human)
	var/mob_icon = get_mob_icon(human)

	human.overlays_standing[BODYPARTS_LAYER] = list(image(mob_icon, fur_color))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE


/datum/species/human/shifter/dire
	id = SPECIES_FERA_DIRE
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_BLOOD_OVERLAY,
	)
	mutantbrain = /obj/item/organ/brain/fera
	mutanttongue = /obj/item/organ/tongue/fera
	no_equip_flags = ITEM_SLOT_ON_BODY
	biter = TRUE
	form_bonus_stats = list(
		STAT_STRENGTH = 3,
		STAT_STAMINA = 3,
		STAT_DEXTERITY = 2,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
	)
	mob_pixel_w = -16
	fallback_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/hispo.dmi'

/datum/species/human/shifter/dire/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	var/fur_color = get_fur_color(human)
	var/mob_icon = get_mob_icon(human)

	human.overlays_standing[BODYPARTS_LAYER] = list(image(mob_icon, fur_color))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE


/datum/species/human/shifter/feral
	id = SPECIES_FERA_FERAL
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_BLOOD_OVERLAY,
	)
	mutantbrain = /obj/item/organ/brain/fera
	mutanttongue = /obj/item/organ/tongue/fera
	no_equip_flags = ITEM_SLOT_ON_BODY
	biter = TRUE
	form_bonus_stats = list(
		STAT_STRENGTH = 1,
		STAT_STAMINA = 2,
		STAT_DEXTERITY = 2,
		// STAT_MANIPULATION = 0, // NOT YET SUPPORTED
	)
	fallback_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/lupus.dmi'

/datum/species/human/shifter/feral/handle_body(mob/living/carbon/human/human)
	human.remove_overlay(BODYPARTS_LAYER)

	var/fur_color = get_fur_color(human)
	var/mob_icon = get_mob_icon(human)

	human.overlays_standing[BODYPARTS_LAYER] = list(image(mob_icon, fur_color))

	human.apply_overlay(BODYPARTS_LAYER)

	return TRUE
