/datum/quirk/darkpack/permanent_third_eye
	name = "Permanent Third Eye"
	desc = "Tremere's most infamous crime is visible on your head. Like the Salubri, you suffer from a third eye."
	value = 2
	mob_trait = TRAIT_THIRD_EYE
	gain_text = span_notice("Saulot curses you for your forefather's crime. Your third eye opens to never close again.")
	lose_text = span_notice("The Dragon sleeps again. Your third eye seals shut.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	icon = FA_ICON_EYE
	failure_message = "Your blood resists the urge to open the third eye."

/datum/quirk/darkpack/permanent_third_eye/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	if(!ishuman(new_holder))
		return

	var/mob/living/carbon/human/human_holder = new_holder
	var/datum/splat/vampire/kindred/kindred = iskindred(human_holder)
	if(kindred)
		if(istype(kindred.clan, /datum/subsplat/vampire_clan/tremere))


/datum/quirk/darkpack/permanent_third_eye/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	var/obj/item/organ/eyes/salubri/three_eyes = new()
	three_eyes.Insert(gaining_mob, TRUE, DELETE_IF_REPLACED)

/datum/quirk/darkpack/permanent_third_eye/on_lose(mob/living/carbon/human/losing_mob)
	// replace eyes
	var/eye_type = /obj/item/organ/eyes
	if(losing_mob.dna.species && losing_mob.dna.species.mutanteyes)
		eye_type = losing_mob.dna.species.mutanteyes
	var/obj/item/organ/eyes/new_eyes = new eye_type()
	new_eyes.Insert(losing_mob, TRUE, DELETE_IF_REPLACED)


