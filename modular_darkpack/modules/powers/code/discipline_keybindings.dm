/datum/keybinding/discipline_select
	category = CATEGORY_DISCIPLINES
	keybind_signal = COMSIG_KB_DISCIPLINE_SELECT
	/// Number (from left to right on the UI) of the Discipline to select
	var/slot

/datum/keybinding/discipline_select/proc/assign_slot(slot)
	hotkey_keys = list()
	classic_keys = list()
	src.slot = slot
	// Bloodheal is technically counted as a Discipline and it always takes slot 1, so slot 2 will be displayed as Discipline 1 and so on
	if (slot == 1)
		name = "select Bloodheal"
		full_name = "Select Bloodheal"
	else
		name = "select Discipline [slot - 1]"
		full_name = "Select Discipline [slot - 1]"

/datum/keybinding/discipline_select/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if (.)
		return

	var/datum/splat/vampire/vampirism = get_splat_with_discipline(user.mob)
	if (!vampirism)
		return

	if (slot > length(vampirism.powers))
		return
	vampirism.selected_power = vampirism.powers[slot]

	return TRUE

/datum/keybinding/discipline_activate
	category = CATEGORY_DISCIPLINES
	keybind_signal = COMSIG_KB_DISCIPLINE_ACTIVATE
	/// Which level of the selected Discipline to activate
	var/level

/datum/keybinding/discipline_activate/proc/assign_level(level)
	hotkey_keys = list()
	classic_keys = list()
	src.level = level
	name = "activate Discipline level [level]"
	full_name = "Activate Discipline level [level]"

/datum/keybinding/discipline_activate/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if (.)
		return

	var/datum/splat/vampire/vampirism = get_splat_with_discipline(user.mob)
	if (!vampirism?.selected_power)
		return

	var/datum/action/discipline/activating_power = vampirism.selected_power
	if (activating_power.discipline.level < level)
		return

	activating_power.switch_level(level - activating_power.discipline.level_casting, TRUE)
	return activating_power.Trigger(user.mob)

/datum/keybinding/discipline_power
	category = CATEGORY_DISCIPLINE_POWERS
	keybind_signal = COMSIG_KB_DISCIPLINE_POWER_ACTIVATE
	/// Which Discipline the power falls under
	var/datum/discipline/discipline_type
	/// Which level of the Discipline the power is
	var/level

/datum/keybinding/discipline_power/proc/assign_power(datum/discipline/discipline_type, level)
	hotkey_keys = list()
	classic_keys = list()
	src.discipline_type = discipline_type
	src.level = level
	name = "activate [discipline_type::name] [level]"
	full_name = "Activate [discipline_type::name] [level]"

/datum/keybinding/discipline_power/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if (.)
		return

	var/datum/splat/vampire/vampirism = get_splat_with_discipline(user.mob)
	if (!vampirism)
		return

	var/datum/action/discipline/discipline_action = vampirism.get_power(discipline_type)
	if (!discipline_action)
		return

	if (discipline_action.discipline.level < level)
		return

	discipline_action.switch_level(level - discipline_action.discipline.level_casting, TRUE)
	return discipline_action.Trigger(user.mob)

// These are called when the configs for them are set rather than on keybind init because keybind init happens before configs are loaded
/proc/init_normal_discipline_keybinds()
	if (!CONFIG_GET(flag/discipline_keybinds))
		return

	// Bloodheal counts as an extra Discipline
	for (var/slot in 1 to MAXIMUM_DISCIPLINES + 1)
		var/datum/keybinding/discipline_select/selection_kb = new
		selection_kb.assign_slot(slot)
		add_keybinding(selection_kb)

	for (var/level in 1 to MAXIMUM_DISCIPLINE_LEVEL)
		var/datum/keybinding/discipline_activate/activation_kb = new
		activation_kb.assign_level(level)
		add_keybinding(activation_kb)

/proc/init_individual_power_keybinds()
	if (!CONFIG_GET(flag/individual_power_keybinds))
		return

	for (var/discipline_type in (valid_subtypesof(/datum/discipline) - /datum/discipline/torpor))
		for (var/level in 1 to MAXIMUM_DISCIPLINE_LEVEL)
			var/datum/keybinding/discipline_power/power_kb = new
			power_kb.assign_power(discipline_type, level)
			add_keybinding(power_kb)
