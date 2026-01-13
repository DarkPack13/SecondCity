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
 * * mobs_to_show_output - mobs shown the result
 * * alert_atom - the atom over which balloon alerts should appear
 * * numerical - whether the proc returns number of successes or outcome (botch, failure, success)
 */
/datum/controller/subsystem/roll/proc/storyteller_roll(dice = 1, difficulty = 6, list/mobs_to_show_output = list(), atom/alert_atom = null, numerical = FALSE)
	var/list/rolled_dice = roll_dice(dice)
	if(!islist(mobs_to_show_output))
		mobs_to_show_output = list(mobs_to_show_output)
	var/list/output_text = list()
	output_text += span_notice("Rolling [length(rolled_dice)] dice against difficulty [difficulty].\n")
	var/success_count = count_success(rolled_dice, difficulty, output_text)

	var/output = roll_answer(success_count, numerical, output_text)
	for(var/mob/player_mob as anything in mobs_to_show_output)
		var/output_pref = player_mob.client?.prefs.read_preference(/datum/preference/choiced/dice_output)

		if(output_pref == DICE_OUTPUT_CHAT)
			to_chat(player_mob, jointext(output_text, ""), trailing_newline = FALSE)
		else if((output_pref == DICE_OUTPUT_BALLOON) && alert_atom)
			if(success_count > 0)
				alert_atom.balloon_alert(player_mob, "<span style='color: #14a833;'>[success_count]</span>", TRUE)
			else
				alert_atom.balloon_alert(player_mob, "<span style='color: #ff0000;'>[success_count]</span>", TRUE)

	if(numerical)
		return success_count

	return output

/datum/controller/subsystem/roll/proc/opposed_roll(mob/player_a, mob/player_b, dice_a = 1, dice_b = 1, show_player_a=TRUE, show_player_b=TRUE, atom/alert_atom = null, draw_goes_to_b=TRUE, numerical=FALSE)
	var/list/roll_a = roll_dice(dice_a)
	var/list/roll_b = roll_dice(dice_b)
	var/success_count_a = count_success_no_output(roll_a)
	var/success_count_b = count_success_no_output(roll_b)

	var/player_a_succeeded = FALSE
	if(success_count_a > success_count_b || (success_count_a == success_count_b && !draw_goes_to_b))
		player_a_succeeded = TRUE

	if(alert_atom)
		var/is_zero = ((success_count_a - success_count_b) == 0)
		if(show_player_a)
			var/alert_text
			if(player_a_succeeded)
				alert_text = "<span style='color: #14a833;'>[is_zero ?"":"+"][success_count_a - success_count_b]</span>"
			else
				alert_text = "<span style='color: #ff0000;'>[success_count_a - success_count_b]</span>"
			alert_atom.balloon_alert(player_a, alert_text, TRUE)
		if(show_player_b)
			var/alert_text
			if(!player_a_succeeded)
				alert_text = "<span style='color: #14a833;'>[is_zero ?"":"+"][success_count_b - success_count_a]</span>"
			else
				alert_text = "<span style='color: #ff0000;'>[success_count_b - success_count_a]</span>"
			alert_atom.balloon_alert(player_b, alert_text, TRUE)

	if(numerical)
		return success_count_a - success_count_b
	else
		return player_a_succeeded

/datum/controller/subsystem/roll/proc/roll_dice(dice, sides = 10)
	dice = max(dice, 1)
	var/list/rolled_dice = list()
	for(var/i in 1 to dice)
		rolled_dice += rand(1, sides)
	if(on_crit_extra_die_enabled)
		var/extra_dice = 0
		for(var/roll in rolled_dice)
			if(roll == 10)
				extra_dice++
		for(var/i in 1 to extra_dice)
			rolled_dice += rand(1, sides)
	return rolled_dice

//Count the number of successes.
/datum/controller/subsystem/roll/proc/count_success(list/rolled_dice, difficulty = 6, output_text)
	var/success_count = 0
	for(var/roll in rolled_dice)
		if(roll >= difficulty)
			output_text += span_nicegreen("[get_dice_char(roll)]")
			success_count++
			if(on_crit_extra_success_enabled)
				if(roll == 10)
					success_count++
		else if(roll == 1)
			output_text += span_bold(span_danger("[get_dice_char(roll)]"))
			success_count--
		else
			output_text += span_danger("[get_dice_char(roll)]")
		output_text += " "
	return success_count

//Count the number of successes.
/datum/controller/subsystem/roll/proc/count_success_no_output(list/rolled_dice, difficulty = 6)
	var/success_count = 0
	for(var/roll in rolled_dice)
		if(roll >= difficulty)
			success_count++
			if(on_crit_extra_success_enabled)
				if(roll == 10)
					success_count++
		else if(roll == 1)
			success_count--
	return success_count

/datum/controller/subsystem/roll/proc/roll_answer(success_count, numerical, output_text)
	if(numerical)
		return success_count
	else
		if(success_count < 0)
			output_text += span_bold(span_danger(("\n Botch!")))
			return ROLL_BOTCH
		else if(success_count == 0)
			output_text += span_danger("\n Failure!")
			return ROLL_FAILURE
		else
			output_text += span_nicegreen("\n Success!")
			return ROLL_SUCCESS

/datum/controller/subsystem/roll/proc/get_dice_char(input)
	switch(input)
		if(1)
			return "❶"
		if(2)
			return "❷"
		if(3)
			return "❸"
		if(4)
			return "❹"
		if(5)
			return "❺"
		if(6)
			return "❻"
		if(7)
			return "❼"
		if(8)
			return "❽"
		if(9)
			return "❾"
		if(10)
			return "❿"
		else
			return "⓿"

//Config datums for exploding dice
/datum/config_entry/flag/on_crit_additional_success

/datum/config_entry/flag/on_crit_additional_die
