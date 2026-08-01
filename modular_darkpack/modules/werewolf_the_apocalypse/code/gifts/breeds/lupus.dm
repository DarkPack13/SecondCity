/datum/action/cooldown/power/gift/hares_leap
	name = "Hares Leap"
	desc = {"The player makes a reflexive Strength + Athletics roll (difficulty 7) to activate this Gift.
	If successful, the character's leaping distances are doubled for a scene — or tripled for a single turn with the expenditure of a Willpower point"}
	rank = 1

/datum/action/cooldown/power/gift/hares_leap/Activate(atom/target)
	var/mob/living/living_owner = astype(owner)
	if(!living_owner)
		return FALSE

	. = ..()
	var/datum/storyteller_roll/gift/hares_leap/roll_datum = new()
	if(roll_datum.st_roll(living_owner) != ROLL_SUCCESS)
		return TRUE

	var/jump_mod = 2
	if(living_owner.prompt_burn_willpower())
		jump_mod = 3

	living_owner.apply_status_effect(/datum/status_effect/hares_leap, jump_mod)


/datum/storyteller_roll/gift/hares_leap
	bumper_text = /datum/action/cooldown/power/gift/hares_leap::name
	applicable_stats = list(STAT_STRENGTH, STAT_ATHLETICS)
	difficulty = 7
	roll_output_type = ROLL_PRIVATE


/datum/status_effect/hares_leap
	id = "hares_leap"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/hares_leap
	var/jump_modifier = 2

/datum/status_effect/hares_leap/on_creation(mob/living/new_owner, jump_modifier = 2)
	. = ..()
	src.jump_modifier = jump_modifier

/atom/movable/screen/alert/status_effect/gift/hares_leap
	name = /datum/action/cooldown/power/gift/hares_leap::name
	desc = /datum/action/cooldown/power/gift/hares_leap::desc
	overlay_state = /datum/action/cooldown/power/gift/hares_leap::button_icon_state


#warn do
// /datum/action/cooldown/power/gift/heightened_senses


#warn do
// /datum/action/cooldown/power/gift/predators_arsenal
