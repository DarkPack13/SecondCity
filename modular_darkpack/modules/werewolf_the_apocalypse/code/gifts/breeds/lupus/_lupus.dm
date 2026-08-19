/datum/action/cooldown/power/gift/hares_leap
	name = "Hares Leap"
	desc = {"The player makes a reflexive Strength + Athletics roll (difficulty 7) to activate this Gift.
	If successful, the character's leaping distances are doubled for a scene — or tripled for a single turn with the expenditure of a Willpower point"}
	#warn icon
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



/datum/action/cooldown/power/gift/heightened_senses
	name = "Heightened Senses"
	desc = "The player gains an uncanncy sense of perception and tracking ability"
	#warn icon
	rank = 1
	gnosis_cost = 1

/datum/action/cooldown/power/gift/heightened_senses/Activate(atom/target)
	var/mob/living/living_owner = astype(target)
	if(!living_owner)
		return

	. = ..()

	living_owner.apply_status_effect(/datum/status_effect/heightened_senses)


/datum/status_effect/heightened_senses
	id = "heightened_senses"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/gift/heightened_senses
	var/datum/action/uncanny_tracking/tracking_action

/datum/status_effect/heightened_senses/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_PRE_DICE_ROLLED, PROC_REF(on_dice_rolled))

	tracking_action = new(owner)
	tracking_action.Grant(owner)

	return TRUE

/datum/status_effect/heightened_senses/on_remove()
	UnregisterSignal(owner, COMSIG_LIVING_PRE_DICE_ROLLED)

	if(owner)
		tracking_action.Remove(owner)
	QDEL_NULL(tracking_action)

/datum/status_effect/heightened_senses/proc/on_dice_rolled(mob/living/roller, datum/storyteller_roll/roll_datum, atom/target, atom/using_item, bonus, difficulty)
	SIGNAL_HANDLER

	if(STAT_PERCEPTION in roll_datum.applicable_stats)
		*difficulty -= 2


/atom/movable/screen/alert/status_effect/gift/heightened_senses
	name = /datum/action/cooldown/power/gift/heightened_senses::name
	desc = /datum/action/cooldown/power/gift/heightened_senses::desc
	overlay_state = /datum/action/cooldown/power/gift/heightened_senses::button_icon_state


/datum/action/uncanny_tracking
	name = "Uncanny Tracking"
	desc = "Sense the location."
	button_icon = /datum/action/cooldown/power/gift/heightened_senses::button_icon
	button_icon_state = /datum/action/cooldown/power/gift/heightened_senses::button_icon_state
	check_flags = AB_CHECK_CONSCIOUS
	var/datum/storyteller_roll/gift/uncanny_tracking/roll_datum

/datum/action/uncanny_tracking/Trigger(mob/clicker, trigger_flags)
	var/mob/living/living_owner = astype(owner)
	if(!living_owner)
		return

	. = ..()
	if(!.)
		return


	var/mob/living/target = owner?.mind?.guestbook.pick_known_guy(owner)
	if(!istype(target))
		return

	if(!roll_datum)
		roll_datum = new()
	var/roll_result = roll_datum.st_roll(living_owner, bonus_added = PRIMAL_URGE_PLACEHOLDER)

	if(roll_result != ROLL_SUCCESS)
		return

	to_chat(owner, span_warning("[get_area_name(target)]"))

/datum/storyteller_roll/gift/uncanny_tracking
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 7



#warn do
/datum/action/cooldown/power/gift/predators_arsenal
