#define MAX_RENOWN 10

/datum/splat/werewolf/proc/adjust_renown(attribute, amount)
	if(!renown[attribute])
		renown[attribute] = 0


	var/old_rank = renown_rank
	var/new_amount = clamp(renown[attribute] + amount, 0, MAX_RENOWN)

	renown[attribute] = new_amount
	if(amount < 0)
		to_chat(owner, span_userdanger("You feel [get_negative_emotion(attribute)]!"))
	else if(amount > 0)
		to_chat(owner, span_bold("You feel [get_positive_emotion(attribute)]!"))

	// switch(attribute)
	// 	if(RENOWN_HONOR)
	// 		owner.write_preference_midround(/datum/preference/numeric/renown/honor, new_amount)
	// 	if(RENOWN_GLORY)
	// 		owner.write_preference_midround(/datum/preference/numeric/renown/glory, new_amount)
	// 	if(RENOWN_WISDOM)
	// 		owner.write_preference_midround(/datum/preference/numeric/renown/wisdom, new_amount)

	renown_rank = auspice_rank_check()
	if(old_rank != renown_rank)
		to_chat(owner, span_boldnotice("You are now a [fera_rank_name(renown_rank)]."))

	// owner.write_preference_midround(/datum/preference/numeric/fera_rank, renown_rank)


/datum/splat/werewolf/proc/get_negative_emotion(attribute)
	switch(attribute)
		if(RENOWN_HONOR)
			return "ashamed"

		if(RENOWN_GLORY)
			return "humiliated"

		if(RENOWN_WISDOM)
			return "foolish"

	return "unsure"

/datum/splat/werewolf/proc/get_positive_emotion(attribute)
	switch(attribute)

		if(RENOWN_HONOR)
			return "vindicated"

		if(RENOWN_GLORY)
			return "brave"

		if(RENOWN_WISDOM)
			return "clever"

	return "confident"


/datum/splat/werewolf/proc/auspice_rank_check()
	return RANK_CLIATH
/*
	switch(auspice.name)
		if("Ahroun")
			if(glory >= 10 && honor >= 9 && wisdom >= 4)
				return 5
			if(glory >= 9 && honor >= 4 && wisdom >= 2)
				return 4
			if(glory >= 6 && honor >= 3 && wisdom >= 1)
				return 3
			if(glory >= 4 && honor >= 1 && wisdom >= 1)
				return 2
			if(glory >= 2 || honor >= 1)
				return 1
			return 0

		if("Galliard")
			if(glory >= 9 && honor >= 5 && wisdom >= 9)
				return 5
			if(glory >= 7 && honor >= 2 && wisdom >= 6)
				return 4
			if(glory >= 4 && honor >= 2 && wisdom >= 4)
				return 3
			if(glory >= 4 && wisdom >= 2)
				return 2
			if(glory >= 2 && wisdom >= 1)
				return 1
			return 0

		if("Philodox")
			if(glory >= 4 && honor >= 10 && wisdom >= 9)
				return 5
			if(glory >= 3 && honor >= 8 && wisdom >= 4)
				return 4
			if(glory >= 2 && honor >= 6 && wisdom >= 2)
				return 3
			if(glory >= 1 && honor >= 4 && wisdom >= 1)
				return 2
			if(honor >= 3)
				return 1
			return 0

		if("Theurge")
			if(glory >= 4 && honor >= 9 && wisdom >= 10)
				return 5
			if(glory >= 4 && honor >= 2 && wisdom >= 9)
				return 4
			if(glory >= 2 && honor >= 1 && wisdom >= 7)
				return 3
			if(glory >= 1 && wisdom >= 5)
				return 2
			if(wisdom >= 3)
				return 1
			return 0

		if("Ragabash")
			if((glory+honor+wisdom) >= 25)
				return 5
			if((glory+honor+wisdom) >= 19)
				return 4
			if((glory+honor+wisdom) >= 13)
				return 3
			if((glory+honor+wisdom) >= 7)
				return 2
			if((glory+honor+wisdom) >= 3)
				return 1
			return 0

	return 0
*/

// Pretty iffy on this. This could likely just be moved onto the splat itself so corax and other breeds can override it.
/proc/fera_rank_name(rank, breed)

	// if(breed != "Corax") DARKPACK TODO - CORAX
	switch(rank)
		if(RANK_CUB)
			return "cub" // in lowercase so that \a might function during the character examine
		if(RANK_CLIATH)
			return "cliath"
		if(RANK_FOSTERN)
			return "fostern"
		if(RANK_ADREN)
			return "adren"
		if(RANK_ATHRO)
			return "athro"
		if(RANK_ELDER)
			return "elder"
		if(RANK_LEGEND)
			return "legend"
/* DARKPACK TODO - CORAX
	switch(rank)
		if(0)
			return "fledgling"
		if(1)
			return "oviculum"
		if(2)
			return "neocornix"
		if(3)
			return "ales"
		if(4)
			return "volucris"
		if(5)
			return "corvus"
		if(6)
			return "grey eminence"
*/

#undef MAX_RENOWN
