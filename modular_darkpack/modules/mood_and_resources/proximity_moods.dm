/*
 * Applies a splat-based mood if you can see the parent.
 *
 * - Applies a mood to people who are in visible range of the item.
 * - Does not re-apply mood to people who already have it.
 * - Sends a signal if a mood is successfully applied.
 */
/datum/proximity_monitor/advanced/mood_aura
	var/datum/proximity_moods/moods

/datum/proximity_monitor/advanced/mood_aura/New(atom/_host, range, _ignore_if_not_on_turf = TRUE, datum/proximity_moods/moods)
	. = ..()
	src.moods = moods
	RegisterSignal(host, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/proximity_monitor/advanced/mood_aura/field_turf_crossed(atom/movable/crossed, turf/old_location, turf/new_location)
	if (!isliving(crossed))
		return
	if (!can_see(crossed, host, current_range))
		return
	on_seen(crossed)

/*
 * Signal proc for [COMSIG_ATOM_EXAMINE].
 * Immediately tries to apply a mood to the examiner, ignoring the proximity check.
 * If someone wants to make themselves sad through a camera that's their choice I guess.
 */
/datum/proximity_monitor/advanced/mood_aura/proc/on_examine(datum/source, mob/examiner)
	SIGNAL_HANDLER
	if (isliving(examiner))
		on_seen(examiner)

/**
 * Called when someone is looking at a demoralising object.
 * Applies a mood if they are conscious and don't already have it.
 * Different moods are applied based on the viewer's splat.
 *
 * Arguments
 * * viewer - Whoever is looking at this.
 */
/datum/proximity_monitor/advanced/mood_aura/proc/on_seen(mob/living/carbon/human/viewer)
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
	else if (get_vampire_splat(viewer)) // Kindred AND Ghoul
		to_chat(viewer, span_notice("[moods.vampire_n_co_notification]"))
		viewer.add_mood_event(moods.mood_category, moods.vampire_n_co_mood)
	else
		to_chat(viewer, span_notice("[moods.human_notification]")) // We're assuming splatless (human)
		viewer.add_mood_event(moods.mood_category, moods.human_mood)

	SEND_SIGNAL(host, COMSIG_DEMORALISING_EVENT, viewer.mind)

/**
 * Returns true if user is capable of experiencing moods and doesn't already have the one relevant to this datum, false otherwise.
 *
 * Arguments
 * * viewer - Whoever just saw the parent.
 */
/datum/proximity_monitor/advanced/mood_aura/proc/should_apply_mood(mob/living/carbon/human/viewer)
	if (!viewer.mob_mood)
		return FALSE

	return !viewer.mob_mood.has_mood_of_category(moods.mood_category)

/// Mood application categories for this objective
/// Used to reduce duplicate code for applying moods to players based on their state
/datum/proximity_moods
	/// Mood category to apply to moods
	var/mood_category

	/// Text to display to Fera or Kinfolk upon receiving this mood
	var/werewolf_n_co_notification
	/// Mood datum to apply to Fera or Kinfolk
	var/datum/mood_event/werewolf_n_co_mood

	/// Text to display to Kindred or Ghouls upon receiving this mood
	var/vampire_n_co_notification
	/// Mood datum to apply to Kindred or Ghouls
	var/datum/mood_event/vampire_n_co_mood

	/// Text to display to Humans upon receiving this mood
	var/human_notification
	/// Mood datum to apply to Humans
	var/datum/mood_event/human_mood

	/// For literacy checks
	var/reading_requirements = READING_CHECK_LIGHT

// Did not at all pinch from Demoraliser.dm
