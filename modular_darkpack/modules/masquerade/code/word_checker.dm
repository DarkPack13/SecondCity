#define MASQUERADE_FILTER_CHECK(T) (SSmasquerade.masquerade_breaching_phrase_regex && findtext(T, SSmasquerade.masquerade_breaching_phrase_regex))

/mob/living/carbon/human/npc/Hear(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods = list(), message_range = 0, source)
	. = ..()
	if(stat >= SOFT_CRIT)
		return FALSE

	var/dist = get_dist(speaker, src) - message_range
	if(dist > 0 && dist <= EAVESDROP_RANGE && !HAS_TRAIT(src, TRAIT_GOOD_HEARING))
		raw_message = stars(raw_message)
	if(message_range != INFINITY && dist > EAVESDROP_RANGE && !HAS_TRAIT(src, TRAIT_GOOD_HEARING))
		return FALSE

	if(!has_language(message_language))
		return FALSE

	var/treated_message = translate_language(speaker, message_language, raw_message, spans, message_mods)
	var/is_breach = MASQUERADE_FILTER_CHECK(LOWER_TEXT(treated_message))
	if(is_breach)
		SEND_SIGNAL(src, COMSIG_SEEN_MASQUERADE_VIOLATION, speaker)
	return TRUE

/obj/item/radio/vampire/talk_into_impl(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	. = ..()
	var/obj/item/smartphone/phone_loc = loc
	if(!phone_loc.violation_observer) //(phone_loc.current_state == PHONE_IN_CALL) violation_observer is doing this for now, so no point unless someone wants breaches w/o a call (like voice recordings?)
		return
	SSmasquerade.log_phone_message(message, phone_loc)
	var/is_breach = MASQUERADE_FILTER_CHECK(LOWER_TEXT(message))
	if(is_breach)
		SEND_SIGNAL(phone_loc, COMSIG_SEEN_MASQUERADE_VIOLATION, talking_movable)

#undef MASQUERADE_FILTER_CHECK
