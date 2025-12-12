//Function for updating a player's health based on their current stats.
/mob/living/proc/recalculate_max_health(initial = FALSE)
	var/old_max_health = maxHealth
	maxHealth = round(initial(maxHealth) + ((initial(maxHealth)/8) * st_get_stat(STAT_STAMINA)))
	if(initial)
		health = maxHealth
	else if(health > 0)
		health = max(health + maxHealth - old_max_health, 1)
