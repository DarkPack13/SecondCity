/*
ADMIN_VERB(roll_storyteller_dice, R_NONE, "Roll storyteller dice", "Roll storyteller dice at yourself.", ADMIN_CATEGORY_FUN)
	var/dice_count = tgui_input_number(usr, "Input amount of dice to roll:", "Dice", 5, 100, 1)
	var/difficulty = tgui_input_number(usr, "Input roll difficulty:", "Difficulty", 6, 10, 1)

	SSroll.storyteller_roll(dice_count, difficulty, usr, usr)
	BLACKBOX_LOG_ADMIN_VERB("Storyteller dice")
*/

/mob/living/verb/roll_dice_custom()
	set name = "Roll custom dice (basic)"
	set category = "IC"
	set desc = "Roll dice!"

	var/dice_count = tgui_input_number(usr, "Input amount of dice to roll:", "Dice", 5, 100, 1)
	var/difficulty = tgui_input_number(usr, "Input roll difficulty:", "Difficulty", 6, 10, 1)

	var/datum/storyteller_roll/custom_roll/custom_roll = new()
	custom_roll.difficulty = difficulty
	return custom_roll.st_roll(src, src, dice_count)

/mob/living/verb/roll_dice_custom_advanced()
	set name = "Roll custom dice"
	set category = "IC"
	set desc = "Roll dice! This one lets you pass in your stats."

	var/list/allowed_stats = list()
	// Blame Xeon im pretty sure for the mobs storing this as a string.
	for(var/stat_path_as_a_fucked_up_evil_string, dots_in in storyteller_stats)
		var/datum/st_stat/stat = text2path(stat_path_as_a_fucked_up_evil_string)
		if(!ispath(stat))
			continue
		if(stat == stat::abstract_type)
			continue
		allowed_stats += stat
		//allowed_stats[stat] = "[stat::name]: [dots_in]"
	var/list/stats_to_use = tgui_input_checkboxes(usr, "Select stats to use for the roll.", "Choose Stats", allowed_stats, max_checked = 5)
	if(!length(stats_to_use))
		return
	var/list/output_stats = list()
	for(var/list/stat as anything in stats_to_use)
		output_stats += text2path(stat[1])

	var/bonus_dice = tgui_input_number(usr, "Input amount of bonus dice to roll.", "Dice", 0, 100, -100)
	if(isnull(bonus_dice))
		return

	var/difficulty = tgui_input_number(usr, "Input roll difficulty.", "Difficulty", 6, 10, 1)
	if(isnull(difficulty))
		return

	var/successes_needed = tgui_input_number(usr, "Input successes required to pass.", "Successes Needed", 1, 100, 1)
	if(isnull(successes_needed))
		return

	var/roll_type = tgui_input_list(usr, "Who do you want to roll to.", "Roll Type", list(ROLL_PUBLIC, ROLL_PRIVATE, ROLL_GM), ROLL_PUBLIC)
	if(isnull(roll_type))
		return

	var/datum/storyteller_roll/custom_roll/custom_roll = new()
	custom_roll.applicable_stats = output_stats
	custom_roll.difficulty = difficulty
	custom_roll.successes_needed = successes_needed
	custom_roll.roll_output_type = roll_type
	return custom_roll.st_roll(src, src, bonus_dice)

/datum/storyteller_roll/custom_roll
	bumper_text = "custom roll"
