// List of Breeds that a garou can be.
#define BREED_HOMID "Homid"
#define BREED_LUPUS "Lupus"
#define BREED_CRINOS "Metis" //Its called metis because anything player facing should only show "Metis" instead of "Crinos", despite it being a crinos form. Blame gadabout.

GLOBAL_LIST_INIT(garou_breeds, list(
	BREED_HOMID = BREED_HOMID,
	BREED_LUPUS = BREED_LUPUS,
	BREED_CRINOS = BREED_CRINOS,
))

#define FEATURE_GAROU_BREED "garou_breed"
