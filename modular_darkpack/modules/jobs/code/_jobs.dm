// Default vampire base type.
/datum/job
	///Minimum vampire Generation necessary to do this job.
	var/minimal_generation = HIGHEST_GENERATION_LIMIT
	///Minimum Masquerade level necessary to do this job.
	var/minimal_masquerade = 0
	/// Character must be at least this age (in years) since embrace (chronological_age - age) to join as role.
	var/minimum_immortal_age = 0

	///List of species that are allowed to do this job.
	var/list/allowed_species = list(SPECIES_HUMAN, SPECIES_GHOUL, SPECIES_KINDRED)
	///List of species that are limited to a certain amount of that species doing this job.
	var/list/species_slots = list(SPECIES_HUMAN = -1, SPECIES_GHOUL = -1, SPECIES_KINDRED = -1)
	///List of Clans that are allowed to do this job.
	var/list/allowed_clans = VAMPIRE_CLAN_ALL
	///If this job requires whitelisting before it can be selected for characters.
	var/whitelisted = FALSE

	// Only for display in memories
	var/list/known_contacts = null

// Default vampire job outfits.
/datum/outfit/job/vampire
	uniform = /obj/item/clothing/under/color/grey
	id = null
	ears = null
	belt = null
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	box = null
	pda_slot = null

/datum/outfit/job/vampire/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	var/obj/item/smartphone/phone = locate() in user.contents
	if(phone)
		phone.owner_weakref = WEAKREF(user)
		phone.update_initialized_contacts()

/**
 * This type is used to indicate a lack of a job.
 * The mind variable assigned_role will point here by default.
 * As any other job datum, this is a singleton.
 **/

/datum/job/vampire/unassigned
	title = JOB_ORDINARY_CITIZEN
	rpg_title = "Peasant"


/// Returns information pertaining to this job's radio.
/datum/job/vampire/get_radio_information()
	return
