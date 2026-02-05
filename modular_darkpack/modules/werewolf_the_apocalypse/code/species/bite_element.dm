/// Forces carbon to default to attack_paw before any other intertaction.
/datum/element/force_paw

/datum/element/force_paw/Attach(datum/target)
	. = ..()
	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(try_bite))

/datum/element/force_paw/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_LIVING_EARLY_UNARMED_ATTACK)

/datum/element/force_paw/proc/try_bite(mob/living/carbon/human/source, atom/target, proximity_flag, modifiers)
	SIGNAL_HANDLER

	if(!proximity_flag)
		return NONE

	// if(target.attack_paw(source, modifiers))
		// return COMPONENT_CANCEL_ATTACK_CHAIN // bite successful!
