ADMIN_VERB(roll_storyteller_dice, R_NONE, "Roll storyteller dice", "Roll storyteller dice at yourself.", ADMIN_CATEGORY_FUN)
	var/dice_count = tgui_input_number(usr, "Input amount of dice to roll:", "Dice", 5, 100, 1)
	var/difficulty = tgui_input_number(usr, "Input roll difficulty:", "Difficulty", 6, 10, 1)

	SSroll.storyteller_roll(dice_count, difficulty, usr, usr)
	BLACKBOX_LOG_ADMIN_VERB("Storyteller dice")

/mob/verb/roll_dice_custom()
	set name = "Roll custom dice"
	set category = "IC"
	set desc = "Roll dice!"

	var/dice_count = tgui_input_number(usr, "Input amount of dice to roll:", "Dice", 5, 100, 1)
	var/difficulty = tgui_input_number(usr, "Input roll difficulty:", "Difficulty", 6, 10, 1)

	SSroll.storyteller_roll(dice_count, difficulty, mob_only_listeners(get_hearers_in_view(DEFAULT_MESSAGE_RANGE, usr)), usr)
