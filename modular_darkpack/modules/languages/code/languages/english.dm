// 'basic' language; spoken by default.
// Modular override to make it easier to treat as the default.
/datum/language/common
	name = "English"
	desc = "Lingua franca of the world."

	icon_state = "english"

	// Removes the mandarin that common had because this is english lol
	syllables = list(
		"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
		"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
		"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
		"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
	)

	mutual_understanding = list(
		/datum/language/beachbum = 33, // Lol I guess I can leave this
		/datum/language/spanish = 25,
		/datum/language/french = 10,
		/datum/language/german = 10,
		/datum/language/latin = 10,
		/datum/language/greek = 10,
	)

	restricted = FALSE
