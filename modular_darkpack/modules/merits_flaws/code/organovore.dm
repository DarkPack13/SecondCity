/datum/quirk/darkpack/organovore
	name = "Organovore"
	desc = "You can only regain bloodpoints by consuming human flesh. Nagaraja cannot take this trait, as they are already organovores."
	value = -5
	mob_trait = TRAIT_ORGANOVORE
	gain_text = span_notice("You feel an insatiable taste for flesh.")
	lose_text = span_notice("You feel that you can once again feed normally.")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)
	icon = FA_ICON_TEETH
	failure_message = "You feel that you can once again feed normally."

/datum/quirk/darkpack/organovore/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(!.)
		return

	RegisterSignal(new_holder, COMSIG_FOOD_EATEN, PROC_REF(on_gore_eaten))

/datum/quirk/darkpack/organovore/remove_from_current_holder(quirk_transfer)
	UnregisterSignal(quirk_holder, COMSIG_FOOD_EATEN)
	return ..()

/datum/quirk/darkpack/organovore/proc/on_gore_eaten(datum/source, mob/living/eater, mob/living/feeder, bitecount, bite_consumption)
	SIGNAL_HANDLER

	if(!iskindred(eater))
		return

	var/datum/component/edible/edible_comp = source.GetComponent(/datum/component/edible)
	if(!edible_comp)
		return

	if(!(edible_comp.foodtypes & GORE))
		return

	var/mob/living/carbon/human/vampire = eater
	vampire.adjust_blood_pool(1, FALSE)
	to_chat(vampire, span_notice("You feel vitae flowing through the fresh meat."))
