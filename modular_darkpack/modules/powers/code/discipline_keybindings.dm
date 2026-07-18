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
	name = "select Discipline [slot - 1]"
	full_name = "Select Discipline [slot - 1]"

/datum/keybinding/discipline_select/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if (.)
		return

	var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(user.mob)
	if (!vampirism)
		return

	if (slot > length(vampirism.powers))
		return
	vampirism.selected_power = vampirism.powers[slot]

	return TRUE

// Bloodheal will always be the first Discipline, so this is a special case of Discipline selection
/datum/keybinding/discipline_select/bloodheal
	hotkey_keys = list()
	classic_keys = list()
	slot = 1
	name = "select Bloodheal"
	full_name = "Select Bloodheal"

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

	var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(user.mob)
	if (!vampirism?.selected_power)
		return

	var/datum/action/discipline/activating_power = vampirism.selected_power
	if (activating_power.discipline.level < level)
		return

	activating_power.switch_level(level - activating_power.discipline.level_casting, TRUE)
	return activating_power.Trigger(user.mob)

/proc/init_discipline_keybinds()
	// Bloodheal is an extra first Discipline in code
	for (var/slot in 2 to MAXIMUM_DISCIPLINES + 1)
		var/datum/keybinding/discipline_select/selection_kb = new
		selection_kb.assign_slot(slot)
		add_keybinding(selection_kb)

	for (var/level in 1 to MAXIMUM_DISCIPLINE_LEVEL)
		var/datum/keybinding/discipline_activate/activation_kb = new
		activation_kb.assign_level(level)
		add_keybinding(activation_kb)
