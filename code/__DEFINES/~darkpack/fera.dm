#define FEATURE_FERA_BREED "garou_breed"

#define BREED_HOMID "Homid"
#define BREED_LUPUS "Lupus"
#define BREED_CRINOS "Metis" //Its called metis because anything player facing should only show "Metis" instead of "Crinos", despite it being a crinos form. Blame gadabout.

GLOBAL_LIST_INIT(fera_breeds, list(
	BREED_HOMID = /datum/species/human/shifter/homid,
	BREED_LUPUS = /datum/species/human/shifter/war,
	BREED_CRINOS = /datum/species/human/shifter/feral,
))

// Breeds
GLOBAL_LIST_INIT(garou_breeds, list(
	BREED_HOMID = /datum/species/human/shifter/homid,
	BREED_LUPUS = /datum/species/human/shifter/war,
	BREED_CRINOS = /datum/species/human/shifter/feral,
))
