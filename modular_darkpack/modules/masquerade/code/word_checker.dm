#define MASQUERADE_FILTER_CHECK(T) (SSmasquerade.masquerade_breaching_phrase_regex && findtext(T, SSmasquerade.masquerade_breaching_phrase_regex))

/mob/living/carbon/human/npc/Hear(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods, message_range)
	if(stat >= SOFT_CRIT)
		return ..()

	//if(issabbat(src)) //Because sabbatists are idiots.
	//	return ..()

	var/treated_message = translate_language(speaker, message_language, raw_message, spans, message_mods)
	if(lowertext(MASQUERADE_FILTER_CHECK(treated_message)))
		SEND_SIGNAL(src, COMSIG_SEEN_MASQUERADE_VIOLATION, speaker)
	..()

/* DARKPACK TODO: PHONES
/obj/item/vamp/phone/handle_hearing(datum/source, list/hearing_args)
	if(online && talking)
		if(istype(hearing_args[HEARING_SPEAKER], /obj/phonevoice))
			return ..()
		if(lowertext(MASQUERADE_FILTER_CHECK(hearing_args[HEARING_RAW_MESSAGE])))
			SEND_SIGNAL(src, COMSIG_SEEN_MASQUERADE_VIOLATION, hearing_args[HEARING_SPEAKER])
	..()
*/

#undef MASQUERADE_FILTER_CHECK
