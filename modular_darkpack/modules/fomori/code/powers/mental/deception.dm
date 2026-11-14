#define ACTION_TOGGLE_WYRM_TAINT "Alter Wyrm Taint"
#define ACTION_TOGGLE_DIABLERIE "Alter Diablerie"

/datum/storyteller_roll/deception // Freak Legion pg.32
	bumper_text = "deception"
	difficulty = 7
	applicable_stats = list(STAT_WITS, STAT_SUBTERFUGE)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/deception
	name = "Deception"
	desc = "Spend a willpower point to disguise your taint from those capable of percieving it."
	button_icon_state = "deception"
	rank = 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/deception/Activate(atom/target)
	if(!isliving(target))
		return FALSE
	if(!(target in range(1, owner)))
		return FALSE

	var/mob/living/victim = target

	open_prompt(target)
	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/deception
	var/roll_result = roll_datum.st_roll(owner)
	if(roll_result > ROLL_FAILURE)

	StartCooldown()
	return TRUE
#warn DECEPTION UNFINISHED

// foil sense worm
// hide diablerie
// force wyrm taint
/datum/action/cooldown/power/fomori_power/deception/proc/open_prompt(atom/target)
	var/actions_list = list(ACTION_TOGGLE_WYRM_TAINT, ACTION_TOGGLE_DIABLERIE)

	var/selection = tgui_input_list(owner, "Select a Deception", title = "Deception", actions_list, timeout = 10 SECONDS)

	if(!selection)
		return FALSE

	if(selection == ACTION_TOGGLE_WYRM_TAINT)
		toggle_wyrmtaint(target)
		return TRUE

	if(selection == ACTION_TOGGLE_DIABLERIE)
		toggle_diablerie(target)
		return TRUE


/datum/action/cooldown/power/fomori_power/deception/proc/toggle_wyrmtaint(atom/target)
	if(HAS_TRAIT(target, TRAIT_WYRMTAINTED) || HAS_TRAIT(target, TRAIT_WYRMTAINTED_SPRITE))
