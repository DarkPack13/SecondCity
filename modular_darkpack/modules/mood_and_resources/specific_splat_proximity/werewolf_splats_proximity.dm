// Actual Proximity Monitor //
/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/New(atom/_host, range, _ignore_if_not_on_turf = TRUE, datum/proximity_moods/moods)
	. = ..()
	src.moods = moods
	RegisterSignal(host, COMSIG_ATOM_EXAMINE, PROC_REF(on_werewolf_splat_examine), override = TRUE)

/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/field_turf_crossed(atom/movable/crossed, turf/old_location, turf/new_location)
	if (!isliving(crossed))
		return
	if (!can_see(crossed, host, current_range))
		return
	on_seen(crossed)


// Aura Checks //
/datum/proximity_monitor/advanced/mood_aura/proc/on_werewolf_splat_examine(datum/source, mob/examiner)
	SIGNAL_HANDLER
	if (isliving(examiner))
		on_seen(examiner)

/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/on_seen(mob/living/carbon/human/viewer)
	if (!viewer.mind)
		return
	if (IS_UNCONSCIOUS_OR_CRIT(viewer))
		return
	if (viewer.is_blind())
		return
	if (!should_apply_mood(viewer))
		return
	if (!viewer.can_read(host, moods.reading_requirements, TRUE)) // If it's a text based demoralization datum, make sure the mob has the capability to read. if it's only an image, make sure it's just bright enough for them to see it.
		return
	if (get_werewolf_splat(viewer)) // Fera AND Kinfolk
		to_chat(viewer, span_notice("[moods.werewolf_n_co_notification]"))
		viewer.add_mood_event(moods.mood_category, moods.werewolf_n_co_mood)

	SEND_SIGNAL(host, COMSIG_DEMORALISING_EVENT, viewer.mind)

/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/should_apply_mood(mob/living/carbon/human/viewer)
	if (!viewer.mob_mood)
		return FALSE

	return !viewer.mob_mood.has_mood_of_category(moods.mood_category)


// Moods //
/datum/proximity_moods/good_kinfolk_application
	mood_category = "good kinfolk"
	werewolf_n_co_notification = "Hey, the Kinfolk here are really pleasant!"
	werewolf_n_co_mood = /datum/mood_event/good_kinfolk

/datum/proximity_moods/outsider_application
	mood_category = "outsider"
	werewolf_n_co_notification = "An exile from my kind just passed me, I shouldn't be around them..."
	werewolf_n_co_mood = /datum/mood_event/outsider
