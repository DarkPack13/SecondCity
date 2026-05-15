/datum/action/cooldown/power/gift/bane_protector
	name = "Bane Protector"
	desc = "The Black Spiral Dancer binds a Bane in a pact of mutual alliance."
	button_icon_state = "bane_protector"

	click_to_activate = TRUE

	rank = 1
	rage_cost = 1

/datum/action/cooldown/power/gift/bane_protector/Activate(atom/target)
	. = ..()

	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/basic/basic_target = astype(target)

	if(istype(basic_target, /mob/living/basic/bane))
		human_owner?.add_beastmaster_minion(target)
		return

	// Just summon a random shitter.
	human_owner?.add_beastmaster_minion(/mob/living/basic/bane/suffocating)
	return TRUE
