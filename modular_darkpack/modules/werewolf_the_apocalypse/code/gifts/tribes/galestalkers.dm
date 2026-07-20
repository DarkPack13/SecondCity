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

	#warn TESTING BLOCK
	for(var/mob/living/guy in view(7, living_owner))
		valid_targets[GET_GUESTBOOK_NAME(living_owner, guy)] = guy


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

	if(!tracking_name)
		return
	
	to_chat(owner, span_notice("Tracking [tracking_name]"))
	living_owner.apply_status_effect(/datum/status_effect/beat_of_the_heartdrum, valid_targets[tracking_name])


/datum/status_effect/beat_of_the_heartdrum
	id = "beat_of_the_heartdrum"
	duration = 1 SCENES
	tick_interval = 2 SECONDS
	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/gift/beat_of_the_heartdrum
	var/datum/weakref/hunting_ref

/datum/status_effect/beat_of_the_heartdrum/on_creation(mob/living/new_owner, mob/living/target)
	. = ..()
	hunting_ref = WEAKREF(target)

/datum/status_effect/beat_of_the_heartdrum/tick(seconds_between_ticks)
	if(!owner.client)
		return

	var/mob/living/target = hunting_ref.resolve()
	if(!target?.heart_is_beating())
		return

	var/dist = get_dist_euclidean(owner, target) || 0
	var/sound_volume = clamp(100 - dist * 3, 5, 100)
	SEND_SOUND(owner, sound('sound/effects/singlebeat.ogg', volume = sound_volume))

	var/turf/current_turf = get_step_towards(owner, target)
	var/image/blip_image = image(icon = 'icons/effects/effects.dmi', icon_state = "blip", layer = HIGH_PIPE_LAYER, loc = current_turf)
	SET_PLANE(blip_image, GAME_PLANE, current_turf)
	blip_image.alpha = sound_volume

	current_turf.flick_overlay(blip_image, list(owner.client), 0.6 SECONDS)


/atom/movable/screen/alert/status_effect/gift/beat_of_the_heartdrum
	name = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::name
	desc = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::desc
	overlay_state = /datum/action/cooldown/power/gift/beat_of_the_heartdrum::button_icon_state


/datum/storyteller_roll/gift/beat_of_the_heartdrum
	bumper_text = "Beat of the Heart-Drum"
	applicable_stats = list(STAT_PERCEPTION, STAT_SURVIVAL)
	difficulty = 7
	numerical = TRUE


/mob/proc/heart_is_beating()
	return FALSE

/mob/living/heart_is_beating()
	if(stat == DEAD)
		return FALSE

	return TRUE

/mob/living/carbon/human/heart_is_beating()
	var/obj/item/organ/heart/beating_heart = get_organ_slot(ORGAN_SLOT_HEART)
	if(!istype(beating_heart) && !(beating_heart.is_beating()))
		return FALSE

	// high humanity kindred OR kindred with blush of health avoid getting the still heart. in auspex, their hearts will instead show like humans; beating!
	if(get_kindred_splat(src))
		var/datum/st_stat/morality_path/morality/stat_morality = storyteller_stats[STAT_MORALITY]
		if((stat_morality?.morality_path?.alignment != MORALITY_HUMANITY || stat_morality?.get_score() < 5) && !HAS_TRAIT(src, TRAIT_BLUSH_OF_HEALTH))
			return FALSE

	return TRUE


