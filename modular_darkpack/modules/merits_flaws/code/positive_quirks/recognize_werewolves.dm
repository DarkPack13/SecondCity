#define RECOGNIZE_WEREWOLVES_COOLDOWN "recognize_werewolves_cooldown"

/datum/quirk/darkpack/recognize_werewolves
	name = "Recognize Werewolves"
	desc = {"Over the years, you've become adept at picking out the Shifters of your
			race in a crowd. Rather than having any kind of mystical awareness, you've
			simply learned what physical and personality traits tend to mark Gaia's children.
			They just stand out to you, once they're undergone the Change. You may use
			attempts of perception to notice which people in the room seem to have that
			special touch of Rage or wildness that could indicate they are of your
			Changing Breed."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 52)
	value = 3
	mob_trait = TRAIT_RECOGNIZE_WEREWOLVES
	gain_text = span_notice("You percieve intricacies about your kin not many would notice.")
	lose_text = span_notice("Your perception dulls, the intuition guiding it is no more.")
	icon = FA_ICON_PAW
	failure_message = "Your perception dulls, the intuition guiding it is no more."
	allowed_splats = list(SPLAT_KINFOLK)
	// Gives an ability to identify Shifters with a perception check — 5m per-target cooldown.
	// NOTE - Lock to kin type when more than Garou exist.

/datum/quirk/darkpack/recognize_werewolves/add(client/client_source)
	var/datum/action/cooldown/recognize_werewolves/recognize_those_wolves = new()
	recognize_those_wolves.Grant(quirk_holder)

/datum/quirk/darkpack/recognize_werewolves/remove(datum/action/cooldown/recognize_werewolves)
	return ..()


// Ability & Resources //
/datum/storyteller_roll/recognize_werewolves
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 4
	roll_output_type = ROLL_FLAG_ROLLER

/datum/action/cooldown/recognize_werewolves
	name = "Recognize Werewolves"
	desc = "Attempt to discern if someone is a Shifter of your race."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "recognize_werewolves"
	click_to_activate = TRUE
	cooldown_time = 5 SECONDS

	var/datum/weakref/caster_ref
	var/mob/living/caster
	var/mob/living/carbon/human/human_target

	var/static/list/garou_tells = list(
	"seems to unnerve people around them",
	"seems vaguely beastial",
	"looks to be somewhat animalistic",
	"contains a deep-seated rage",
	"looks like they've come out of a jungle",
	"has the smell of a beast",
	"has some specific mannerisms you've seen before",
	)

	var/static/list/corax_tells = list(
	"could talk their mouth off",
	"has been staring at that trinket far too long",
	"never seems to silence",
	"has a notably long ring finger",
	"looks to have a feather caught on them",
	"has some specific mannerisms you've seen before",
	"mentioned something known to you",
	)

	var/static/list/notice_tells = list(
	"has their eyes dead set on you",
	"is concentrating on you",
	"keeps shifting their eyes away when you look",
	"has been paying too much attention to you",
	"keeps passing glances your way",
	)

/datum/action/cooldown/recognize_werewolves/proc/obvious_tells(mob/living/carbon/human/target)
	if (iscrinos(human_target) && !HAS_TRAIT(owner, TRAIT_VEILED))
		to_chat(owner, span_alert("Dear God, I don't need to inspect <b>THAT!<b>"))
	if (iscrinos(human_target) && HAS_TRAIT(owner, TRAIT_VEILED))
		to_chat(owner, span_danger("NO! NO! <b>STAY AWAY!<b>"))
	if (ishispo(human_target))
		to_chat(owner, span_notice("That wolf is far too big to NOT be a Shifter."))
	if (HAS_TRAIT(human_target, TRAIT_WYRMTAINTED_SPRITE) && iscrinos(human_target) || (islupus(human_target) || (ishispo(human_target))))
		to_chat(owner, span_notice("That thing looks... wrong! A Shifter should <b>NOT<b> look like that!"))
	return


// Actual ability stuff //
/datum/action/cooldown/recognize_werewolves/set_click_ability(mob/on_who)
	. = ..()

/datum/action/cooldown/recognize_werewolves/Activate(atom/target)
	human_target = target
	caster = owner
	if (!ishuman(human_target))
		return TRUE
	if (!(target in range(3, caster)))
		to_chat(owner, span_warning("You are too far from [target] to catch the details!"))
		return FALSE
	if (human_target == owner)
		to_chat(owner, span_warning("You can't analyze yourself!"))
		return TRUE

	. = ..()

	// Roll bypass
	if (iscrinos(human_target) || ishispo(human_target))
		on_recognize_use(owner)
		return TRUE

	var/datum/storyteller_roll/recognize_werewolves/recognize_roll = new()
	if (HAS_TRAIT_FROM(human_target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_ref))
		to_chat(owner, span_warning("You can't ascertain anything else from [human_target]; you may re-investigate in a few minutes."))
		return FALSE
	switch (recognize_roll.st_roll(caster, human_target))
		if (ROLL_BOTCH, ROLL_FAILURE)
			to_chat(owner, span_warning("You fail to glean enough information to make a conclusion."))
		if (ROLL_BOTCH)
			target_notice_recognize()
		if (ROLL_SUCCESS)
			on_recognize_use()
	return TRUE

/datum/storyteller_roll/recognize_werewolves/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	var/mob/living/carbon/human/human_target = astype(target)
	if (!human_target)
		return
	if (human_target.is_face_obscured())
		. += 2
	if (HAS_TRAIT(roller, TRAIT_NO_EYE_CONTACT))
		. += 1
	if (HAS_TRAIT(human_target, TRAIT_DIFFICULT_RAGE))
		. -= 2
	if (HAS_TRAIT(human_target, TRAIT_MERIT_UNTAMABLE))
		. -= 2
	if (HAS_TRAIT(human_target, TRAIT_ANIMAL_MUSK))
		. -= 1
	if (isglabro(human_target) && !HAS_TRAIT(human_target, TRAIT_FAIR_GLABRO))
		. -= 5
	if (isglabro(human_target) && HAS_TRAIT(human_target, TRAIT_FAIR_GLABRO))
		. -= 2
	if (roller.is_blind())
		. = 10
	if (HAS_TRAIT(roller, TRAIT_CANNOT_FOCUS))
		. = 20
	return

/datum/storyteller_roll/recognize_werewolves/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	var/perception_level = roller?.st_get_stats(STAT_PERCEPTION)
	if (HAS_TRAIT(roller, TRAIT_ACUTE_HEARING))
		. += 1
	if (perception_level == 5)
		. += 1
	return

/datum/action/cooldown/recognize_werewolves/proc/on_recognize_use(mob/living/carbon/human/target)
	if (get_corax_splat(human_target))
		if (iscrinos(human_target))
			obvious_tells()
			return
		else
			to_chat(owner, span_purple("[human_target] [pick(garou_tells)], they are most certainly a Shifter."))
	if (get_garou_splat(human_target))
		if (iscrinos(human_target) || ishispo(human_target))
			obvious_tells()
			return
		else
			to_chat(owner, span_purple("[human_target] [pick(garou_tells)], they are most certainly a Shifter."))
	else
		to_chat(owner, span_purple("You don't find any of your usual tells in [human_target]."))
	target_notice_recognize(human_target)
	return

/datum/action/cooldown/recognize_werewolves/proc/target_cooldown(mob/living/carbon/human/target)
	if (human_target != owner)
		caster_ref = WEAKREF(owner)
		ADD_TRAIT(human_target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_ref)
		addtimer(TRAIT_CALLBACK_REMOVE(human_target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_ref), 5 MINUTES)


// Does the target notice? //
/datum/storyteller_roll/notice_recognize_werewolves
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 6
	roll_output_type = null

/datum/storyteller_roll/recognize_werewolves/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if (HAS_TRAIT(roller, TRAIT_NO_EYE_CONTACT))
		. += 1
	if (HAS_TRAIT(target, TRAIT_SHIFTY_EYES))
		. -= 1
	if (HAS_TRAIT(roller, TRAIT_CANNOT_FOCUS))
		. = 20
	if (roller.is_blind())
		. = 20
	return

/datum/storyteller_roll/recognize_werewolves/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	var/perception_level = roller?.st_get_stats(STAT_PERCEPTION)
	if (HAS_TRAIT(roller, TRAIT_ACUTE_HEARING))
		. += 1
	if (perception_level == 5)
		. += 1
	if (get_corax_splat(roller)) // Bird up!
		. += 1
	return

/datum/action/cooldown/recognize_werewolves/proc/target_notice_recognize(mob/living/carbon/human/owner)
	var/notice_roll = SSroll.storyteller_roll_datum(owner, roll_datum = /datum/storyteller_roll/notice_recognize_werewolves)
	switch (notice_roll)
		if (ROLL_BOTCH, ROLL_FAILURE)
			return
		if (ROLL_SUCCESS)
			to_chat(owner, span_notice("You notice that [caster] [pick(notice_tells)]."))
			to_chat(caster, span_notice("I think they noticed me..."))


#undef RECOGNIZE_WEREWOLVES_COOLDOWN
