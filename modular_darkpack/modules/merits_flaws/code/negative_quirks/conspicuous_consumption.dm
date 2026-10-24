/datum/quirk/darkpack/conspicuous_consumption
	name = "Conspicuous Consumption"
	desc = "Drinking your victims' blood is not enough. You must also devour their hearts, livers and other blood-rich organs."
	value = -4
	mob_trait = TRAIT_CONSPICUOUS_CONSUMPTION
	icon = FA_ICON_HEART_CRACK
	allowed_splats = list(SPLAT_KINDRED)

/datum/quirk/darkpack/conspicuous_consumption/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_LIVING_EAT_FOOD, PROC_REF(on_bite))

/datum/quirk/darkpack/conspicuous_consumption/remove()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_EAT_FOOD)
	quirk_holder.remove_status_effect(/datum/status_effect/ate_organ)

/datum/quirk/darkpack/conspicuous_consumption/proc/on_bite(mob/living/source, atom/food, foodtypes)
	SIGNAL_HANDLER

	if(isorgan(food))
		source.apply_status_effect(/datum/status_effect/ate_organ)

///status for a while after taking a bite of an organ
/datum/status_effect/ate_organ
	id = "ate_organ"
	duration = 90 SECONDS
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/ate_organ/on_apply()
	to_chat(owner, span_warning("The rich, bloody flesh sates your craving, for now."))
	return TRUE

/datum/status_effect/ate_organ/on_remove()
	if(duration <= 0)
		to_chat(owner, span_warning("Your craving for warm, blood-rich flesh returns."))
