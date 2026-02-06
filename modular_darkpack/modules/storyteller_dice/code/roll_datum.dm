// Output is shown to everyone near you
#define ROLL_PUBLIC "public"
// Output is only shown to the roller
#define ROLL_PRIVATE "private"
// Output of the roll to admins only
#define ROLL_GM "gm"
// Output is show to no one and is not logged
#define ROLL_NONE "none"

/datum/storyteller_roll
	var/bumper_text = "Roll"

	var/difficulty = 6
	// By default uses the highest attribute and ability
	var/list/applicable_stats = list()
	var/numerical = FALSE

	var/roll_output_type = ROLL_PUBLIC
	/// This is a roll that can proc multiple times in rapid sucession and thus should be always shown via runechat
	var/spammy_roll = FALSE


	// Mutable vars to store the outputs of any given roll. Expect everything past here to be mutated between each roll.
	var/last_sucess_amount
	var/list/last_output_text = list()


/**
 * Arguments:
 *
 * Returns: The sucess of the roll, if you need the amount, fetch it from the datum itself
 */
/datum/storyteller_roll/proc/st_roll(mob/living/roller, atom/target, bonus = 0)
	last_sucess_amount = 0
	last_output_text = list()

	var/dice_amount = calculate_used_dice(roller, bonus)

	var/list/rolled_dice = roll_dice(dice_amount)

	last_output_text += span_notice("[span_tooltip(show_rolling_with(roller, bonus), "[dice_amount] dice")] vs. difficulty [difficulty].")
	last_sucess_amount = count_success(rolled_dice, difficulty, last_output_text)
	var/output = roll_result(last_sucess_amount)

	var/output_combined = fieldset_block("[roller] - [bumper_text]", jointext(last_output_text, "<br>"), "boxed_message")
	//var/output_combined = boxed_message(jointext(last_output_text, "<br>"))
	for(var/mob/player_mob in get_mobs_to_show(roller))
		var/output_pref = player_mob.client?.prefs.read_preference(/datum/preference/choiced/dice_output)

		SEND_SOUND(player_mob, sound('sound/items/dice_roll.ogg', volume = 10))
		if(!spammy_roll && output_pref == DICE_OUTPUT_CHAT)
			to_chat(player_mob, output_combined, MESSAGE_TYPE_INFO, trailing_newline = FALSE)
		else if(spammy_roll || (output_pref == DICE_OUTPUT_BALLOON))
			if(last_sucess_amount > 0)
				roller.balloon_alert(player_mob, "<span style='color: #14a833;'>[last_sucess_amount]</span>", TRUE)
			else
				roller.balloon_alert(player_mob, "<span style='color: #ff0000;'>[last_sucess_amount]</span>", TRUE)

	return output


/datum/storyteller_roll/proc/get_mobs_to_show(mob/living/roller)
	switch(roll_output_type)
		if(ROLL_PUBLIC)
			return viewers(DEFAULT_MESSAGE_RANGE, roller)
		if(ROLL_PRIVATE)
			return roller
		if(ROLL_GM)
			EMPTY_BLOCK_GUARD // Should eventually log to a admin viewable place..?
		if(ROLL_NONE)
			EMPTY_BLOCK_GUARD // Not even important enough to be admin visable.

/datum/storyteller_roll/proc/calculate_used_dice(mob/living/roller, bonus = 0)
	var/dice_amount = 0
	for(var/stat_type in applicable_stats)
		dice_amount += roller.st_get_stat(stat_type)
	return dice_amount + bonus

/datum/storyteller_roll/proc/show_rolling_with(mob/living/roller, bonus = 0)
	var/output = ""
	var/stuff = list()
	for(var/datum/st_stat/stat_type as anything in applicable_stats)
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
	return rolled_dice

//Count the number of successes.
/datum/storyteller_roll/proc/count_success(list/rolled_dice, difficulty = 6, last_output_text)
	var/sucess_amount = 0
	var/dice_text = ""
	for(var/roll in rolled_dice)
		if(roll >= difficulty)
			dice_text += span_nicegreen("[get_dice_char(roll)]")
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
		else if(sucess_amount == 0)
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


/datum/storyteller_roll/lockpick
	bumper_text = "Lockpicking"
	applicable_stats = list(STAT_DEXTERITY, STAT_LARCENY)

/datum/storyteller_roll/grappling
	bumper_text = "Grappling"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE

/datum/storyteller_roll/grappled
	bumper_text = "Resisting"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE
