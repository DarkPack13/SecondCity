// VTM pg. 480
/datum/quirk/darkpack/friendly_face // Debate making this incompatible with disfigured?
	name = "Friendly Face"
	desc = {"You have a face that reminds everyone of someone,
to the point where strangers are inclined to be well inclined toward you because of it.
The effect doesn't fade even if you explain the “mistake,”
leaving you at -1 difficulty on all appropriate Social-based rolls
(yes for Seduction, no for Intimidation, for example)."}
	icon = FA_ICON_FACE_GRIN_HEARTS
	value = 1
	gain_text = span_notice("Your face seems familiar to others.")
	lose_text = span_notice("You feel like others don't look at you the same way anymore.")
	failure_message = span_notice("You feel like others don't look at you the same way anymore.")
	mob_trait = TRAIT_FRIENDLY_FACE


/*You have a face that reminds everyone of someone,
to the point where strangers are inclined to be well
inclined toward you because of it. The effect doesn’t
fade even if you explain the “mistake,” leaving you at -1 difficulty on all appropriate Social-based rolls (yes
for Seduction, no for Intimidation, for example) when
a stranger is involved. This Merit only functions on a first meeting.*/
