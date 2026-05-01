/proc/log_stats(text, list/data)
	logger.Log(LOG_CATEGORY_STATS, text, data)

/datum/log_category/stats
	category = LOG_CATEGORY_STATS
	config_flag = /datum/config_entry/flag/log_stats

/datum/config_entry/flag/log_stats
