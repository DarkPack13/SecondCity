/datum/storyteller_roll
	var/bumper_text = "roll"

	var/difficulty = 6
	var/successes_needed = 1

	// By default uses the highest attribute and ability // Not acctually true yet, it just used all of them. But it should be that.
	var/list/applicable_stats = list()
	var/numerical = FALSE

	var/roll_output_type = ROLL_PUBLIC
	/// This is a roll that can proc multiple times in rapid sucession and thus has weaker or less notible outputs (forced runechat and quieter dice rolls)
	var/spammy_roll = FALSE

	/// A lazy list of times indexed by a weakref to a mob
	var/list/mobs_last_rolled
	var/reroll_cooldown

	// Mutable vars to store the outputs of any given roll. Expect everything past here to be mutated between each roll.
	var/last_sucess_amount
	var/list/last_output_text = list()


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

 * * roller - the mob who is making the role and owns the dice
 * * target - who this dice is being rolled against, can be the roller, determines if its considered "important" to the mob to display.
 * * dice - bonus dice that are added to the roll.
 *
 * Returns: The sucess of the roll, either a define or the raw amount of sucesses if `numerical = TRUE`
 */
/datum/storyteller_roll/proc/st_roll(mob/living/roller, atom/target, bonus = 0)
	last_sucess_amount = 0
	last_output_text = list()

	if(!can_roll(roller))
		return ROLL_FAILURE

	var/dice_amount = calculate_used_dice(roller, bonus)

	var/list/rolled_dice = roll_dice(dice_amount)

	var/first_line = "[span_tooltip(show_rolling_with(roller, bonus), "[dice_amount] dice")] vs. difficulty [difficulty]."
	if(successes_needed > 1)
		first_line += " [successes_needed] successes needed."
	last_output_text += span_notice(first_line)

	last_sucess_amount = count_success(rolled_dice, difficulty, last_output_text)
	var/output = roll_result(last_sucess_amount)

	var/title
	if(roll_output_type in list(ROLL_PRIVATE_ADMIN, ROLL_ADMIN))
		title = "[ADMIN_LOOKUPFLW(roller)]"
	else
		title = "[roller]"
	title += " - [bumper_text] [span_tinynoticeital(roll_output_type)]"

	var/output_combined = fieldset_block(title, jointext(last_output_text, "<br>"), "boxed_message")
	for(var/mob/player_mob in get_mobs_to_show(roller))
		var/roll_important_to_me = FALSE
		if(!spammy_roll && (player_mob == roller || target))
			roll_important_to_me = TRUE

		var/output_pref = player_mob.client?.prefs.read_preference(/datum/preference/choiced/dice_output)

		SEND_SOUND(player_mob, sound('sound/items/dice_roll.ogg', volume = roll_important_to_me ? 5 : 20))
		if(!spammy_roll && output_pref == DICE_OUTPUT_CHAT)
			to_chat(player_mob, output_combined, MESSAGE_TYPE_INFO, trailing_newline = FALSE)
		else if(spammy_roll || (output_pref == DICE_OUTPUT_BALLOON))
			if(last_sucess_amount > 0)
				roller.balloon_alert(player_mob, "<span style='color: #14a833;'>[last_sucess_amount]</span>", TRUE)
			else
				roller.balloon_alert(player_mob, "<span style='color: #ff0000;'>[last_sucess_amount]</span>", TRUE)

	LAZYADDASSOC(mobs_last_rolled, WEAKREF(roller), list(world.time, output))

	return output


/datum/storyteller_roll/proc/get_mobs_to_show(mob/living/roller)
	switch(roll_output_type)
		if(ROLL_PUBLIC)
			return viewers(DEFAULT_MESSAGE_RANGE, roller)
		if(ROLL_PRIVATE)
			return list(roller)
		if(ROLL_PRIVATE_ADMIN)
			return GLOB.admins + roller
		if(ROLL_ADMIN)
			return GLOB.admins
		if(ROLL_NONE)
			return // Not even important enough to be admin visable.

/datum/storyteller_roll/proc/calculate_used_dice(mob/living/roller, bonus = 0)
	var/dice_amount = 0
	for(var/stat_type in using_stats(roller))
		dice_amount += roller.st_get_stat(stat_type)
	return dice_amount + bonus

