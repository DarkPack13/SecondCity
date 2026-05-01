/atom/movable/screen/alert/status_effect/putrefaction
	name = "Putrefaction"
	desc = "Your face has aged terribly!"
	icon_state = "wounded_soldier"

/datum/status_effect/putrefaction
	id = "putrefaction"
	status_type = STATUS_EFFECT_MULTIPLE
	duration = 1 SCENES //3 Minutes
	alert_type = /atom/movable/screen/alert/status_effect/putrefaction

/datum/status_effect/putrefaction/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_APPEARANCE, -2, "Putrefaction")

/datum/status_effect/putrefaction/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_APPEARANCE, "Putrefaction")

/datum/status_effect/putrefaction/two
	id = "putrefaction2"
	status_type = STATUS_EFFECT_MULTIPLE
	duration = 1 SCENES //3 Minutes
	alert_type = /atom/movable/screen/alert/status_effect/putrefaction

/datum/status_effect/putrefaction/two/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_DEXTERITY, -1, "Putrefaction")

/datum/status_effect/putrefaction/two/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, "Putrefaction")

/datum/status_effect/putrefaction/three
	id = "putrefaction3"
	status_type = STATUS_EFFECT_MULTIPLE
	duration = 1 SCENES //3 Minutes
	alert_type = /atom/movable/screen/alert/status_effect/putrefaction

/datum/status_effect/putrefaction/three/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_APPEARANCE, -1, "Putrefaction")
	owner.st_add_stat_mod(STAT_DEXTERITY, -1, "Putrefaction")
	owner.st_add_stat_mod(STAT_STRENGTH, -1, "Putrefaction")

/datum/status_effect/putrefaction/three/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_APPEARANCE, "Putrefaction")
	owner.st_remove_stat_mod(STAT_DEXTERITY, "Putrefaction")
	owner.st_remove_stat_mod(STAT_STRENGTH, "Putrefaction")

/datum/status_effect/putrefaction/four
	id = "putrefaction4"
	status_type = STATUS_EFFECT_MULTIPLE
	duration = 1 SCENES //3 Minutes
	alert_type = /atom/movable/screen/alert/status_effect/putrefaction

/datum/status_effect/putrefaction/four/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_APPEARANCE, -2, "Putrefaction")
	owner.st_add_stat_mod(STAT_DEXTERITY, -1, "Putrefaction")
	owner.st_add_stat_mod(STAT_STRENGTH, -1, "Putrefaction")

/datum/status_effect/putrefaction/four/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_APPEARANCE, "Putrefaction")
	owner.st_remove_stat_mod(STAT_DEXTERITY, "Putrefaction")
	owner.st_remove_stat_mod(STAT_STRENGTH, "Putrefaction")
