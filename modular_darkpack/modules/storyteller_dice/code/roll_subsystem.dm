SUBSYSTEM_DEF(roll)
	name = "Dice Rolling"
	flags = SS_NO_FIRE
	var/on_crit_extra_die_enabled = FALSE
	var/on_crit_extra_success_enabled = FALSE

/datum/controller/subsystem/roll/Initialize()
	on_crit_extra_die_enabled = CONFIG_GET(flag/on_crit_additional_die)
	on_crit_extra_success_enabled = CONFIG_GET(flag/on_crit_additional_success)
	return SS_INIT_SUCCESS

/**
 * Rolls a number of dice according to Storyteller system rules to find
 * success or number of successes.
 *
 * Rolls a number of 10-sided dice, counting them as a "success" if
 * they land on a number equal to or greater than the difficulty. Dice
 * that land on 1 subtract a success from the total, and the minimum
 * difficulty is 2. The number of successes is returned if numerical
 * is true, or the roll outcome (botch, failure, success) as a defined
 * number if false.
 *
 * Arguments:
 * * dice - number of 10-sided dice to roll.
 * * difficulty - the number that a dice must come up as to count as a success.
 * * roller - the mob who is making the role and owns the dice
 * * numerical - whether the proc returns number of successes or outcome (botch, failure, success)
 */
/datum/controller/subsystem/roll/proc/storyteller_roll(dice = 1, difficulty = 6, mob/living/roller = null, numerical = FALSE)
	var/datum/storyteller_roll/dice_roll = new()
	dice_roll.difficulty = difficulty
	dice_roll.numerical = numerical
	return dice_roll.st_roll(roller, roller, dice)

//Config datums for exploding dice
/datum/config_entry/flag/on_crit_additional_success

/datum/config_entry/flag/on_crit_additional_die

// If having 0 dot in abilities can hardlock you out of features
/datum/config_entry/flag/punishing_zero_dots
