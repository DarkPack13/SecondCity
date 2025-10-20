#define FEATURE_FERA_BREED "garou_breed"

#define BREED_HOMID "Homid"
#define BREED_LUPUS "Lupus"
#define BREED_CRINOS "Metis" //Its called metis because anything player facing should only show "Metis" instead of "Crinos", despite it being a crinos form. Blame gadabout.

GLOBAL_LIST_INIT(fera_breeds, list(
	BREED_HOMID = /mob/living/carbon/human/fera,
	BREED_LUPUS = /mob/living/carbon/human/fera/lupus,
	BREED_CRINOS = /mob/living/carbon/human/fera/crinos,
))
