/datum/action/cooldown/power/gift/apecrafts_blessings
	name = "Apecraft's Blessings"
	desc = "Grants a bonus to the next roll made to employ any tool."
	rank = 1

/datum/action/cooldown/power/gift/apecrafts_blessings/IsAvailable(feedback)
	. = ..()
	var/mob/living/living_owner = astype(owner)
	if(!living_owner)
		return FALSE

	if(living_owner.has_status_effect(/datum/storyteller_roll/gift/apecrafts_blessings))
		return FALSE

/datum/action/cooldown/power/gift/apecrafts_blessings/Activate(atom/target)
	var/mob/living/living_owner = astype(owner)
	if(!living_owner)
		return FALSE

	. = ..()
	if(!do_after(owner, 1 TURNS))
		return

	var/datum/storyteller_roll/gift/apecrafts_blessings/roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)
	if(roll_result >= 1)
		living_owner.apply_status_effect(/datum/status_effect/apecrafts_blessings, roll_result)


/datum/storyteller_roll/gift/apecrafts_blessings
	bumper_text = /datum/action/cooldown/power/gift/apecrafts_blessings::name
	applicable_stats = list(STAT_WITS, STAT_CRAFTS)
	numerical = TRUE


/datum/status_effect/apecrafts_blessings
	id = "apecrafts_blessings"
	duration = STATUS_EFFECT_PERMANENT

	status_type = STATUS_EFFECT_UNIQUE

	alert_type = /atom/movable/screen/alert/status_effect/apecrafts_blessings
	/// Passed in by the gift's activate
	var/value

/datum/status_effect/apecrafts_blessings/on_creation(mob/living/owner, value)
	src.value = value
	return ..()

/datum/status_effect/apecrafts_blessings/on_apply()
	to_chat(owner, span_notice("Your hands glow with power."))
	RegisterSignal(owner, COMSIG_LIVING_PRE_DICE_ROLLED, PROC_REF(on_dice_rolled))
	return TRUE

/datum/status_effect/apecrafts_blessings/proc/on_dice_rolled(mob/living/roller, datum/storyteller_roll/roll_datum, atom/target, atom/using_item, bonus, difficulty)
	SIGNAL_HANDLER

	if(using_item && !HAS_TRAIT(using_item, TRAIT_NATURAL))
		*difficulty -= value
		qdel(src)

/datum/status_effect/apecrafts_blessings/on_remove()
	to_chat(owner, span_warning("Your strength subsides, the pain of your wounds creeping back in..."))
	UnregisterSignal(owner, COMSIG_LIVING_PRE_DICE_ROLLED)

/atom/movable/screen/alert/status_effect/apecrafts_blessings
	name = "Desperate Strength"
	desc = "Your next roll will be made with bonus strength, at the penalty of bashing damage!"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "riddle" // TODO: get an icon for this
