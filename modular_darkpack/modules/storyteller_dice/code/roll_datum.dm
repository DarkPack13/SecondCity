// Output is shown to everyone near you
#define ROLL_PUBLIC "public"
// Output is only shown to the roller
#define ROLL_PRIVATE "private"
// Output of the roll to admins only
#define ROLL_GM "gm"
// Output is show to no one and is not logged
#define ROLL_NONE "none"

/datum/storyteller_roll
	var/difficulty = 6
	// By default uses the highest attribute and ability
	var/list/applicable_stats

	var/roll_output_type = ROLL_PUBLIC

	// Mutable vars to store the outputs of any given roll. Expect everything past here to be mutated between each roll.
	var/last_sucess_amount
	var/list/last_output_text = list()

/**
 * Arguments:
 *
 * Returns: The sucess of the roll, if you need the amount, fetch it from the datum itself
 */
/datum/storyteller_roll/proc/roll(mob/living/roller, bonus = 0)
	last_sucess_amount = 0
	last_output_text = list()

	var/dice_amount = 0
	for(var/stat_type in applicable_stats)
		dice_amount += roller.st_get_stat(stat_type)
	var/list/rolled_dice = roll_dice(dice_amount)

	last_output_text += span_notice("Rolling [dice] dice against difficulty [difficulty].")
	last_sucess_amount = count_success(rolled_dice, difficulty, last_output_text)
	var/output = roll_answer(last_sucess_amount, numerical, last_output_text)

	var/output_combined = fieldset_block("[alert_atom.name]", jointext(last_output_text, "<br>"), "boxed_message")
	for(var/mob/player_mob as anything in mobs_to_show_output)
		var/output_pref = player_mob.client?.prefs.read_preference(/datum/preference/choiced/dice_output)

		if(output_pref == DICE_OUTPUT_CHAT)
			to_chat(player_mob, output_combined, trailing_newline = FALSE)
		else if((output_pref == DICE_OUTPUT_BALLOON) && alert_atom)
			if(last_sucess_amount > 0)
				alert_atom.balloon_alert(player_mob, "<span style='color: #14a833;'>[last_sucess_amount]</span>", TRUE)
			else
				alert_atom.balloon_alert(player_mob, "<span style='color: #ff0000;'>[last_sucess_amount]</span>", TRUE)

	return output


/datum/storyteller_roll/lockpick
	applicable_stats = list(STAT_DEXTERITY, STAT_LARCENY)


/datum/storyteller_roll/proc/storyteller_roll(dice = 1, difficulty = 6, list/mobs_to_show_output = list(), atom/alert_atom = null, numerical = FALSE)
	var/list/rolled_dice = roll_dice(dice)
	if(!islist(mobs_to_show_output))
		mobs_to_show_output = list(mobs_to_show_output)
	var/list/last_output_text = list()
	last_output_text += span_notice("Rolling [dice] dice against difficulty [difficulty].")
	var/last_sucess_amount = count_success(rolled_dice, difficulty, last_output_text)
	var/output = roll_answer(last_sucess_amount, numerical, last_output_text)

	var/output_combined = fieldset_block("[alert_atom.name]", jointext(last_output_text, "<br>"), "boxed_message")
	for(var/mob/player_mob as anything in mobs_to_show_output)
		var/output_pref = player_mob.client?.prefs.read_preference(/datum/preference/choiced/dice_output)

		if(output_pref == DICE_OUTPUT_CHAT)
			to_chat(player_mob, output_combined, trailing_newline = FALSE)
		else if((output_pref == DICE_OUTPUT_BALLOON) && alert_atom)
			if(last_sucess_amount > 0)
				alert_atom.balloon_alert(player_mob, "<span style='color: #14a833;'>[last_sucess_amount]</span>", TRUE)
			else
				alert_atom.balloon_alert(player_mob, "<span style='color: #ff0000;'>[last_sucess_amount]</span>", TRUE)

	if(numerical)
		return last_sucess_amount

	return output

/datum/storyteller_roll/proc/roll_dice(dice, sides = 10)
	dice = max(dice, 1)
	var/list/rolled_dice = list()
	for(var/i in 1 to dice)
		rolled_dice += rand(1, sides)
	return rolled_dice

//Count the number of successes.
/datum/storyteller_roll/proc/count_success(list/rolled_dice, difficulty = 6, last_output_text)
	var/last_sucess_amount = 0
	var/dice_text = ""
	for(var/roll in rolled_dice)
		if(roll >= difficulty)
			dice_text += span_nicegreen("[get_dice_char(roll)]")
			last_sucess_amount++
		else if(roll == 1)
			dice_text += span_bold(span_danger("[get_dice_char(roll)]"))
			last_sucess_amount--
		else
			dice_text += span_danger("[get_dice_char(roll)]")
	last_output_text += dice_text
	return last_sucess_amount

/datum/storyteller_roll/proc/roll_answer(last_sucess_amount, numerical, last_output_text)
	if(numerical)
		return last_sucess_amount
	else
		if(last_sucess_amount < 0)
			last_output_text += span_bold(span_danger(("Botch!")))
			return ROLL_BOTCH
		else if(last_sucess_amount == 0)
			last_output_text += span_danger("Failure!")
			return ROLL_FAILURE
		else
			last_output_text += span_nicegreen("Success!")
			return ROLL_SUCCESS

/datum/storyteller_roll/proc/get_dice_char(input)
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
