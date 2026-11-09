/datum/quirk/darkpack/good_old_boy_or_girl
	name = "Good old Boy (or Girl)"
	desc = {"For either gender, this merit means the same thing: You're an intrinsically
			nice person, and you genuinely care about your fellows. Depending upon the
			setting, werewolves and other Kin (both human and wolf) tend to like you
			and confide in you. Even lupus Garou may approach you in a friendly manner;
			something about you just seems trustworthy and inviting."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 54)
	value = 2
	mob_trait = TRAIT_GOOD_OLD_BOY_OR_GIRL
	gain_text = span_notice("You feel great empathy for your kin.")
	lose_text = span_notice("Your feelings towards your kin mellow out.")
	icon = FA_ICON_HAND_HOLDING_HEART
	failure_message = "Your feelings towards your kin mellow out."
	allowed_splats = list(SPLAT_KINFOLK)

// NOTE - Re-add "Take an extra die on all Social rolls involving interaction with Garou or Kinfolk." to the end if the rolls end up ingame.

/datum/quirk/darkpack/good_old_boy_or_girl/proc/is_valid_kin(mob/living/subject, mob/living/carbon/human/target)
	if(IS_UNCONSCIOUS(target))
		return FALSE
	if(target.invisibility > subject.see_invisible || target.alpha < 20)
		return FALSE
	if(!get_werewolf_splat(target))
		return FALSE
	return TRUE

/datum/mood_event/good_kinfolk
	description = "A kinfolk I've met as of late has brought me some comfort."
	mood_change = 4
	timeout = 2 MINUTES

/datum/quirk/darkpack/good_old_boy_or_girl/proc/on_tick(mob/living/good_kinfolk_holder, seconds_per_tick)
	var/list/nearby_kin = list()
	for(var/mob/living/carbon/human/nearby in view(good_kinfolk_holder, 5))
		if(nearby == good_kinfolk_holder || !is_valid_kin(good_kinfolk_holder, nearby))
			continue
		nearby_kin += nearby

	for(var/mob/living/carbon/human/kin_target as anything in nearby_kin)
		to_chat(kin_target, span_notice("Wow! [good_kinfolk_holder.name] is really pleasant to be around!"))
		kin_target.add_mood_event("friendly_kinfolk", /datum/mood_event/good_kinfolk)


	//for(var/mob/living/nearby_k as anything in nearby_kin)
	//	to_chat(nearby_k, span_notice("Wow! [good_kinfolk_holder.name] is really pleasant to be around!"))
	//	nearby_k.add_mood_event("Friendly Kinfolk", /datum/mood_event/good_kinfolk)

