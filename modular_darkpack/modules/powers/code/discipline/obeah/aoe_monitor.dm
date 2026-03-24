/datum/proximity_monitor/advanced/shepherds_watch
	edge_is_a_field = TRUE
	var/list/ignored_mobs

/datum/proximity_monitor/advanced/shepherds_watch/New(atom/_host, range, _ignore_if_not_on_turf = TRUE)
	. = ..()
	ignored_mobs = new()

/datum/proximity_monitor/advanced/shepherds_watch/Destroy()
	ignored_mobs = null
	return ..()
