/mob/living/carbon
	bloodquality = BLOOD_QUALITY_NORMAL

	/// Your age + immortal age.
	var/chronological_age = 0

	/// Blood drinking visual
	var/image/suckbar

	// Used by a necromancy ritual? unused rn I belive
	var/fakediablerist = FALSE
	var/can_be_embraced = TRUE

	//stats for combat bites // used for lupus, crinos, hispo, fomori, etc.
	var/list/combat_bite_damages = list(BRUTE = 1 LETHAL_TTRPG_DAMAGE, BURN = 0, TOX = 0, OXY = 0, AGGRAVATED = 0)
	var/list/combat_bite_stats = list(STAT_DEXTERITY, STAT_BRAWL)
	var/list/combat_bite_difficulty = 5
