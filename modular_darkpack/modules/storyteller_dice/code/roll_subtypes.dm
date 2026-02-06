// Pretty generic ones for reuse if you dont really want/need a subtype
/datum/storyteller_roll/turn_cooldown
	reroll_cooldown = 1 TURNS

/datum/storyteller_roll/scene_cooldown
	reroll_cooldown = 1 SCENES

/datum/storyteller_roll/spammy
	spammy_roll = TRUE

// Mostly TTRPG accurate rolls

// Physical Feats
/datum/storyteller_roll/lockpick
	bumper_text = "lockpicking"
	reroll_cooldown = 1 SCENES
	applicable_stats = list(STAT_DEXTERITY, STAT_LARCENY)

/datum/storyteller_roll/bash_door
	bumper_text = "bash door"
	reroll_cooldown = 1 SCENES
	applicable_stats = list(STAT_STRENGTH)
	numerical = TRUE

/datum/storyteller_roll/grappling
	bumper_text = "grappling"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE

/datum/storyteller_roll/grappled
	bumper_text = "resisting"
	applicable_stats = list(STAT_STRENGTH, STAT_BRAWL)
	numerical = TRUE
	spammy_roll = TRUE

/datum/storyteller_roll/climbing
	bumper_text = "climbing"
	applicable_stats = list(STAT_DEXTERITY, STAT_ATHLETICS)

/datum/storyteller_roll/shooting
	bumper_text = "shooting"
	applicable_stats = list(STAT_DEXTERITY, STAT_FIREARMS)
	reroll_cooldown = 1 TURNS
	numerical = TRUE

// Mental Feats
/datum/storyteller_roll/investigation
	bumper_text = "investigation"
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION)


// Made up shittttt
/datum/storyteller_roll/identify_occult
	bumper_text = "identify"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_OCCULT)
	reroll_cooldown = 1 SCENES
