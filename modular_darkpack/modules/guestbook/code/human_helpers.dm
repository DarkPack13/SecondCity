/mob/living/carbon/human/proc/get_gender()
	var/visible_gender = get_visible_gender()
	switch(visible_gender)
		if(MALE)
			visible_gender = "Man"
		if(FEMALE)
			visible_gender = "Woman"
		else
			visible_gender = "Person"
	return visible_gender

/mob/living/carbon/human/proc/get_age()
	switch(age)
		if(70 to INFINITY)
			return "Geriatric"
		if(60 to 70)
			return "Elderly"
		if(50 to 60)
			return "Old"
		if(40 to 50)
			return "Middle-Aged"
		if(24 to 40)
			return "" //not necessary because this is basically the most common age range
		if(18 to 24)
			return "Young"
		else
			return "Puzzling"

/mob/living/carbon/human/proc/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/visible_skin = GLOB.skin_tone_names[skin_tone] ? "[GLOB.skin_tone_names[skin_tone]] " : null
	var/visible_gender = get_gender()
	var/visible_age = get_age()
	var/final_string = "[visible_adjective ? "[visible_adjective] " : null][visible_age ? "[visible_age] " : null][visible_skin][visible_gender]"
	if(prefixed)
		final_string = "\A [final_string]"
	return lowercase ? lowertext(final_string) : final_string
