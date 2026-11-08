/datum/quirk/darkpack/good_old_boy_or_girl
	name = "Good Old Boy (Or Girl)"
	desc = {"For either gender, this merit means the same thing: You're an intrinsically
			nice person, and you genuinely care about your fellows. Depending upon the
			setting, werewolves and other Kin (both human and wolf) tend to like you
			and confide in you. Even lupus Garou may approach you in a friendly manner;
			something about you just seems trustworthy and inviting. Take an extra die
			on all Social rolls involving interaction with Garou or Kinfolk."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 54)
	value = 2
	mob_trait = TRAIT_GOOD_OLD_BOY_OR_GIRL
	gain_text = span_notice("You feel great empathy for your kin.")
	lose_text = span_notice("Your feelings towards your kin mellow out.")
	icon = FA_ICON_USER_SHIELD
	failure_message = "Your feelings towards your kin mellow out."
	allowed_splats = list(SPLAT_KINFOLK)


/datum/personality/good_old_boy_or_girl/proc/is_valid_kin(mob/living/subject, mob/living/carbon/human/target)
	if(IS_UNCONSCIOUS(target))
		return FALSE
	if(target.invisibility > subject.see_invisible || target.alpha < 20)
		return FALSE
	if(get_werewolf_splat(target))
		return TRUE
	else
		return FALSE

/datum/mood_event/good_kinfolk
	description = "The people I've met as of late have brought me some comfort."
	mood_change = 4
	timeout = 2 MINUTES

/datum/personality/good_old_boy_or_girl/on_tick(mob/living/good_kinfolk_holder, seconds_per_tick)
	for(var/mob/living/carbon/human/nearby_kin in view(good_kinfolk_holder, 3))
		if(nearby_kin == good_kinfolk_holder || !is_valid_kin(good_kinfolk_holder, nearby_kin))
			continue
		to_chat(nearby_kin, span_notice("Wow! [good_kinfolk_holder.name] is really pleasant to be around!"))
		nearby_kin.add_mood_event("Friendly Kinfolk", /datum/mood_event/good_kinfolk)


	//for(var/mob/living/nearby_k as anything in nearby_kin)
	//	to_chat(nearby_k, span_notice("Wow! [good_kinfolk_holder.name] is really pleasant to be around!"))
	//	nearby_k.add_mood_event("Friendly Kinfolk", /datum/mood_event/good_kinfolk)

