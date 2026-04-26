// splat whitelist defines
#define WHITELIST_HUMAN    "human"
#define WHITELIST_VAMPIRE  "vampire"
#define WHITELIST_GHOUL    "ghoul"
#define WHITELIST_KINFOLK  "kinfolk"
#define WHITELIST_GAROU    "garou"
#define WHITELIST_TRUSTED  "trusted"


GLOBAL_LIST_INIT(default_player_whitelists, list(
	WHITELIST_HUMAN,
	WHITELIST_VAMPIRE,
	WHITELIST_GHOUL,
))

GLOBAL_LIST_INIT(splat_whitelists, list(
	SPLAT_KINDRED = WHITELIST_VAMPIRE,
	SPLAT_GHOUL   = WHITELIST_GHOUL,
	SPLAT_GAROU   = WHITELIST_GAROU,
	SPLAT_KINFOLK = WHITELIST_KINFOLK,
))
