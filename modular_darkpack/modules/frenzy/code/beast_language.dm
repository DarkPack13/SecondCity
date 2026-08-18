/datum/language/frenzy
	name = "Frenzy"
	desc = "The language of the Beast."
	key = "q"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 100
	sentence_chance = 0
	between_word_sentence_chance = 0
	between_word_space_chance = 100
	additional_syllable_low = 0
	additional_syllable_high = 0
	syllables = list("raaagh", "hiss") //What are hungry noises?
	default_priority = 100
	always_use_default_namelist = TRUE // Shouldn't generate names for this anyways

	icon_state = "animal"
