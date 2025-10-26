// Default vampire base type.
/datum/job
	///Minimum vampire Generation necessary to do this job.
	var/minimal_generation = HIGHEST_GENERATION_LIMIT
	///Minimum Masquerade level necessary to do this job.
	var/minimal_masquerade = 0
	///Minimum Renown Rank (garou) necessary to do this job.
	var/minimal_renownrank = 0
	/// Character must be at least this age (in years) to join as role.
	var/minimum_character_age = 0
	/// Character must be at least this age (in years) since embrace (chronological_age - age) to join as role.
	var/minimum_vampire_age = 0

	///List of species that are allowed to do this job.
	var/list/allowed_species = list(SPECIES_HUMAN, SPECIES_GHOUL, SPECIES_KINDRED)
	///List of species that are limited to a certain amount of that species doing this job.
	var/list/species_slots = list(SPECIES_HUMAN = -1, SPECIES_GHOUL = -1, SPECIES_KINDRED = -1)
	///List of Clans that are allowed to do this job.
	var/list/allowed_clans = VAMPIRE_CLAN_ALL
	///List of Tribes that are allowed to do this job.
	var/list/allowed_tribes = list("Galestalkers", "Ghost Council", "Hart Wardens", "Children of Gaia", "Glass Walkers", "Bone Gnawers", "Ronin", "Black Spiral Dancers", "Get of Fenris", "Black Furies", "Silver Fangs", "Silent Striders", "Shadow Lords", "Red Talons", "Stargazers")
	///List of Auspices that are allowed to do this job.
	var/list/allowed_auspice = list("Philodox", "Galliard", "Ragabash", "Theurge", "Ahroun")
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
