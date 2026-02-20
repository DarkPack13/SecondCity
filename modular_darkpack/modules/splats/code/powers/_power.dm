/datum/action/cooldown/power
	cooldown_time = 1 TURNS // Good default.

	/// The level/rank at which this power is taken or can be taken at.
	var/rank = 0
	// Not used presently but good future proofing incase behavoirs care.
	/// Means that this action is not a real power, but some sort of innate ability we represent as a power/disc/gift mechnaicly.
	var/innate_ability = FALSE

	/// How much temporary willpower is required to use this ability
	var/willpower_req = 0

/datum/action/cooldown/power/IsAvailable(feedback)
	. = ..()

	if(willpower_req && isliving(owner))
		var/mob/living/living_owner = owner
		if(willpower_req > living_owner.st_get_stat(STAT_TEMPORARY_WILLPOWER))
			if(feedback)
				to_chat(owner, span_warning("You don't have enough willpower to do that!"))
			return FALSE

/datum/action/cooldown/power/Activate(atom/target)
	. = ..()

	if(willpower_req && isliving(owner))
		var/mob/living/living_owner = owner
		living_owner.st_change_stat(STAT_TEMPORARY_WILLPOWER, -willpower_req)
