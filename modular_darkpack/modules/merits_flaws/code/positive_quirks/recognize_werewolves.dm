#define RECOGNIZE_WEREWOLVES_COOLDOWN "recognize_werewolves_cooldown"

/datum/quirk/darkpack/recognize_werewolves
	name = "Recognize Werewolves"
	desc = {"Over the years, you've become adept at picking out the Shifters of your
			race in a crowd. Rather than having any kind of mystical awareness, you've
			simply learned what physical and personality traits tend to mark Gaia's children.
			They just stand out to you, once they're undergone the Change. This merit doesn't
			allow you to find cubs on the verge of Firsting (or what have you), but you may
			notice their propensity for violence. You may use attempts of perception to notice which people
			in the room seem to have that special touch of Rage or wildness that could indicate
			they are of your Changing Breed."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 53)
	value = 3
	mob_trait = TRAIT_RECOGNIZE_WEREWOLVES
	gain_text = span_notice("You percieve intricacies about your kin not many would notice.")
	lose_text = span_notice("Your perception dulls, the intuition guiding it is no more.")
	icon = FA_ICON_PAW
	failure_message = "Your perception dulls, the intuition guiding it is no more."
	allowed_splats = list(SPLAT_KINFOLK)

// DARKPACK TODO - Lock to kin type when more than Garou exist.

/datum/quirk/darkpack/recognize_werewolves/add(client/client_source)
	var/datum/action/cooldown/recognize_werewolves/recognize_those_wolves = new()
	recognize_those_wolves.Grant(quirk_holder)

/datum/quirk/darkpack/recognize_werewolves/remove(datum/action/cooldown/recognize_werewolves)
	return ..()


// Ability & Resources
/datum/storyteller_roll/recognize_werewolves
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 5
	roll_output_type = ROLL_FLAG_ROLLER

/datum/action/cooldown/recognize_werewolves
	name = "Recognize Werewolves"
	desc = "Attempt to discern if someone is a Shifter of your race."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "recognize_werewolves"
	cooldown_time = 15 SECONDS

	var/datum/weakref/caster_name
	var/datum/weakref/caster_owner

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
	"keeps passing glances your way"
	)

/datum/action/cooldown/recognize_werewolves/proc/obvious_tells(mob/living/carbon/human/target)
	if (iscrinos(target) && !HAS_TRAIT(owner, TRAIT_VEILED))
		to_chat(owner, span_alert("Dear God, I don't need to inspect <b>THAT!<b>"))
	if (iscrinos(target) && HAS_TRAIT(owner, TRAIT_VEILED))
		to_chat(owner, span_danger("NO! NO! <b>STAY AWAY!<b>"))
	if (ishispo(target))
		to_chat(owner, span_notice("That wolf is far too big to NOT be a Shifter."))
	if (HAS_TRAIT(target, TRAIT_WYRMTAINTED_SPRITE) && iscrinos(target) || (islupus(target) || (ishispo(target))))
		to_chat(owner, span_notice("That thing looks... wrong! A Shifter should <b>NOT<b> look like that!"))
	return


// Actual ability stuff
/datum/action/cooldown/recognize_werewolves/Activate(atom/target)
	. = ..()
	caster_name = owner.name
	var/datum/storyteller_roll/recognize_werewolves/recognize_roll = new()
	if (iscrinos(target) || ishispo(target))
		on_recognize_use(owner)
	else
		if (HAS_TRAIT_FROM(target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_owner))
			to_chat(owner, span_warning("You can't ascertain anything else from [target.name]; you may re-investigate in a few minutes."))
			return FALSE
		switch (recognize_roll.st_roll(owner, target))
			if (ROLL_BOTCH, ROLL_FAILURE)
				to_chat(owner, span_alert("You fail to glean enough information to make a conclusion."))
			if (ROLL_BOTCH)
				target_notice_recognize()
			if (ROLL_SUCCESS)
				on_recognize_use(owner)
	return

/datum/storyteller_roll/recognize_werewolves/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	var/mob/living/carbon/human/human_target = target
	if (roller.is_blind())
		. += 5
	if (human_target.is_face_obscured())
		. += 2
	if(HAS_TRAIT(roller, TRAIT_NO_EYE_CONTACT))
		. += 1
	if(HAS_TRAIT(target, TRAIT_DIFFICULT_RAGE))
		. -= 2
	if(HAS_TRAIT(target, TRAIT_MERIT_UNTAMABLE))
		. -= 2
	if(HAS_TRAIT(target, TRAIT_ANIMAL_MUSK))
		. -= 1
	if(isglabro(target) && !HAS_TRAIT(target, TRAIT_FAIR_GLABRO))
		. -= 5
	if(isglabro(target) && HAS_TRAIT(target, TRAIT_FAIR_GLABRO))
		. -= 2
	if(HAS_TRAIT(roller, TRAIT_CANNOT_FOCUS))
		. = 10

/datum/storyteller_roll/recognize_werewolves/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_ACUTE_HEARING))
		. += 1
	if(roller.st_get_stat(STAT_PERCEPTION) == 5)
		. += 1

/datum/action/cooldown/recognize_werewolves/proc/on_recognize_use(mob/living/carbon/human/target)
	if (target == owner)
		to_chat(owner, span_notice("You can't analyze yourself!"))
		return
	if (get_corax_splat(target))
		if(iscrinos(target))
			obvious_tells()
			return
		else
			to_chat(owner, span_notice("[target.name] [pick(garou_tells)], they are most certainly a Shifter."))
	if (get_garou_splat(target))
		if(iscrinos(target) || ishispo(target))
			obvious_tells()
			return
		else
			to_chat(owner, span_notice("[target.name] [pick(garou_tells)], they are most certainly a Shifter."))
	else
		to_chat(owner, span_notice("You don't find any of your usual tells in [target.name]."))
	target_notice_recognize()
	return

/datum/action/cooldown/recognize_werewolves/proc/target_cooldown(mob/living/carbon/human/target)
	if (target != owner)
		caster_owner = WEAKREF(owner)
		ADD_TRAIT(target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_owner)
		addtimer(TRAIT_CALLBACK_REMOVE(target, RECOGNIZE_WEREWOLVES_COOLDOWN, caster_owner), 2 MINUTES)


// Does the target notice?
/datum/storyteller_roll/notice_recognize_werewolves
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 6
	roll_output_type = null

/datum/storyteller_roll/recognize_werewolves/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_NO_EYE_CONTACT))
		. += 1
	if(HAS_TRAIT(target, TRAIT_SHIFTY_EYES))
		. -= 1
	if(HAS_TRAIT(roller, TRAIT_CANNOT_FOCUS))
		. = 10
	if (roller.is_blind())
		. = 10

/datum/storyteller_roll/recognize_werewolves/using_bonus(mob/living/roller, atom/target, bonus_added)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_ACUTE_HEARING))
		. += 1
	if(roller.st_get_stat(STAT_PERCEPTION) == 5)
		. += 1
	if(get_corax_splat(roller)) // Bird up!
		. += 1

/datum/action/cooldown/recognize_werewolves/proc/target_notice_recognize()
	var/notice_roll = SSroll.storyteller_roll_datum(target, roll_datum = /datum/storyteller_roll/notice_recognize_werewolves)
	switch (notice_roll)
		if (ROLL_BOTCH, ROLL_FAILURE)
			return
		if (ROLL_SUCCESS)
			to_chat(owner, span_notice("You notice that [caster_name] [pick(notice_tells)]."))
			to_chat(caster_name, span_notice("I think they noticed me..."))


#undef RECOGNIZE_WEREWOLVES_COOLDOWN
