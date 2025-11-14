/obj/ritualrune/identification
	name = "Identification Rune"
	desc = "Identifies a single occult item."
	icon_state = "rune4"
	word = "IN'DAR"

/obj/ritualrune/identification/complete()
	for(var/obj/item/vtm_artifact/VA in loc)
		if(VA)
			var/mob/living/carbon/human/identifier = usr // TFN ADDITION - Paths
			if(VA.identified)
				to_chat(identifier, span_warning("You have already identified this artifact."))
				return
			VA.identify()
			playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
			qdel(src)
			return

