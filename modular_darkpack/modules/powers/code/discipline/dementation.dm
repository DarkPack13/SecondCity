/datum/discipline/dementation
	name = "Dementation"
	desc = {"Makes all humans in radius mentally ill for a moment, supressing their defending ability.
● Passion: Charisma + Empathy
●● The Haunting: Manipulation + Subterfuge
●●● Eyes of Chaos: Perception + Occult
●●●● Voice of Madness: Manipulation + Empathy
●●●●● Total Insanity: Manipulation + Intimidation"}
	icon_state = "dementation"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/dementation
	signature_clan = VAMPIRE_CLAN_MALKAVIAN

/datum/discipline/dementation/post_gain()
	. = ..()
	owner.add_quirk(/datum/quirk/darkpack/derangement)

/datum/discipline/dementation/post_loss()
	owner.remove_quirk(/datum/quirk/darkpack/derangement)
	return ..()

/datum/discipline_power/dementation
	name = "Dementation power name"
	desc = "Dementation power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/insanity.ogg'

/datum/discipline_power/dementation/proc/remove_dementation_overlay(mob/living/carbon/human/target)
	target.remove_overlay(POWERS_LAYER)

/*
From V20:
Passion
The vampire stirs his victim’s emotions, either
heightening them to a fevered pitch or blunting them
until the target is completely desensitized. The Cain-
ite may not choose which emotion is affected; she may
only amplify or dull emotions already present in the
target. In this way, a vampire can inflame mild irrita-
tion into quivering rage or atrophy true love into ca-
sual interest.

System: The character talks to their victim, and
the vampire’s player rolls Charisma + Empathy (dif-
ficulty equals the victim’s Humanity or Path rating).
The number of successes determines the duration of
the altered state of feeling. Effects of this power might
include one- or two-point additions or subtractions
to difficulties of frenzy rolls, Virtue rolls, rolls to resist
Presence powers, etc
*/
/datum/discipline_power/dementation/passion
	name = "Passion"
	desc = "Stir the deepest parts of your target to manipulate their psyche. Stuns target."
	level = 1
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7
	multi_activate = TRUE
	cooldown_length = 2 TURNS
	duration_length = 1 TURNS
	vitae_cost = 1
	aggravating = TRUE
	hostile = TRUE
	var/dementation_phrase //will be filled when activated via tgui_input_text

/datum/discipline_power/dementation/passion/pre_activation_checks(mob/living/carbon/human/target)
	//var/theirpower = target.st_get_stat(STAT_MORALITY)
	var/mypower = SSroll.storyteller_roll_datum(owner, applic_stats = list(STAT_CHARISMA, STAT_EMPATHY))
	switch(mypower)
		if(ROLL_FAILURE, ROLL_BOTCH)
			to_chat(owner, span_warning("[target]'s mind is too powerful to influence!"))
			return FALSE
		if(ROLL_SUCCESS)
			dementation_phrase = tgui_input_text(owner, "What will you say to [target] to stir their emotions?")
			if(!dementation_phrase)
				to_chat(owner, span_warning("You must say something to your target to influence their emotions."))
				return FALSE
			return TRUE

/datum/discipline_power/dementation/passion/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(POWERS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/dementation.dmi', "dementation", -POWERS_LAYER)
	dementation_overlay.pixel_z = 1
	target.overlays_standing[POWERS_LAYER] = dementation_overlay
	target.apply_overlay(POWERS_LAYER)
	target.Stun(duration_length)
	target.emote(pick("laugh","scream","cry")) // pick a random emotion for them to experience
	var/attack_text = spooky_font_replace(dementation_phrase) // malk-ify what the attacker said
	owner.say(attack_text, spans = list("bold", "singing")) // the malk speech uses bold and singing spans
	// TODO: when the derangement port is merged, update the sound paths here
	//owner.playsound_local(get_turf(H), pick('sound/items/SitcomLaugh1.ogg', 'sound/items/SitcomLaugh2.ogg', 'sound/items/SitcomLaugh3.ogg'), 100, FALSE)
	if(target.body_position == STANDING_UP)
		target.toggle_resting()

/datum/discipline_power/dementation/passion/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(POWERS_LAYER)


/*
From V20:
The Haunting
The vampire manipulates the sensory centers of their
victim’s brain, flooding the victim’s senses with visions,
sounds, scents, or feelings that aren’t really there. The
images, regardless of the sense to which they appeal,
are only fleeting “glimpses,” barely perceptible to the
victim. The vampire using Dementation cannot con-
trol what the victim perceives, but may choose which
sense is affected.

The “haunting” effects occur mainly when the vic-
tim is alone, and mostly at night. They may take the
form of the subject’s repressed fears, guilty memories,
or anything else that the Storyteller finds dramatically
appropriate. The effects are never pleasant or unobtru-
sive, however. The Storyteller should let her imagina-
tion run wild when describing these sensory impres-
sions; the victim may well feel as if she is going mad, or
as if the world is.

System: After the vampire speaks to the victim, the
player spends a blood point and rolls Manipulation +
Subterfuge (difficulty of his victim’s Perception + Self-
Control/Instinct). The number of successes determines
the length of the sensory “visitations.” The precise ef-
fects are up to the Storyteller, though particularly ee-
rie or harrowing apparitions can certainly reduce dice
pools for a turn or two after the manifestation.
*/
/datum/discipline_power/dementation/the_haunting
	name = "The Haunting"
	desc = "Manipulate your target's senses, making them perceive what isn't there."
	level = 2
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7
	multi_activate = TRUE
	vitae_cost = 1
	cooldown_length = 3 TURNS
	duration_length = 2 TURNS //this determines how long the visual affected overlay will be applied to their mob sprite, not the hallucination duration
	aggravating = TRUE
	hostile = TRUE
	var/mypower
	var/dementation_phrase

/datum/discipline_power/dementation/the_haunting/pre_activation_checks(mob/living/carbon/human/target)
	var/resistence_stat = target.st_get_stat(STAT_SELF_CONTROL)
	if(get_kindred_splat(target))
		resistence_stat = target.st_get_stat(owner.is_enlightenment() ? STAT_CONVICTION : STAT_SELF_CONTROL)
	if(HAS_TRAIT(target, TRAIT_IRON_WILL))
		resistence_stat += 3
	var/theirpower = target.st_get_stat(STAT_PERCEPTION) + resistence_stat
	mypower = SSroll.storyteller_roll_datum(owner, difficulty = theirpower, applic_stats = list(STAT_MANIPULATION, STAT_SUBTERFUGE), numerical = TRUE)
	if(mypower <= 0)
		to_chat(owner, span_warning("[target]'s mind is too powerful to influence!"))
		return FALSE
	dementation_phrase = tgui_input_text(owner, "What will you say to [target] to haunt them?")
	if(!dementation_phrase)
		to_chat(owner, span_warning("You must say something to your target to haunt them."))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/the_haunting/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(POWERS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/dementation.dmi', "dementation", -POWERS_LAYER)
	dementation_overlay.pixel_z = 1
	target.overlays_standing[POWERS_LAYER] = dementation_overlay
	target.apply_overlay(POWERS_LAYER)
	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/delusion/preset), \
			"the haunting", \
			duration = 1 TURNS + (mypower SECONDS), \
			affects_us = FALSE, \
			affects_others = TRUE, \
			skip_nearby = FALSE, \
		)
	var/attack_text = spooky_font_replace(dementation_phrase)
	owner.say(attack_text, spans = list("bold", "singing"))

/datum/discipline_power/dementation/the_haunting/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(POWERS_LAYER)

/*
From V20:
Eyes of Chaos
This peculiar power allows the vampire to take ad-
vantage of the fleeting clarity hidden in insanity. She
may scrutinize the “patterns” of a person’s soul, the
convolutions of a vampire’s inner nature, or even ran-
dom events in nature itself. The Kindred with this
power can discern the most well-hidden psychoses, or
gain insight into a person’s true self. Malkavians with
this power often have (or claim to have) knowledge of
the moves and countermoves of the great Jyhad, or the
patterns of fate.

System: This power allows a vampire to determine a
person’s true Nature, among other things. The vampire
concentrates for a turn, then her player rolls Perception
+ Occult. The difficulty depends on the intricacy of the
pattern. Discerning the Nature of a stranger would be
difficulty 9, a casual acquaintance would be an 8, and
an established ally a 6. The vampire could also read
the message locked in a coded missive (difficulty 7), or
even see the doings of an invisible hand in such events
as the pattern of falling leaves (difficulty 6). Almost
anything might contain some hidden insight, no mat-
ter how trivial or meaningless. The patterns are pres-
ent in most things, but are often so intricate they can
keep a vampire spellbound for hours while she tries to
understand their message.

This is a potent power, subject to adjudication. Sto-
rytellers, this power is an effective way to introduce
plot threads for a chronicle, reveal an overlooked clue,
foreshadow important events, or communicate critical
149VAMPIRE THE MASQUERADE 20th ANNIVERSARY EDITION
information a player seeks. Important to its use, though,
is delivering the information properly. Secrets revealed
via Eyes of Chaos are never simple facts; they’re tanta-
lizing symbols adrift in a sea of madness. Describe the
results of this power in terms of allegory: “The man
before you appears as a crude marionette, with garish
features painted in bright stage makeup, and strings
vanishing up into the night sky.” Avoid stating plainly,
“You learn that this ghoul is the minion of a powerful
Methuselah.”
*/
/datum/discipline_power/dementation/eyes_of_chaos
	name = "Eyes of Chaos"
	desc = "See the hidden patterns in the world and uncover people's true selves."
	level = 3
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7
	multi_activate = TRUE
	cooldown_length = 2 TURNS
	duration_length = 1 TURNS
	activate_sound = null // dont play a sound
	vitae_cost = 1
	var/list/choice_options = list("Secrets", "Information",)
	var/datum/tgui_window/eyes_of_chaos_window

/datum/discipline_power/dementation/eyes_of_chaos/proc/update_choices()
	for(var/i in choice_options)
		choice_options[i] = icon('icons/effects/effects.dmi', "quantum_sparks")

/datum/discipline_power/dementation/eyes_of_chaos/proc/open_chaos_eyes_window(mob/living/carbon/human/target)
	var/exploitable_information = sanitize_text(target.client?.prefs.read_preference(/datum/preference/text/exploitable))
	if(exploitable_information == EXPLOITABLE_DEFAULT_TEXT) //they havent set exploitable text
		exploitable_information = "You do not manage to uncover any secrets."
	to_chat(owner, span_notice("You search [target]'s mind... [exploitable_information]"))


/datum/discipline_power/dementation/eyes_of_chaos/proc/display_select_menu(mob/living/carbon/human/target)
	update_choices()
	var/chosen_option = show_radial_menu(owner, target, choice_options, target, radius = 36, tooltips = TRUE)
	if(!chosen_option)
		return FALSE
	if(!do_after(owner, 2 TURNS))
		return FALSE

#define OPTION_IMMORTAL_AGE "Immortal Age"
#define OPTION_BIOLOGICAL_AGE "Biological Age"
#define OPTION_CLAN "Clan"
#define OPTION_TRIBE "Tribe"
#define OPTION_DISCIPLINES "Disciplines"
#define OPTION_BRAIN_TRAUMA "Brain Trauma"
#define OPTION_MORALITY_PATH "Morality Path"
#define OPTION_HUMANITY "Humanity"
#define OPTION_BLOOD_BONDED "Blood Bonded" // Mentions Unbondable too
#define OPTION_INFLUENCED "Influenced" // Any power that would control, influence or coerce someone
#define OPTION_SECOND_PRESENCE "Second Presence" // Split Personality or Imaginary Friend, might need to alter Brain Trauma to account.
#define OPTION_DIABLERIE "Diablerie"
#define OPTION_COUNTRY_OF_ORIGIN "Country of Origin"
#define OPTION_WYRM_TAINTED "Wyrm-Taint" // Tainted forms and trait, maybe vampires inherently per lore?
#define OPTION_WILLPOWER "Permanent Willpower"
#define OPTION_SPLAT "Splat"
#define OPTION_BREED "Breed"
#define OPTION_GENERATION "Vampire Generation"
#define OPTION_EMOTION "Aura Emotion"
#define OPTION_CHARACTER_NAME "Character Name"
#define OPTION_KINDRED_SIRE "Sire" // Only for those who were embraced in a round
#define OPTION_NULL "Empty"
// Perhaps note 5-dotted stats and certain traits, inherent traits like Salubri eyes?

	// Checks the splat of the target
	var/list/datum/splat/target_splat = target.splats[1]
	var/target_vampire = (istype(target_splat, /datum/splat/vampire/kindred))
	var/target_ghoul = (istype(target_splat, /datum/splat/vampire/ghoul))
	var/target_garou = (istype(target_splat, /datum/splat/werewolf/shifter/garou))

	// Variables that rely on the target being a specific splat should be pre-defined here as OPTION_NULL
	var/datum/splat/vampire/discipline_splat = OPTION_NULL
	var/datum/action/discipline/target_disciplines = OPTION_NULL
	var/datum/subsplat/werewolf/target_breed = OPTION_NULL
	var/datum/subsplat/vampire_clan/target_clan = OPTION_NULL
	var/datum/subsplat/werewolf/target_tribe = OPTION_NULL
	var/target_morality_path = OPTION_NULL
	// Variables that rely on the target having a client or preferences should also do this
	var/target_immortal_age = OPTION_NULL
	var/target_country_of_origin = OPTION_NULL
	var/target_state_of_origin = OPTION_NULL
	var/target_true_name = OPTION_NULL

	// Redefine variables from OPTION_NULL only if the target is a splat that would have the listed options to prevent null errors
	if(target_vampire)
		discipline_splat = get_vampire_splat(target) // Get a vampire's/ghoul's Splat -> Disciplines
		target_disciplines = pick(discipline_splat.powers) // Ditto ^
		target_morality_path = get_morality_path(target) // Get Morality path
		target_clan = target.get_clan() // Get Clan
	if(target_ghoul)
		discipline_splat = get_vampire_splat(target) // Get a vampire's/ghoul's Splat -> Disciplines
		target_disciplines = pick(discipline_splat.powers) // Ditto ^
	if(target_garou)
		target_breed = target.get_our_breed_form() // Get Shifter Breed
		target_tribe = target.get_our_tribe() // Get Tribe
	if(target.client?.prefs)
		target_country_of_origin = target?.client?.prefs.read_preference(/datum/preference/choiced/country_of_origin) // Get Country of Origin
		target_state_of_origin = target?.client?.prefs.read_preference(/datum/preference/choiced/state_of_origin) // Get State of Origin
		target_true_name = target?.client?.prefs.read_preference(/datum/preference/name/real_name) // Get Character's Set Name
	if(target.client?.prefs && target_vampire) // (Literally just for Immortal Age)
		target_immortal_age = target?.client?.prefs.read_preference(/datum/preference/numeric/immortal_age) // Get Immortal Age
	//var/datum/splat/vampire/kindred/sire_splat = get_kindred_splat(target) // Get vampire's Sire
	//var/mob/living/target_sire = target.sire

	// Add options to the master list if conditions are met. "Information" will draw from "available_options".
	var/list/available_options = list(OPTION_BIOLOGICAL_AGE, OPTION_WILLPOWER, OPTION_SPLAT, OPTION_EMOTION)
	if(target_vampire) // Add available options if target is a Vampire
		available_options += list(OPTION_DISCIPLINES, OPTION_GENERATION, OPTION_MORALITY_PATH, OPTION_HUMANITY, OPTION_CLAN, OPTION_IMMORTAL_AGE)
	if(target_ghoul) // Add available options if target is a Ghoul
		available_options += list(OPTION_DISCIPLINES)
	if(target_garou) // Add available options if target is a Garou
		available_options += list(OPTION_TRIBE)
	if(target.client?.prefs)
		available_options += list(OPTION_COUNTRY_OF_ORIGIN, OPTION_CHARACTER_NAME)
	if(target.client?.prefs && target_vampire) // (Literally just for Immortal Age)
		available_options += list(OPTION_IMMORTAL_AGE)
	if(HAS_TRAIT(target, TRAIT_POSSIBLE_WYRM) || (istype(target_splat, /datum/splat/vampire/kindred) && (target.st_get_stat(STAT_MORALITY) <= 7))) // Add available options if target is Wyrm-Tainted or a vampire at humanity 7 and below
		available_options += list(OPTION_WYRM_TAINTED)
	if(length(target.get_traumas()))
		available_options += list(OPTION_BRAIN_TRAUMA)
	if(HAS_TRAIT(target, TRAIT_DIABLERIE)) // Add available options if target has commited Diablerie
		available_options += list(OPTION_DIABLERIE)
	if(target.mind.enslaved_to) // Add available options in the presence of a blood bond or related trait if(/datum/status_effect/blood_bond, target)
		available_options += list(OPTION_BLOOD_BONDED)

	switch(chosen_option)
		if("Secrets")
			open_chaos_eyes_window(target)
		if("Information")
			var/list/selected_options = list()
			for(var/i in 1 to 3)
				selected_options += pick_n_take(available_options) // Doesn't consistently pick 3, look at (Also rewrite the text of some placeholders below)
			for(var/option in selected_options)
				switch(option)
					if(OPTION_IMMORTAL_AGE)
						var/target_immortal_age = target?.client?.prefs.read_preference(/datum/preference/numeric/immortal_age) // Get Immortal Age
						var/determined_age = "This fledgling has just been thrust into this new world, the pitiable thing is not even past their first year."
						if(target_immortal_age < 100)
							determined_age = "[target] has barely lived their first lifetime."
						else if(target_immortal_age < 200)
							determined_age = "[target] is in their second century."
						else
							determined_age = "[target] bears the crushing burden of time."
						owner.malkavian_voices("[determined_age]", range=4)
					if(OPTION_BIOLOGICAL_AGE)
						var/biologicalage = target.age
						owner.malkavian_voices("The body of [target] looks to have [biologicalage] years to it.", range=4)
					if(OPTION_CLAN)
						owner.malkavian_voices("[target]'s bloodline is of [target_clan.name] descent", range=4)
					if(OPTION_TRIBE)
						owner.malkavian_voices("[target] heart belongs to the [target_tribe.name]", range=4)
					if(OPTION_DISCIPLINES)
						var/selected_discipline = target_disciplines.discipline // Pick a discipline.  // ENSURE BLOODHEAL IS NOT AN OPTION and account for no disciplines somehow
						//if(selected_discipline = null)
							//owner.malkavian_voices("The bounty of [target]'s clan bears no fruit! Devoid of substance!", range=4)
						owner.malkavian_voices("[selected_discipline]", range=4)
					if(OPTION_BRAIN_TRAUMA)
						var/list/traumas = target.get_traumas() // Add available options if target has brain trauma(s)
						var/datum/brain_trauma/selected_trauma = pick(traumas) // Pick a trauma from the target.
						var/trauma_name = selected_trauma.scan_desc
						if(istype(selected_trauma, BRAIN_TRAUMA_MILD))
							owner.malkavian_voices("The rivers of [target]'s mind has branched off into a [trauma_name].", range=4)
						else if(istype(selected_trauma, BRAIN_TRAUMA_SEVERE))
							owner.malkavian_voices("The brain of [target] has [trauma_name] violently weeping from its folds.", range=4)
						else if(istype(selected_trauma, BRAIN_TRAUMA_MAGIC))
							owner.malkavian_voices("[target]'s grey matter has [trauma_name] twinkling something most consider abberant.", range=4)
						else if(istype(selected_trauma, BRAIN_TRAUMA_SPECIAL))
							owner.malkavian_voices("How did [target]'s brain ever become so riddled with [trauma_name]? This can't be?", range=4)
					if(OPTION_GENERATION)
						switch(target.get_generation())
							if(-INFINITY to 15)
								owner.malkavian_voices("Removed further than the stars themselves; our lineage thins in this one.", range=4)
							if(14)
								owner.malkavian_voices("The drought of potency narrowly avoids [target], or does it?", range=4)
							if(13,12)
								owner.malkavian_voices("[target]'s blood hails from ever-distant relatives. A middling generation.", range=4)
							if(11,10)
								owner.malkavian_voices("[target] still has the blood of our ancestors pulsing in their veins.", range=4)
							if(9,8)
								owner.malkavian_voices("Veins seeping power, the blood of [target] flows strongly with the essence of Caine.", range=4)
							if(7 to 1)
								owner.malkavian_voices("The sheer potency of [target]'s blood is far beyond that seen in the cities of man!", range=4)
					if(OPTION_MORALITY_PATH)
						owner.malkavian_voices("Their beast's incessant cravings are tamed by the [target_morality_path]", range=4)
					if(OPTION_DIABLERIE)
						owner.malkavian_voices("[target]'s soul is marked with a grave sin. Stolen essence is devoured within — veins of tar supplying the scourge it inhabits.", range=4)
					if(OPTION_HUMANITY)
						switch(target.st_get_stat(STAT_MORALITY)) // Grab humanity value
							if(0)
								owner.malkavian_voices("Drooling, gnawing, aching. An emaciated body gorged with stolen life breaks its mind in starvation.", range=4) // Wight
							if(1)
								owner.malkavian_voices("[target] is savagely hounded by their beast, one moment away from plunging into the brink of madness", range=4)
							if(2,3)
								owner.malkavian_voices("The beast pounds the mind of [target] day after day; demands ever-made to their perversion of humanity with nary a reprive.", range=4)
							if(4,5)
								owner.malkavian_voices("The reality of undeath has long since sunken in comfortably for [target]. After all, a predator pays no mind to the thought of its prey.", range=4)
							if(6)
								owner.malkavian_voices("That's that, and this is this. This kindred isn't quite beast, yet not much closer to a human either.", range=4)
							if(7)
								owner.malkavian_voices("Stability of the self, [target] manages a connection with their former humanity comparable to the kine they're long since divorced from.", range=4)
							if(8)
								owner.malkavian_voices("[target] yearns to stay close to a concept long since divorced; careful practice keeps this one close to humanity.", range=4)
							if(9)
								owner.malkavian_voices("The bleeding heart of [target] weeps for the sins their kind inflicts. A moral pariah to most of Kindred society.", range=4)
							if(10)
								owner.malkavian_voices("A fragile state of grace held above a pillar to the Heavens; [target] is a saint even amongst the living. Even then, the fragile foundation of principles ever-demand attention", range=4)
					if(OPTION_BLOOD_BONDED)
						owner.malkavian_voices("Chains interlock [target]'s blood — binding them to another. the call of [target.mind.enslaved_to] beckons them in some way or form.", range=4)
					if(OPTION_WYRM_TAINTED)
						if((istype(target_splat, /datum/splat/vampire/kindred)) & (HAS_TRAIT(target, TRAIT_HIDDEN_WYRMTAINT))) // if Vampire with hidden Wyrmtaint
							owner.malkavian_voices("A faint glimmer of decay is embracing [target].", range=4)
						else if(istype(target_splat, /datum/splat/vampire/kindred)) // Vampire with no Hidden Wyrmtaint
							owner.malkavian_voices("The beast of this vampire still gnaws at some recess of their mind, an entropic taint is noticable.", range=4)
						else if((HAS_TRAIT(target, TRAIT_WYRMTAINTED_SPRITE))) // Physically appears Wyrmtainted and not a vampire
							owner.malkavian_voices("The taint of the Wyrm malforms [target]'s body and mind into a cruel mockery of nature.", range=4)
						else // Is tainted by the Wyrm and not a vampire
							owner.malkavian_voices("The taint of the Wyrm harshly defiles [target]'s very being.", range=4)


				//sleep(2 SECONDS) // make into proper timer function that's not sleep
				// ensure you can't resist your own mind

#undef OPTION_IMMORTAL_AGE
#undef OPTION_BIOLOGICAL_AGE
#undef OPTION_CLAN
#undef OPTION_TRIBE
#undef OPTION_DISCIPLINES
#undef OPTION_BRAIN_TRAUMA
#undef OPTION_MORALITY_PATH
#undef OPTION_HUMANITY
#undef OPTION_BLOOD_BONDED
#undef OPTION_INFLUENCED
#undef OPTION_SECOND_PRESENCE
#undef OPTION_DIABLERIE
#undef OPTION_COUNTRY_OF_ORIGIN
#undef OPTION_WYRM_TAINTED
#undef OPTION_WILLPOWER
#undef OPTION_SPLAT
#undef OPTION_BREED
#undef OPTION_GENERATION
#undef OPTION_EMOTION
#undef OPTION_CHARACTER_NAME
#undef OPTION_KINDRED_SIRE
#undef OPTION_NULL

/datum/discipline_power/dementation/eyes_of_chaos/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = SSroll.storyteller_roll_datum(owner, target, difficulty = 7, applic_stats = list(STAT_PERCEPTION, STAT_OCCULT), numerical = FALSE)
	switch(mypower)
		if(ROLL_SUCCESS)
			return TRUE
		if(ROLL_FAILURE, ROLL_BOTCH)
			to_chat(owner, span_warning("[target]'s mind resists you!"))
			return FALSE

/datum/discipline_power/dementation/eyes_of_chaos/activate(mob/living/carbon/human/target)
	. = ..()
	display_select_menu(target)

/*
From V20:
Voice of Madness
By merely addressing their victims aloud, the Kindred
can drive targets into fits of blind rage or fear, forcing
them to abandon reason and higher thought. Victims
are plagued by hallucinations of their subconscious de-
mons, and try to flee or destroy their hidden shames.
Tragedy almost always follows in the wake of this pow-
er’s use, though offending Malkavians often claim that
they were merely encouraging people to act “according
to their natures.” Unfortunately for the vampire con-
cerned, he runs a very real risk of falling prey to their
own voice’s power.

System: The player spends a blood point and makes
a Manipulation + Empathy roll (difficulty 7). One tar-
get is affected per success, although all potential vic-
tims must be listening to the vampire’s voice.
Affected victims fly immediately into frenzy or a
blind fear like Rötschreck. Kindred or other creatures
capable of frenzy, such as Lupines, may make a frenzy
check or Rötschreck test (Storyteller’s choice as to how
they are affected) at +2 difficulty to resist the power.
Mortals are automatically affected and don’t remember
their actions while berserk. The frenzy or fear lasts for
a scene, though vampires and Lupines may test as usual
to snap out of it.

The vampire using Voice of Madness must also test
for frenzy or Rötschreck upon invoking this power,
though his difficulty to resist is one lower than nor-
mal. If the initial roll to invoke this power is a failure,
however, the roll to resist the frenzy is one higher than
normal. If the roll to invoke this power is a botch, the
frenzy or Rötschreck response is automatic.
*/

/datum/discipline_power/dementation/voice_of_madness
	name = "Voice of Madness"
	desc = "Your voice becomes a source of utter insanity, affecting you and all those around you."
	level = 4
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = NONE
	range = 8
	vitae_cost = 1
	multi_activate = TRUE
	cooldown_length = 5 TURNS
	duration_length = 2 TURNS
	hostile = TRUE
	aggravating = TRUE
	violates_masquerade = TRUE
	var/dementation_phrase
	var/successes


// DARKPACK TODO - frenzy. this power requires it

/*
Affected victims fly immediately into frenzy or a
blind fear like Rötschreck. Kindred or other creatures
capable of frenzy, such as Lupines, may make a frenzy
check or Rötschreck test (Storyteller’s choice as to how
they are affected) at +2 difficulty to resist the power.


The vampire using Voice of Madness must also test
for frenzy or Rötschreck upon invoking this power,
though his difficulty to resist is one lower than normal. If the initial roll to invoke this power is a failure,
however, the roll to resist the frenzy is one higher than
normal. If the roll to invoke this power is a botch, the
frenzy or Rötschreck response is automatic.
*/
/datum/discipline_power/dementation/voice_of_madness/pre_activation_checks(mob/living/target)
	successes = SSroll.storyteller_roll_datum(owner, difficulty = 7, applic_stats = list(STAT_MANIPULATION, STAT_EMPATHY), numerical = TRUE)
	if(successes >= 0)
		dementation_phrase = tgui_input_text(owner, "What will you say to cause people nearby to flee?")
		if(!dementation_phrase)
			to_chat(owner, span_warning("You must say something to use this discipline."))
			return FALSE
		return TRUE
	if(successes <= 0) // failure or botch, see above comment
		return FALSE



/datum/discipline_power/dementation/voice_of_madness/activate(mob/living/carbon/human/target)
	. = ..()
	var/attack_text = spooky_font_replace(dementation_phrase)
	owner.say(attack_text, spans = list("bold", "singing"))
	var/list/potential_targets = list()
	for(var/mob/living/carbon/human/hearer in (get_hearers_in_view(8, owner) - owner))
		if(HAS_TRAIT(hearer, TRAIT_DEAF) || IS_UNCONSCIOUS_OR_CRIT(hearer))
			continue
		potential_targets += hearer
	var/targets_affected = 0
	while(targets_affected < successes && length(potential_targets)) //affects one target per success
		var/mob/living/carbon/human/chosen = pick(potential_targets)
		potential_targets -= chosen
		targets_affected++
		chosen.emote("scream")
		GLOB.move_manager.move_away(moving = chosen, chasing = owner, max_dist = 10, timeout = (duration_length * 2), delay = chosen.cached_multiplicative_slowdown)

		chosen.remove_overlay(POWERS_LAYER)
		var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/dementation.dmi', "dementation", -POWERS_LAYER)
		dementation_overlay.pixel_z = 1
		chosen.overlays_standing[POWERS_LAYER] = dementation_overlay
		chosen.apply_overlay(POWERS_LAYER)
		addtimer(CALLBACK(src, PROC_REF(remove_dementation_overlay), chosen), duration_length)

/*
From V20:
Total Insanity
The vampire coaxes the madness from the deepest
recesses of their target’s mind, focusing it into an over-
whelming wave of insanity. This power has driven
countless victims, vampire and mortal alike, to unfor-
tunate ends.

System: The Kindred must gain their target’s undi-
vided attention for at least one full turn to enact this
power. The player spends a blood point and rolls Ma-
nipulation + Intimidation (difficulty of their victim’s
current Willpower points). If the roll is successful, the
victim is afflicted with five derangements of the Sto-
ryteller’s choice (see p. 290). The number of successes
determines the duration.
*/
//TOTAL INSANITY
/datum/discipline_power/dementation/total_insanity
	name = "Total Insanity"
	desc = "Bring out the darkest parts of a person's psyche, bringing them to utter insanity."
	level = 5
	vitae_cost = 1
	check_flags = DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN
	range = 7
	multi_activate = TRUE
	cooldown_length = 5 TURNS
	duration_length = 3 TURNS
	aggravating = TRUE
	hostile = TRUE
	var/mypower
	var/theirpower
	var/mob/living/carbon/human/attack_target

/datum/discipline_power/dementation/total_insanity/pre_activation_checks(mob/living/carbon/human/target)
	theirpower = target.st_get_stat(STAT_TEMPORARY_WILLPOWER)
	if(HAS_TRAIT(target, TRAIT_IRON_WILL))
		theirpower += 3
	if(HAS_TRAIT(owner, TRAIT_ENCHANTING_VOICE))
		theirpower -= 2
	mypower = SSroll.storyteller_roll_datum(owner, difficulty = theirpower, applic_stats = list(STAT_MANIPULATION, STAT_INTIMIDATION), numerical = TRUE)
	if(mypower <= 0)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/total_insanity/proc/self_attack(iteration)
	if(IS_UNCONSCIOUS_OR_CRIT(attack_target))
		return
	if(iteration <= 0)
		return
	attack_target.set_combat_mode(TRUE)
	var/obj/item/held_item = attack_target.get_active_held_item()
	if(held_item?.force)
		attack_target.ClickOn(attack_target)
	else
		if(held_item)
			attack_target.drop_all_held_items()
		attack_target.ClickOn(attack_target)
	addtimer(CALLBACK(src, PROC_REF(self_attack), iteration - 1), 1 SECONDS)

/datum/discipline_power/dementation/total_insanity/activate(mob/living/carbon/human/target)
	. = ..()
	attack_target = target
	attack_target.remove_overlay(POWERS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/dementation.dmi', "dementation", -POWERS_LAYER)
	dementation_overlay.pixel_z = 1
	attack_target.overlays_standing[POWERS_LAYER] = dementation_overlay
	attack_target.apply_overlay(POWERS_LAYER)

	addtimer(CALLBACK(src, PROC_REF(self_attack), max(mypower)), 0) // attack_target will attack themselves n times equaling the caster's manipulation + intimidation subtracted by the attack_target's willpower
	attack_target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/delusion/preset), \
			"total insanity", \
			duration = duration_length + (mypower SECONDS), \
			affects_us = FALSE, \
			affects_others = TRUE, \
			skip_nearby = FALSE, \
		)
	addtimer(CALLBACK(src, PROC_REF(remove_dementation_overlay), attack_target), duration_length + (mypower SECONDS))
