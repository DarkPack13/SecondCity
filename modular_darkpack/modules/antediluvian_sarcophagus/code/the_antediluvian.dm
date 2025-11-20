#define ANTEDILUVIAN_SCORE "Antediluvians Killed"
/mob/living/simple_animal/hostile/megafauna/wendigo/antediluvian
	name = "Unknown Antediluvian"
	desc = "A mythological legendary kindred, you probably aren't going to survive this."
	health = 2500
	maxHealth = 2500
	icon_state = "eva"
	icon_living = "eva"
	icon_dead = "eva_dead"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	pixel_x = 0
	base_pixel_x = 0
	guaranteed_butcher_results = list()
	crusher_loot = null
	death_message = "falls, shaking the ground around it"
	score_achievement_type = /datum/award/score/antediluvian_score

/datum/award/score/antediluvian_score
	name = "Antediluvian Killed"
	desc = "You've killed HOW many?"
	database_id = ANTEDILUVIAN_SCORE