// Unused rn but can be used for overides of `using_stats()`
/datum/storyteller_roll/proc/return_higher_stat(mob/living/roller, list/stats)
	var/stat_to_use
	var/highest_stat
	for(var/stat in stats)
		var/stat_dots = roller.st_get_stat(stat)
		if(isnull(highest_stat) || stat_dots > highest_stat)
			stat_to_use = stat
			highest_stat = stat_dots
	return stat_to_use

/datum/storyteller_roll/proc/using_stats(mob/living/roller)
	return applicable_stats

/datum/storyteller_roll/proc/show_rolling_with(mob/living/roller, bonus = 0)
	var/output = ""
	var/stuff = list()
	for(var/datum/st_stat/stat_type as anything in using_stats(roller))
		stuff += "[LOWER_TEXT(stat_type::name)]:[roller.st_get_stat(stat_type)]"
	output += jointext(stuff, "+")
	if(bonus)
		output += "+[bonus]"
	return "Rolling [output]"

/datum/storyteller_roll/proc/roll_dice(dice, sides = 10)
	dice = max(dice, 1)
	var/list/rolled_dice = list()
	for(var/i in 1 to dice)
		rolled_dice += rand(1, sides)
	if(SSroll.on_crit_extra_die_enabled)
		var/extra_dice = 0
		for(var/roll in rolled_dice)
			if(roll == 10)
				extra_dice++
		for(var/i in 1 to extra_dice)
			rolled_dice += rand(1, sides)
	return rolled_dice

//Count the number of successes.
/datum/storyteller_roll/proc/count_success(list/rolled_dice, difficulty = 6, last_output_text)
	var/sucess_amount = 0
	var/dice_text = ""
	for(var/roll in rolled_dice)
		if(roll >= difficulty)
			dice_text += span_nicegreen("[get_dice_char(roll)]")
			sucess_amount++
			if(SSroll.on_crit_extra_success_enabled && roll == 10)
				sucess_amount++
		else if(roll == 1)
			dice_text += span_bold(span_danger("[get_dice_char(roll)]"))
			sucess_amount--
		else
			dice_text += span_danger("[get_dice_char(roll)]")
	last_output_text += "[roll_result_text(roll_result(sucess_amount))] [dice_text]"
	return sucess_amount

/datum/storyteller_roll/proc/roll_result(sucess_amount)
	if(numerical)
		return sucess_amount
	else
		if(sucess_amount < 0)
			return ROLL_BOTCH
		else if(sucess_amount < successes_needed)
			return ROLL_FAILURE
		else
			return ROLL_SUCCESS

/datum/storyteller_roll/proc/roll_result_text(success_result)
	if(numerical)
		return "[success_result] successes -"
	else
		switch(success_result)
			if(ROLL_SUCCESS)
				return span_nicegreen("Success -")
			if(ROLL_FAILURE)
				return span_danger("Failure -")
			if(ROLL_BOTCH)
				return span_bold(span_danger(("Botch -")))

/datum/storyteller_roll/proc/get_dice_char(input)
	var/static/list/dice_output = list("❶", "❷", "❸", "❹", "❺", "❻", "❼", "❽", "❾", "❿")
	return dice_output[input]
	/* // This would require making it an assoc list and we dont every expect outside our given range.
	// So if someone faces a runtime because of this just make it an actual assoc and deal with the micro preformace hit
	var/static/alist/dice_output = alist(1 = "❶", 2 = "❷", 3 = "❸" ,4 = "❹", 5 = "❺", 6 = "❻", 7 = "❼", 8 = "❽", 9 = "❾", 10 = "❿")
	if(!dice_output[input])
		return "⓿"
	else
		return dice_output[input]
	*/

/datum/storyteller_roll/proc/can_roll(mob/living/roller, feedback = TRUE)
	if(reroll_cooldown && mobs_last_rolled)
		for(var/datum/weakref/guy_ref, roll_info in mobs_last_rolled)
			var/mob/living/guy = guy_ref.resolve()
			if(!guy)
				mobs_last_rolled.Remove(guy_ref)
				continue
			if(guy != roller)
				continue
			if(roll_info[1] + reroll_cooldown > world.time)
				if(roll_info[2] > 0)
					return TRUE
					//return roll_info[2] // We really should support directly returning the output..?
				if(feedback)
					to_chat(roller, span_warning("You cannot reroll [bumper_text] yet. [round((roll_info[1] + reroll_cooldown - world.time)/10)]s left."))
				return FALSE

	return TRUE

