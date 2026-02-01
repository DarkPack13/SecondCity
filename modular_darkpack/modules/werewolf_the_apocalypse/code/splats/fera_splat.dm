#define MAX_RAGE 10
// gnois max is capped by its starting gnosis

// Represents the system not that they are a werewolf/fera
/datum/splat/werewolf
	abstract_type = /datum/splat/werewolf

	var/uses_rage = FALSE
	var/start_rage = 0
	var/rage = 0
	// without a merit kinfolk cannot use gnosis
	var/uses_gnosis = FALSE
	var/start_gnosis = 0
	var/gnosis = 0

/datum/splat/werewolf/add_relevent_huds(datum/hud/hud_used)
	hud_used.add_werewolf_elements()

/datum/splat/werewolf/proc/adjust_rage(amount, sound = TRUE)
	if(!uses_rage)
		return

	if(amount > 0)
		if(rage < MAX_RAGE)
			if(sound)
				SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/rage_increase.ogg', 0, 0, 50))
			to_chat(owner, span_userdanger("<b>RAGE INCREASES</b>"))
			rage = min(MAX_RAGE, rage+amount)
	if(amount < 0)
		if(rage > 0)
			rage = max(0, rage+amount)
			if(sound)
				SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/rage_decrease.ogg', 0, 0, 50))
			to_chat(owner, span_userdanger("<b>RAGE DECREASES</b>"))

	owner.update_werewolf_hud()

/datum/splat/werewolf/proc/adjust_gnosis(amount, sound = TRUE)
	if(!uses_gnosis)
		return

	if(amount > 0)
		if(gnosis < start_gnosis)
			if(sound)
				SEND_SOUND(owner, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', 0, 0, 50))
			to_chat(owner, span_boldnotice("<b>GNOSIS INCREASES</b>"))
			gnosis = min(start_gnosis, gnosis + amount)
	if(amount < 0)
		if(gnosis > 0)
			gnosis = max(0, gnosis + amount)
			if(sound)
				SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/rage_decrease.ogg', 0, 0, 50))
			to_chat(owner, span_boldnotice("<b>GNOSIS DECREASES</b>"))

	owner.update_werewolf_hud()

/datum/splat/werewolf/kinfolk
	name = "Kinfolk"
	splat_traits = list()
	id = SPLAT_KINFOLK
	// incompatible_splats = list(/datum/splat/werewolf/shifter) // TODO: Becoming a shifter should get rid of your kinfolk splat

/datum/splat/werewolf/shifter
	abstract_type = /datum/splat/werewolf/shifter
	splat_traits = list(
		TRAIT_WTA_GAROU_BREED,
		TRAIT_WTA_GAROU_AUSPICE,
		TRAIT_WTA_GAROU_TRIBE,
		TRAIT_FERA_FUR,
		TRAIT_FRENETIC_AURA
	)
	id = SPLAT_FERA
	incompatible_splats = list(
		/datum/splat/werewolf
	) // We dont support being multiple fera or gaining kinfolk as a fera
	uses_rage = TRUE
	uses_gnosis = TRUE
	start_rage = 1
	start_gnosis = 1
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

#undef MAX_RAGE
