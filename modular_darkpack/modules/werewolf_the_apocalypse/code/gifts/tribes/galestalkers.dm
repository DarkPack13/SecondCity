#warn do
/datum/action/cooldown/power/gift/beat_of_the_heartdrum
	name = "Beat of the Heart-Drum"
	rank = 1

/datum/action/cooldown/power/gift/beat_of_the_heartdrum/Activate(atom/target)
	var/mob/living/living_owner = astype(owner)
	if(!living_owner)
		return FALSE

	var/list/valid_targets = list()
	for(var/datum/weakref/blood_ref in living_owner.mobs_tasted_blood_of)
		var/mob/blood_guy = blood_ref.resolve()
		if(blood_guy)
			valid_targets[GET_GUESTBOOK_NAME(living_owner, blood_guy)] = blood_guy

	if(!length(valid_targets))
		to_chat(owner, span_notice("You cant think of any targets you could track at this current moment"))
		return FALSE

	. = ..()

	var/datum/storyteller_roll/gift/beat_of_the_heartdrum/roll_datum = new()
	var/roll_successes = roll_datum.st_roll(owner, target)
	if(roll_successes <= 0)
		return TRUE

	var/list/choices = list()
	for(var/name, entry in valid_targets)
		var/mob/valid_target = entry

		var/image/target_image = image(icon = valid_target.icon, icon_state = valid_target.icon_state)
		target_image.overlays = valid_target.overlays

		choices[name] = target_image

	var/tracking_name = show_radial_menu(owner, owner, choices, radius = 40, tooltips = TRUE, autopick_single_option = FALSE)

	to_chat(owner, span_notice("Tracking [tracking_name]"))


/datum/status_effect/beat_of_the_heartdrum
	id = "beat_of_the_heartdrum"
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/gift/beat_of_the_heartdrum


/atom/movable/screen/alert/status_effect/gift/beat_of_the_heartdrum
	name = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::name
	desc = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::desc
	overlay_state = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::button_icon_state


/datum/storyteller_roll/gift/beat_of_the_heartdrum
	bumper_text = "Beat of the Heart-Drum"
	applicable_stats = list(STAT_PERCEPTION, STAT_SURVIVAL)
	difficulty = 7
	numerical = TRUE
