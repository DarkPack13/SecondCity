// VTM Ghouls and Revenants pg. 136
/datum/quirk/darkpack/hemophiliac
	name = "Hemophiliac"
	desc = {"Your character suffers from hemophilia.
If your skin is cut, you will not stop bleeding without medical assistance."}
	icon = FA_ICON_DROPLET
	value = -3
	gain_text = span_notice("You feel like bleeding is a lot more dangerous.")
	lose_text = span_notice("You feel like bleeding's a lot safer now. Whew!")
	failure_message = span_notice("You feel like bleeding's a lot safer now. Whew!")
	mob_trait = TRAIT_BLOOD_FOUNTAIN // Worse bleeding when they do bleed.
	forbidden_splats = list(SPLAT_KINDRED, SPLAT_SHIFTERS) // Kinfolk, humans, and ghouls can take this. Debate adding Garou/Corax to it?

/*Your character suffers from hemophilia. If your ghoul’s
skin is cut, you will not stop bleeding without medical
assistance. The Blood does not have any effect on a ghoul
or revenant Hemophiliac.
If your character suffers lethal or aggravated damage,
he suffers an additional level of bashing damage every
five minutes until his wound has been dressed to stop
the bleeding. Any vampire who bites a Hemophiliac may
“dress” such wounds. By licking the injury after biting the
ghoul, the vampire will put a stop to any future bashing
damage.*/

/datum/quirk/darkpack/hemophiliac/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	ADD_TRAIT(quirk_holder, TRAIT_EASYBLEED , QUIRK_TRAIT) // Easier to make bleed

/datum/quirk/darkpack/hemophiliac/remove()
	. = ..()
	REMOVE_TRAIT(quirk_holder, TRAIT_EASYBLEED , QUIRK_TRAIT)
