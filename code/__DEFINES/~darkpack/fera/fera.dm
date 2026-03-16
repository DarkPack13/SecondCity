/// How long it takes for a werewolf's Veil to naturally repair
// #define UMBRA_VEIL_COOLDOWN 15 MINUTES
/// How long it takes for a werewolf to regenerate a blood point
// #define FERA_BP_REGEN 60 SECONDS // I cant find a source to this.
/// Cooldown between Veil violations
// #define VEIL_COOLDOWN 20 SECONDS

#define MAX_RAGE 10
#define MAX_GNOSIS 10
#define PRIMAL_URGE_PLACEHOLDER 3

#define BREED_HOMID "Homid"
#define BREED_LUPUS "Lupus"
#define BREED_CRINOS "Metis" //Its called metis because anything player facing should only show "Metis" instead of "Crinos", despite it being a crinos form. Blame gadabout.

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

#define STATUS_EFFECT_SILVER_BULLLET_STACKS /datum/status_effect/stacking/silver_bullets
