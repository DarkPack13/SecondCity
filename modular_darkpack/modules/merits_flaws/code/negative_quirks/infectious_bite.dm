// V20 pg. 481
/datum/quirk/darkpack/infectious_bite
	name = "Infectious Bite"
	desc = {"Your bites have a one in five chance of leaving a mortal seriously ill.
	You can't automatically lick wounds of your victim closed."}
	value = -2
	mob_trait = TRAIT_INFECTIOUS_BITE
	gain_text = span_notice("Your mouth doesn't feel very sanitary.")
	lose_text = span_notice("You don't feel worried about feeding anymore.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_VIRUS
	failure_message = "You don't feel worried about feeding anymore."

/*You may not automatically lick the wounds of your
feeding closed. In fact, your bites have a one in five
chance of becoming infected and causing mortal vic
tims to become seriously ill. The precise nature of the
infection is determined by the Storyteller.*/
