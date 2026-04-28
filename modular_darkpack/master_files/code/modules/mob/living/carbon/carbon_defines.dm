/mob/living/carbon
	bloodquality = BLOOD_QUALITY_NORMAL

	var/chronological_age = 0

	var/image/suckbar
	var/atom/suckbar_loc

	var/fakediablerist = FALSE
	var/can_be_embraced = TRUE

	///The number of dice available to soak bashing, lethal, and aggravated damage
	var/soak_dice_bashing = 0
	var/soak_dice_lethal = 0
	var/soak_dice_aggravated = 0

