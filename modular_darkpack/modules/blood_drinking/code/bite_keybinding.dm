/datum/keybinding/human/bite
	hotkey_keys = list("V")
	name = "bite"
	full_name = "Bite"
	description = "Bite whoever you're aggressively grabbing, and feed on them if possible."
	keybind_signal = COMSIG_KB_HUMAN_BITE_DOWN

/datum/keybinding/human/bite/down(client/user)
	. = ..()
	if(.)
		return

	if(ishuman(user.mob))
		var/mob/living/carbon/human/human_user = user.mob
		if(HAS_TRAIT(human_user, TRAIT_COMBAT_BITE))
			human_user.combat_bite()
		else
			human_user.vamp_bite()

	return TRUE
