/datum/quirk/darkpack/conspicuous_consumption
	name = "Conspicuous Consumption"
	desc = "Drinking your victims' blood is not enough. You must also devour their organs."
	value = -4
	icon = FA_ICON_HEART_CRACK
	allowed_splats = list(SPLAT_KINDRED)
	/// Stops the refusal message from being repeated every time feeding is checked
	COOLDOWN_DECLARE(refuse_feeding_message_cooldown)

/datum/quirk/darkpack/conspicuous_consumption/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_LIVING_EAT_FOOD, PROC_REF(on_bite))
	RegisterSignal(quirk_holder, COMSIG_LIVING_FEEDING_ON_BLOOD, PROC_REF(on_feeding))

/datum/quirk/darkpack/conspicuous_consumption/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_LIVING_EAT_FOOD, COMSIG_LIVING_FEEDING_ON_BLOOD))
	quirk_holder.remove_status_effect(/datum/status_effect/ate_organ)

/datum/quirk/darkpack/conspicuous_consumption/proc/on_bite(mob/living/source, atom/food, foodtypes)
	SIGNAL_HANDLER

	if(isorgan(food))
		source.apply_status_effect(/datum/status_effect/ate_organ)

/// Blood gives no blood points unless an organ was devoured recently
/datum/quirk/darkpack/conspicuous_consumption/proc/on_feeding(mob/living/source)
	SIGNAL_HANDLER

	if(source.has_status_effect(/datum/status_effect/ate_organ))
		return NONE
	if(COOLDOWN_FINISHED(src, refuse_feeding_message_cooldown))
		to_chat(source, span_warning("Blood alone won't satisfy you. You need to devour flesh first."))
		COOLDOWN_START(src, refuse_feeding_message_cooldown, 5 SECONDS)
	return BLOCK_BLOOD_FEEDING

///status for a while after taking a bite of an organ
/datum/status_effect/ate_organ
	id = "ate_organ"
	duration = 90 SECONDS
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/ate_organ/on_apply()
	to_chat(owner, span_warning("The bloody flesh sates your craving, for now..."))
	return TRUE

/datum/status_effect/ate_organ/on_remove()
	if(duration <= 0)
		to_chat(owner, span_warning("Your craving for flesh returns."))
