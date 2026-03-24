/datum/proximity_monitor/advanced/shepherds_watch
	edge_is_a_field = TRUE
	var/list/ignored_mobs

/datum/proximity_monitor/advanced/shepherds_watch/New(atom/_host, range, _ignore_if_not_on_turf = TRUE)
	. = ..()
	ignored_mobs = new()
	recalculate_field(full_recalc = TRUE)

/datum/proximity_monitor/advanced/shepherds_watch/Destroy()
	ignored_mobs = null
	return ..()


/datum/proximity_monitor/proc/on_entered(atom/source, atom/movable/arrived, turf/old_loc)
	. = ..()

/datum/proximity_monitor/proc/on_initialized(turf/location, atom/created, init_flags)
	. = ..()

/datum/proximity_monitor/proc/on_moved(atom/movable/source, atom/old_loc)
	. = ..()

/datum/proximity_monitor/proc/on_z_change()
	. = ..()

