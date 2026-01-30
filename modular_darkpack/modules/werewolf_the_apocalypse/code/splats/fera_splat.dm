// Represents the system not that they are a werewolf/fera
/datum/splat/werewolf
	abstract_type = /datum/splat/werewolf

	// var/start_rage = 1
	var/rage = 1
	// var/start_gnosis = 1
	var/gnosis = 1

/datum/splat/werewolf/kinfolk
	name = "Kinfolk"
	splat_traits = list(
		TRAIT_FRENETIC_AURA
	)
	id = SPLAT_KINFOLK

/datum/splat/werewolf/shifter
	abstract_type = /datum/splat/werewolf/shifter
	splat_traits = list(
		TRAIT_WTA_GAROU_BREED,
		TRAIT_WTA_GAROU_AUSPICE,
		TRAIT_WTA_GAROU_TRIBE,
		TRAIT_FRENETIC_AURA
	)
	id = SPLAT_FERA
	var/datum/action/cooldown/fera_transform/fera_transformation
	var/list/transformation_list = list()
	/**
	 * [SPECIES_ID -> dmi path] assoc list
	 *
	 * Only required for forms that you can into (corax lack dire and bestial)
	 * and acctually have custom sprite behavoir (homid are exempt, bestial are fluff added to homid)
	 */
	var/list/mob_icons = list(
		SPECIES_FERA_BESTIAL = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/glabro.dmi',
		SPECIES_FERA_WAR = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/crinos.dmi',
		SPECIES_FERA_DIRE = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/hispo.dmi',
		SPECIES_FERA_FERAL = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/lupus.dmi'
	)

/datum/splat/werewolf/shifter/on_gain()
	. = ..()
	owner.set_species(/datum/species/human/shifter/homid)
	fera_transformation = new(owner, transformations = transformation_list)
	fera_transformation.Grant(owner)

/datum/splat/werewolf/shifter/on_lose_or_destroy()
	. = ..()
	if(!QDELETED(owner))
		owner.set_species(/datum/species/human)
	fera_transformation.Remove(owner)
	QDEL_NULL(fera_transformation)

/datum/splat/werewolf/shifter/garou
	name = "Garou"
	id = SPLAT_GAROU
	transformation_list = list(
		/datum/species/human/shifter/homid,
		/datum/species/human/shifter/bestial,
		/datum/species/human/shifter/war,
		/datum/species/human/shifter/dire,
		/datum/species/human/shifter/feral
	)

/* // DARKPACK TODO - CORAX
/datum/splat/werewolf/shifter/corax
	name = "Corax"
	id = SPLAT_CORAX
	transformation_list = list(
		/datum/species/human/shifter/homid,
		/datum/species/human/shifter/war,
		/datum/species/human/shifter/feral
	)
	mob_icons = list(
		SPECIES_FERA_WAR = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/crinos.dmi',
		SPECIES_FERA_FERAL = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	)
*/
