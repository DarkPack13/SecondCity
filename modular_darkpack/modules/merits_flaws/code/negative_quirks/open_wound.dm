// VTM pg. 482
/datum/quirk/darkpack/open_wound
	name = "Open Wound"
	desc = {"You have one or more wounds that refuse to heal, and which constantly drip blood.
This slow leakage costs you an extra blood point per evening,
in addition to drawing attention to you.
If the wound is visible, you are at + 1 difficulty for all Social-based rolls."}
	value = -2 // If we decide to use the 4 point flaw version, make incompatible with permanent wound.
	gain_text = span_notice("An unhealed wound bleeds.")
	lose_text = span_notice("Old wounds heal.")
	failure_message = "Old wounds heal."
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_BANDAGE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mob_trait = TRAIT_OPEN_WOUND

/*You have one or more wounds that refuse to heal,
and which constantly drip blood. This slow leakage
costs you an extra blood point per evening (marked off
just before dawn), in addition to drawing attention to
you. If the wound is visible, you are at + 1 difficulty for
all Social-based rolls. For two points, the Flaw is simply
unsightly and has the basic effect mentioned above; for
four points the seeping wound is serious or disfiguring
and includes the effects of the Flaw Permanent Wound
(below).*/

/datum/quirk/darkpack/open_wound/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return

/datum/quirk/darkpack/open_wound/process(seconds_per_tick)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(human_holder.bloodpool > 0)
		human_holder.adjust_blood_pool(-0.001)// Play with this number as needed.
