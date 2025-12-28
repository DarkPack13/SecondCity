#define MASQUERADE_FILTER_CHECK(T) (SSmasquerade.masquerade_breaching_phrase_regex && findtext(T, SSmasquerade.masquerade_breaching_phrase_regex))

/mob/living/carbon/human/npc/Hear(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods, message_range, source)
	if(stat >= SOFT_CRIT)
		return ..()

	var/treated_message = translate_language(speaker, message_language, raw_message, spans, message_mods)
	if(lowertext(MASQUERADE_FILTER_CHECK(treated_message)))
		SEND_SIGNAL(src, COMSIG_SEEN_MASQUERADE_VIOLATION, speaker)
	return ..()

/obj/item/smartphone/proc/handle_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	if(current_state == PHONE_IN_CALL)
		if(istype(hearing_args[HEARING_SPEAKER], /atom/movable/virtualspeaker))
			return
		var/message = compose_message(hearing_args[HEARING_SPEAKER], hearing_args[HEARING_LANGUAGE], hearing_args[HEARING_RAW_MESSAGE], hearing_args[HEARING_RADIO_FREQ], hearing_args[HEARING_RADIO_FREQ_NAME], hearing_args[HEARING_RADIO_FREQ_COLOR], hearing_args[HEARING_SPANS], hearing_args[HEARING_MESSAGE_MODE], FALSE)
		SSmasquerade.log_phone_message(message, source)
		if(lowertext(MASQUERADE_FILTER_CHECK(hearing_args[HEARING_RAW_MESSAGE])))
			SEND_SIGNAL(src, COMSIG_SEEN_MASQUERADE_VIOLATION, hearing_args[HEARING_SPEAKER])

#undef MASQUERADE_FILTER_CHECK
