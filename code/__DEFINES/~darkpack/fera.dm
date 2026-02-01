#define FEATURE_FERA_BREED "garou_breed"

#define BREED_HOMID "Homid"
#define BREED_LUPUS "Lupus"
#define BREED_CRINOS "Metis" //Its called metis because anything player facing should only show "Metis" instead of "Crinos", despite it being a crinos form. Blame gadabout.

GLOBAL_LIST_INIT(fera_breeds, list(
	BREED_HOMID = /datum/species/human/shifter/homid,
	BREED_LUPUS = /datum/species/human/shifter/feral,
	BREED_CRINOS = /datum/species/human/shifter/war,
))

// Breeds
GLOBAL_LIST_INIT(garou_breeds, list(
	BREED_HOMID = /datum/species/human/shifter/homid,
	BREED_LUPUS = /datum/species/human/shifter/feral,
	BREED_CRINOS = /datum/species/human/shifter/war,
))

#define FEATURE_FUR_COLOR "fera_fur"

// fera will likely have a seperate list of colors but uses the same feature or var as other fera
GLOBAL_LIST_INIT(garou_fur_colors, list(
	"black" = "black",
	"gray" = "gray",
	"red" = "red",
	"white" = "white",
	"ginger" = "ginger",
	"brown" = "brown"
))

#define MOON_NEW "new moon"
#define MOON_WAXING_CRESENT "waxing cresent"
#define MOON_FIRST_QUARTER "first quarter"
#define MOON_WAXING_GIBBOUS "waxing gibbous"
#define MOON_FULL "full moon"
#define MOON_WANING_GIBBOUS "waning gibbous"
#define MOON_LAST_QUARTER "last quarter"
#define MOON_WANING_CRESCENT "waning crescent"

