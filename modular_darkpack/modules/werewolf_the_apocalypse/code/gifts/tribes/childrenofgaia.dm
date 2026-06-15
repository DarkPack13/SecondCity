/datum/storyteller_roll/gift/jam_weapon
	bumper_text = "Jam Weapon"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	numerical = TRUE

/datum/action/cooldown/power/gift/jam_weapon
	name = "Jam Weapon"
	desc = "The Child may stop any Weaver-born weapons from working within the range of his voice."
	button_icon_state = "jam_weapon"
	rank = 1
	gnosis_cost = 1
	var/list/datum/weakref/jammed_mobs = list()

/datum/action/cooldown/power/gift/jam_weapon/Activate(atom/target)
	. = ..()
	// could use better flavor/sounds

	// "The player rolls Willpower against a difficulty of highest Willpower of any armed individual within earshot. "
	var/highest_willpower = 0
	for(var/mob/living/carbon/human/guy in orange(DEFAULT_MESSAGE_RANGE, owner))
		var/guy_willpower = guy.st_get_stat(STAT_TEMPORARY_WILLPOWER)
		if(guy_willpower > highest_willpower)
			highest_willpower = guy_willpower

	var/datum/storyteller_roll/gift/jam_weapon/jam_roll = new()
	jam_roll.difficulty = highest_willpower
	var/roll_result = jam_roll.st_roll(owner)
	if(roll_result > 0)
		for(var/mob/living/carbon/human/guy in range(DEFAULT_MESSAGE_RANGE, owner))
			guy.apply_status_effect(/datum/status_effect/jam_weapon, roll_result TURNS)


/datum/status_effect/jam_weapon
	id = "jam_weapon"
	duration = STATUS_EFFECT_PERMANENT

	status_type = STATUS_EFFECT_UNIQUE

	alert_type = /atom/movable/screen/alert/status_effect/gift/jam_weapon

/datum/status_effect/jam_weapon/on_creation(mob/living/owner, duration)
	src.duration = duration
	return ..()

/datum/status_effect/jam_weapon/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_JAMMING_WEAPONS, GIFT_TRAIT)

/datum/status_effect/jam_weapon/on_remove()
	REMOVE_TRAIT(owner, TRAIT_JAMMING_WEAPONS, GIFT_TRAIT)
	return ..()


/atom/movable/screen/alert/status_effect/gift/jam_weapon
	name = /datum/action/cooldown/power/gift/jam_weapon::name
	desc = /datum/action/cooldown/power/gift/jam_weapon::desc
	overlay_state = /datum/action/cooldown/power/gift/jam_weapon::button_icon_state
