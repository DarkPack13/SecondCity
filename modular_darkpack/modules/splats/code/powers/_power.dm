/datum/action/cooldown/power
	cooldown_time = 1 TURNS // Good default.

	/// The level/rank at which this power is taken or can be taken at.
	var/rank = 0
	// Not used presently but good future proofing incase behavoirs care.
	/// Means that this action is not a real power, but some sort of innate ability we represent as a power/disc/gift mechnaicly.
	var/innate_ability = FALSE
