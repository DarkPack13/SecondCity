// VTM pg. 480
/datum/quirk/darkpack/huge_size
	name = "Huge Size"
	desc = {"You are abnormally large in size.
Aside from making you extremely noticeable in public,
you have a small amount of extra health,
and you may have an easier time breaking down doors or other physical feats."}
	icon = FA_ICON_ARROW_UP
	value = 4 // Debate on this, because it's likely not as useful as on tabletop rn
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("People look up to you.")
	lose_text = span_notice("You feel shorter.")
	failure_message = span_notice("You feel shorter.")
	mob_trait = TRAIT_HUGE_SIZE

/datum/quirk/darkpack/huge_size/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/mob/living/carbon/human/human_holder = quirk_holder // TODO ADD HEALTH
	human_holder.maxHealth += 30
	human_holder.health += 30
	ADD_TRAIT(human_holder, TRAIT_TOO_TALL, QUIRK_TRAIT)

/datum/quirk/darkpack/huge_size/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.maxHealth -= 30
	human_holder.health = max(human_holder.health - 30, human_holder.maxHealth)
	REMOVE_TRAIT(human_holder, TRAIT_TOO_TALL, QUIRK_TRAIT)

/*You are abnormally large in size, at least 6’10” and
300 pounds in weight (well over two meters tall and
over 130 kgs). Aside from making you extremely no
ticeable in public, this extra mass bestows an addition
al Bruised health level. Characters with this Merit may
also gain bonuses to push objects, open barred doors,
avoid being knocked down, etc.*/
