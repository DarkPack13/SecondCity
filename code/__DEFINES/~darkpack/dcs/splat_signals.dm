/// From /datum/splat/assign(): (mob/living/source, datum/splat/splat)
#define COMSIG_LIVING_GAINING_SPLAT "living_gaining_splat"
	/// Prevent the splat from being gained, cancel assign()
	#define SPLAT_PREVENT_GAIN (1<<0)
/// From /datum/splat/assign(): (mob/living/source, datum/splat/splat)
#define COMSIG_LIVING_GAINED_SPLAT "living_gained_splat"

/// From /datum/splat/unassign(): (mob/living/source, datum/splat/splat)
#define COMSIG_LIVING_LOSE_SPLAT "living_lose_splat"
