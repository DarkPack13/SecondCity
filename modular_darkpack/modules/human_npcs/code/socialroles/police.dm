/datum/socialrole/police
	min_age = 18
	max_age = 45
	male_names = null
	surnames = null

	hair_colors = list(
		"#040404",	//Black
		"#120b05",	//Dark Brown
		"#342414",	//Brown
		"#554433",	//Light Brown
		"#695c3b",	//Dark Blond
		"#ad924e",	//Blond
		"#dac07f",	//Light Blond
		"#802400",	//Ginger
		"#a5380e",	//Ginger alt
		"#ffeace",	//Albino
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
		"Volaju",
	)

	female_hair = list(
		"Ahoge",
		"Bob Hair",
		"Bob Hair 2",
		"Bob Hair 3",
		"Bob Hair 4",
		"Bobcurl",
		"Braided",
		"Braided Front",
		"Braid (Short)",
		"Braid (Low)",
		"Bun Head",
		"Bun Head 2",
		"Bun Head 3",
		"Bun (Large)",
		"Bun (Tight)",
		"Gentle",
		"Long Hair 1",
		"Long Hair 2",
		"Long Hair 3",
		"Short Hair Rosa",
		"Shoulder-length Hair",
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
		"Shaved",
	)

	shoes = list(/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/police)
	hats = list(/obj/item/clothing/head/vampire/police)
	suits = list(/obj/item/clothing/suit/vampire/vest/police)
	pockets = list(
		/obj/item/vamp/keys/npc,
		/obj/item/smartphone
	)

	primary_weapons = list(
		/obj/item/gun/ballistic/revolver/darkpack/magnum = 90,
		/obj/item/gun/ballistic/automatic/darkpack/ar15 = 10,
	)

	secondary_weapons = list(
		/obj/item/melee/baton/vamp = 90,
		/obj/item/gun/energy/taser/darkpack = 10,
	)

	male_phrases = list(
		"I see you.",
		"Looking suspicious...",
		"Don't try anything stupid.",
		"Nothing to see here.",
		"We're watching you...Scum.",
		"Have you seen a man in a black coat with black hair?",
		"Citizen.",
		"You catch the game last night?"
	)

	neutral_phrases = list(
		"I see you.",
		"Looking suspicious...",
		"Don't try anything stupid.",
		"Nothing to see here.",
		"We're watching you...Scum.",
		"Have you seen a man in a black coat with black hair?",
		"Citizen.",
		"You catch the game last night?"
	)

	female_phrases = list(
		"I see you.",
		"Looking suspicious...",
		"Don't try anything stupid.",
		"Nothing to see here.",
		"We're watching you...Scum.",
		"Have you seen a man in a black coat with black hair?",
		"Citizen.",
		"You catch the game last night?"
	)

	random_phrases = list(
		"I see you.",
		"Looking suspicious...",
		"Don't try anything stupid.",
		"Nothing to see here.",
		"We're watching you...Scum.",
		"Have you seen a man in a black coat with black hair?",
		"Citizen.",
		"You catch the game last night?",
	)
	answer_phrases = list(
		"I'm here to protect you."
	)
	help_phrases = list(
		"Lay down!",
		"Stop right there!!",
		"Drop your weapon!",
		"Stop there right now!!",
		"This is SFPD, hands on your head!",
		"You have the right to remain silent!",
		"Bush gave me the right to kick your head in!",
		"I'm gonna beat you harder than the Eagles got beat by the Patriots!",
	)
