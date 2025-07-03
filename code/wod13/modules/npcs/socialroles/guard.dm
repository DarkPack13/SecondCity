/datum/socialrole/guard
	s_tones = list(
		"albino",
		"caucasian1",
		"caucasian2",
		"caucasian3"
	)

	min_age = 18
	max_age = 85
	preferred_gender = MALE
	male_names = null
	surnames = null

	hair_colors = list(
		"040404",	//Black
		"120b05",	//Dark Brown
		"342414",	//Brown
		"554433",	//Light Brown
		"695c3b",	//Dark Blond
		"ad924e",	//Blond
		"dac07f",	//Light Blond
		"802400",	//Ginger
		"a5380e",	//Ginger alt
		"ffeace",	//Albino
		"650b0b",	//Punk Red
		"14350e",	//Punk Green
		"080918"	//Punk Blue
	)
	male_hair = list(
		"Balding Hair",
		"Bedhead",
		"Bedhead 2",
		"Bedhead 3",
		"Boddicker",
		"Business Hair",
		"Business Hair 2",
		"Business Hair 3",
		"Business Hair 4",
		"Coffee House",
		"Combover",
		"Crewcut",
		"Father",
		"Flat Top",
		"Gelled Back",
		"Joestar",
		"Keanu Hair",
		"Oxton",
		"Volaju"
	)
	male_facial = list(
		"Beard (Abraham Lincoln)",
		"Beard (Chinstrap)",
		"Beard (Full)",
		"Beard (Cropped Fullbeard)",
		"Beard (Hipster)",
		"Beard (Neckbeard)",
		"Beard (Three o Clock Shadow)",
		"Beard (Five o Clock Shadow)",
		"Beard (Seven o Clock Shadow)",
		"Moustache (Hulk Hogan)",
		"Moustache (Watson)",
		"Sideburns (Elvis)",
		"Sideburns",
		"Shaved"
	)

	shoes = list(/obj/item/clothing/shoes/vampire)
	uniforms = list(/obj/item/clothing/under/vampire/guard)
	// TODO: [Lucia] reimplement doors
	/*
	pockets = list(/obj/item/vamp/keys/npc, /obj/item/stack/dollar/rand)
	*/

	neutral_phrases = list(
		"No loitering.",
		"I'm kinda, like, a cop, you know.",
		"I could go for some bearclaws right about now.",
		"Like the uniform?",
		"Hey, catch me later, I'll buy you a beer."
	)
	neutral_phrases = list(
		"No loitering.",
		"I'm kinda, like, a cop, you know?",
		"I could go for some bearclaws right about now.",
		"Like the uniform?",
		"Hey, catch me later, I'll buy you a beer."
	)
	random_phrases = list(
		"It's been a real quiet night.",
		"My brothers and father are security guards, too."
	)
	answer_phrases = list("I need some coffee.")
	help_phrases = list(
		"It's go time!",
		"Stop right there!!",
		"Drop your weapon!",
		"Freeze!!",
		"Not just a mall cop, you know!"
	)
