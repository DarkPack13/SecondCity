/datum/quirk/darkpack/permafangs
	name = "Permanent Fangs"
	desc = "Your fangs do not retract, making it impossible for you to hide your true nature. While some mortals may think you've had your teeth filed or are wearing prosthetics, sooner or later you're going to run into someone who knows what you truly are."
	value = -1
	mob_trait = TRAIT_PERMAFANGS
	gain_text = "<span class='notice'>Your fangs become stuck.</span>"
	lose_text = "<span class='notice'>You feel your fangs retract again.</span>"
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_TEETH
	failure_message = "You feel your fangs retract."
