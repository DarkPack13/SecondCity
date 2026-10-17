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
#define OPTION_SECOND_PRESENCE "Second Presence" // Split Personality or Imaginary Friend
#define OPTION_DIABLERIE "Diablerie"
#define OPTION_COUNTRY_OF_ORIGIN "Country of Origin"
#define OPTION_WYRM_TAINTED "Wyrm-Taint" // Tainted forms and trait, maybe vampires inherently per lore?
#define OPTION_WILLPOWER "Permanent Willpower"
#define OPTION_SPLAT "Splat"
#define OPTION_BREED "Breed"
#define OPTION_GENERATION "Vampire Generation"
#define OPTION_EMOTION "Aura Emotion"
#define OPTION_CHARACTER_NAME "Character Name"
#define OPTION_AUSPICE "Auspice"
// Perhaps note 5-dotted stats and certain traits, inherent traits like Salubri eyes?
// Move defines soon

	// Add options to the master list if conditions are met. "Information" will draw from "available_options".
	var/list/available_options = list(OPTION_BIOLOGICAL_AGE, OPTION_WILLPOWER, OPTION_SPLAT)
	if (get_kindred_splat(target)) // Add available options if target is a Vampire
		available_options += list(OPTION_GENERATION, OPTION_MORALITY_PATH, OPTION_HUMANITY, OPTION_CLAN)
	//if (get_ghoul_splat(target)) // Add available options if target is a Ghoul
	//	available_options += list()
	if (get_garou_splat(target)) // Add available options if target is a Garou
		available_options += list(OPTION_TRIBE, OPTION_BREED, OPTION_AUSPICE)
	if (target.client?.prefs) // Add available options if target has preferences (avoids issues with NPCs)
		available_options += list(OPTION_COUNTRY_OF_ORIGIN, OPTION_CHARACTER_NAME)
	if (target.client?.prefs && get_kindred_splat(target)) // (Literally just for Immortal Age)
		available_options += list(OPTION_IMMORTAL_AGE)
	if (HAS_TRAIT(target, TRAIT_POSSIBLE_WYRM) || (get_kindred_splat(target)) && (target.st_get_stat(STAT_MORALITY) <= 7)) // Add available options if target is Wyrm-Tainted or a vampire at humanity 7 and below
		available_options += list(OPTION_WYRM_TAINTED)
	if (length(target.get_traumas())) // Add available options if target has brain trauma(s)
		if (target.has_trauma_type(/datum/brain_trauma/severe/split_personality) || (target.has_trauma_type(/datum/brain_trauma/special/imaginary_friend)))
			available_options += list(OPTION_SECOND_PRESENCE) // Split Personality / Imaginary Friend
		else
			available_options += list(OPTION_BRAIN_TRAUMA)
	if (HAS_TRAIT(target, TRAIT_DIABLERIE)) // Add available options if target has commited Diablerie
		available_options += list(OPTION_DIABLERIE)
	if (target.has_status_effect(/datum/status_effect/blood_bond) || (HAS_TRAIT(target, TRAIT_UNBONDABLE))) // Add available options in the presence of a blood bond or related trait
		available_options += list(OPTION_BLOOD_BONDED)
	if (target.current_emotion != AURA_INNOCENT) // Add available options if emotion has been changed from its initial setting
		available_options += list(OPTION_EMOTION)
	//if (target.possessed == true) || (HAS_TRAIT(target, TRAIT_FORCED_EMOTION) || target.conditioner)

	switch (chosen_option)
		if ("Secrets")
			open_chaos_eyes_window(target)
		if ("Information")
			var/list/selected_options = list()
			for (var/i in 1 to 15)
				selected_options += pick_n_take(available_options)
			for (var/option in selected_options)
				switch (option)
					if (OPTION_IMMORTAL_AGE)
						var/target_immortal_age = target?.client?.prefs.read_preference(/datum/preference/numeric/immortal_age) // Get Immortal Age
						var/determined_age = "This fledgling has just been thrust into this new world; the pitiable thing is not even past their first year."
						if (target_immortal_age < 100)
							determined_age = "[target] has surpassed their first mortal lifetime."
						else if (target_immortal_age < 200)
							determined_age = "The normality of time has fully fractured. [target] has far exceeded a mortal's lifespan."
						else
							determined_age = "The crushing weight of time is held up by [target]. Further burdened with each passing decade."
						owner.malkavian_voices("[determined_age]", range=4)
					if (OPTION_BIOLOGICAL_AGE)
						owner.malkavian_voices("We can count [target.age] marks on this one's shell. Each one embedded with many stories to tell.", range=4)
					if (OPTION_CLAN)
						owner.malkavian_voices("Blood is thicker than water in this world; the [target.get_clan()] lineage seems to have made [target] their own.", range=4)
					if (OPTION_TRIBE)
						if (target.get_our_tribe(/datum/subsplat/werewolf/tribe/garou/blackspiraldancers))
							owner.malkavian_voices("[target] has peered into the spiraling abyss; coming back changed, twisted... Yet craving more. The madness they've lost themselves to may even outshine ours", range=4)
						else
							owner.malkavian_voices("[target] has found their pack within the [target.get_our_tribe()].", range=4) // Rewrite text after feedback from Garou players
					if (OPTION_DISCIPLINES)
						/*var/datum/splat/vampire/discipline_splat = get_vampire_splat(target) // Get a Vampire's/Ghoul's Splat -> Disciplines
						var/list/discipline_filtered_list = list()
						for (var/list/individual_disciplines in discipline_splat.powers) // We don't want Bloodheal, filters it out
							if (istype(individual_disciplines, /datum/discipline_power/bloodheal))
								continue
							discipline_filtered_list += individual_disciplines // Ensure everything but Bloodheal makes it to the filtered list
						var/datum/action/discipline/target_disciplines = pick(discipline_filtered_list) // Pick from the filtered list
						if (target_disciplines == null)
							owner.malkavian_voices("The bounty of [target]'s clan bears no fruit! Devoid of substance!", range=4)
						else
							owner.malkavian_voices("Much knowledge is embedded within this fiend of blood. [target_disciplines.discipline] is but one gift of blood bestowoed upon them.", range=4)*/
						var/list/traumas = target.get_traumas()
						var/datum/brain_trauma/selected_trauma = pick(traumas) // Pick a trauma from the target.
						var/trauma_name = selected_trauma.scan_desc
						if (istype(selected_trauma, BRAIN_TRAUMA_MILD))
							owner.malkavian_voices("The rivers of [target]'s mind has branched off into a [trauma_name].", range=4)
						else if (istype(selected_trauma, BRAIN_TRAUMA_SEVERE))
							owner.malkavian_voices("The brain of [target] has [trauma_name] violently weeping from its folds.", range=4)
						else if (istype(selected_trauma, BRAIN_TRAUMA_MAGIC))
							owner.malkavian_voices("[target]'s grey matter has [trauma_name] twinkling something most consider abberant.", range=4)
						else if (istype(selected_trauma, BRAIN_TRAUMA_SPECIAL))
							owner.malkavian_voices("How did [target]'s brain ever become so riddled with [trauma_name]? This can't be?", range=4)
					if (OPTION_GENERATION)
						switch (target.get_generation())
							if (1 to 7)
								owner.malkavian_voices("The sheer potency of [target]'s blood is far beyond that seen in the cities of man!", range=4)
							if (8,9)
								owner.malkavian_voices("Veins seeping power, the blood of [target] flows strongly with the essence of Caine.", range=4)
							if (10,11)
								owner.malkavian_voices("[target] still has the blood of our ancestors pulsing in their veins.", range=4)
							if (12,13)
								owner.malkavian_voices("[target]'s blood hails from ever-distant relatives. A middling generation.", range=4)
							if (14)
								owner.malkavian_voices("The drought of potency narrowly avoids [target], or does it?", range=4)
							if (15 to INFINITY)
								owner.malkavian_voices("Removed further than the stars themselves; our lineage thins in this one.", range=4)
					if (OPTION_MORALITY_PATH)
						owner.malkavian_voices("Their beast's incessant cravings are tamed by the [get_morality_path(target)]", range=4)
					if (OPTION_DIABLERIE)
						owner.malkavian_voices("[target]'s soul is marked with a grave sin. Stolen essence is devoured within — veins of tar supplying the scourge it inhabits.", range=4)
					if (OPTION_HUMANITY)
						switch (target.st_get_stat(STAT_MORALITY)) // STAT_MORALITY = Humanity
							if (0)
								owner.malkavian_voices("Drooling, gnawing, aching. An emaciated body gorged with stolen life breaks its mind in starvation.", range=4) // Wight
							if (1)
								owner.malkavian_voices("[target] is savagely hounded by their beast, one moment away from plunging into the brink of madness", range=4)
							if (2,3)
								owner.malkavian_voices("The beast pounds the mind of [target] day after day; demands ever-made to their perversion of humanity with nary a reprive.", range=4)
							if (4,5)
								owner.malkavian_voices("The reality of undeath has long since sunken in comfortably for [target]. After all, a predator pays no mind to the thought of its prey.", range=4)
							if (6)
								owner.malkavian_voices("That's that, and this is this. This kindred isn't quite beast, yet not much closer to a human either.", range=4)
							if (7)
								owner.malkavian_voices("Stability of the self, [target] manages a connection with their former humanity comparable to the kine they're long since divorced from.", range=4)
							if (8)
								owner.malkavian_voices("[target] yearns to stay close to a concept long since divorced; careful practice keeps this one close to humanity.", range=4)
							if (9)
								owner.malkavian_voices("The bleeding heart of [target] weeps for the sins their kind inflicts. A moral pariah to most of Kindred society.", range=4)
							if (10)
								owner.malkavian_voices("A fragile state of grace held above a pillar to the Heavens; [target] is a saint even amongst the living. Even then, the fragile foundation of principles ever-demand attention", range=4)
					if (OPTION_BLOOD_BONDED)
						if (HAS_TRAIT(target, TRAIT_UNBONDABLE))
							owner.malkavian_voices("[target]'s abnormal biology surpasses the bonding nature of vitae; no chains of blood can be placed on them — only the call of addiction.")
						else
							var/mob/living/carbon/human/target_master_name = /datum/status_effect/blood_bond
							owner.malkavian_voices("Chains interlock [target]'s blood — binding them to another. the call of [target_master_name] beckons them in some way or form.", range=4)
					if (OPTION_WYRM_TAINTED)
						if (get_kindred_splat(target) && (HAS_TRAIT(target, TRAIT_HIDDEN_WYRMTAINT))) // if Vampire with hidden Wyrmtaint
							owner.malkavian_voices("A faint glimmer of decay is embracing [target].", range=4)
						else if (get_kindred_splat(target)) // Vampire with no Hidden Wyrmtaint
							owner.malkavian_voices("The beast of this vampire still gnaws at some recess of their mind, an entropic taint is noticable.", range=4)
						else if (HAS_TRAIT(target, TRAIT_WYRMTAINTED_SPRITE)) // Physically appears Wyrmtainted and not a vampire
							owner.malkavian_voices("The taint of the Wyrm malforms [target]'s body and mind into a cruel mockery of nature.", range=4)
						else // Is tainted by the Wyrm and not a vampire
							owner.malkavian_voices("The taint of the Wyrm harshly defiles [target]'s very being.", range=4)
					if (OPTION_COUNTRY_OF_ORIGIN)
						var/target_country_of_origin = target?.client?.prefs.read_preference(/datum/preference/choiced/country_of_origin)
						if (target_country_of_origin == "United States") // List state instead of country
							var/target_state_of_origin = target?.client?.prefs.read_preference(/datum/preference/choiced/state_of_origin)
							owner.malkavian_voices("This individual is quite home here in the States; [target_state_of_origin] is held close to their heart", range=4)
						else
							owner.malkavian_voices("Our eyes sense this individual to be from [target_country_of_origin] — a distant place now.", range=4)
					if (OPTION_CHARACTER_NAME)
						var/target_true_name = target?.client?.prefs.read_preference(/datum/preference/name/real_name)
						owner.malkavian_voices("The one you lay our eyes upon is known to us by [target_true_name].", range=4)
					if (OPTION_SECOND_PRESENCE)
						if (target.has_trauma_type(/datum/brain_trauma/severe/split_personality))
							owner.malkavian_voices("The ego of [target] has been split asunder; neither able to hold control.", range=4)
						else if (target.has_trauma_type(/datum/brain_trauma/special/imaginary_friend))
							owner.malkavian_voices("A splinter of individual consciousness is bound to your target; or perhaps simply a figment of their own imagination.", range=4)
					if (OPTION_WILLPOWER)
						switch (target.st_get_stat(STAT_PERMANENT_WILLPOWER))
							if (0)
								owner.malkavian_voices("Your target has had all the desires of life crushed under the heel of oblivion; naught even the will to pursue the embrace of death.", range=4)
							if (1,2)
								owner.malkavian_voices("[target] has sparse determination. To navigate the challenges of life drains the little will still had.", range=4)
							if (3,4)
								owner.malkavian_voices("The average will of the world; the character of [target] is nothing too special — a personality firm yet moldable.", range=4)
							if (5,6)
								owner.malkavian_voices("Strength of character is a trait seen prominently in this one; an above respectable personhood and the will to ward it faltering.", range=4)
							if (7)
								owner.malkavian_voices("Such fortitude of the mind is rarely seen indeed... Beginning to bridge the gap between the impressive and extraordinary!", range=4)
							if (8,9)
								owner.malkavian_voices("The nature of [target]'s ego is within the realm of fanatical. A near unbreakable resolve to face the woes of this dark world.", range=4)
							if (10 to INFINITY)
								owner.malkavian_voices("The temple of [target]'s mind is a sacred place unsullied by the horrors of the world; their unfaltering will has no equal.", range=4)
					if (OPTION_SPLAT)
						if (get_kindred_splat(target))
							owner.malkavian_voices("A being of stasis maintained by a hunger for life; fundementally stagnant yet still grasping an ever-changing world.")
						else if (get_ghoul_splat(target))
							owner.malkavian_voices("Addiction defines this mortal's extended existence. The vices that urge them bring both great boons and curses", range=4)
						else if (get_garou_splat(target))
							owner.malkavian_voices("An ancient rage defines [target]. The fangs and claws of a dreaming god, fervently protecting her domain.", range=4)
						else if (get_corax_splat(target))
							owner.malkavian_voices("Blessed by both bird and sun - [target] wings carry them through a world full of delectable secrets.", range=4)
						else if (get_kinfolk_splat(target))
							owner.malkavian_voices("the faint presence of The Emerald Mother can be seen within [target]'s essence — nature is dear to them.", range=4)
						else
							owner.malkavian_voices("A creature untouched by the deviations of normalcy, not a touch of the supernatural in their being.", range=4)
					if (OPTION_EMOTION) // THIS AND BELOW BROKEN
						switch (target.current_emotion)
							if (AURA_AGGRESSIVE, AURA_BITTER, AURA_ANGRY)
								owner.malkavian_voices("Our eyes see spite and fury within the heart of our observed.", range=4)
							if (AURA_BITTER)
								owner.malkavian_voices("[target]'s emotions are effected by a percieved past unfairness, misfortune or similar ilk.", range=4)
							if (AURA_HATEFUL)
								owner.malkavian_voices("The seething rage within them is comparable to the most baleful of demons!", range=4)
							if (AURA_DESIROUS)
								owner.malkavian_voices("The heart of [target] intensively yearns for something more.", range=4)
							if (AURA_DAYDREAMING)
								owner.malkavian_voices("Their head is firmly stuck in the clouds", range=4)
							if (AURA_DEPRESSED)
								owner.malkavian_voices("This sorry soul is falling down a spiral of cruel despair and apathy", range=4)
							if (AURA_LOVESTRUCK)
								owner.malkavian_voices("[target] has an infatuation with someone or something", range=4)
							if (AURA_CONSERVATIVE)
								owner.malkavian_voices("This individual has a fairly neutral state; no strong pulls towards any other emotional influence.", range=4)
							if (AURA_OBSESSED)
								owner.malkavian_voices("Twitching senses have been overtaken by a fixation — but what could inspire such captivation?", range=4)
							if (AURA_HAPPY, AURA_EXCITED)
								owner.malkavian_voices("Joyous jubilations follow [target] wherever they go. Such a smile borders on contagious", range=4)
							if (AURA_IDEALISTIC)
								owner.malkavian_voices("An optimistic viewpoint for the future; starry-eyed believfs in better possibilities", range=4)
							if (AURA_ANXIOUS)
								owner.malkavian_voices("Fear and worry plague [target], a worry that cannot simply be willed away.", range=4)
							if (AURA_COMPASSIONATE)
								owner.malkavian_voices("The thought and care possessed by this one could comfort even the most wounded soul", range=4)
							if (AURA_CONFUSED)
								owner.malkavian_voices("A ditzy mess confounded by the world around them — perhaps on the edge of a muddled stupor.", range=4)
							if (AURA_SUSPICIOUS)
								owner.malkavian_voices("Narrowed, ever-shifting eyes meet everything around them with suspicion and distrust", range=4)
							if (AURA_ENVIOUS)
								owner.malkavian_voices("A want for what they don't have stains another heart.", range=4)
							if (AURA_GENEROUS)
								owner.malkavian_voices("An abundance of selflessness enriches those around them — sharing is caring.", range=4)
							if (AURA_SPIRITUAL)
								owner.malkavian_voices("The emotions of [target] feel beyond themselves; a form of peace is found in the spirit of life", range=4)
							if (AURA_SAD)
								owner.malkavian_voices("Persisent woe covers our target under a blanket of sadness.", range=4)
							if (AURA_CALM)
								owner.malkavian_voices("Even your fractured psyche is eased by the serenity of this calm mind.", range=4)
							if (AURA_DISTRUSTFUL)
								owner.malkavian_voices("This heart is kept under lock and key — hurt far too much as of late to express what is inside.", range=4)
							if (AURA_PSYCHOTIC)
								owner.malkavian_voices("A kindred spirit of your affliction. Perhaps another prophet of delirium? Perhaps just another madman...", range=4)
							if (AURA_INNOCENT)
								owner.malkavian_voices("They are innocent to the world surrounding them — or perhaps at ease to it, even.", range=4)
					if (OPTION_BREED)
						switch (get_fera_breed_form(target))
							if (/datum/subsplat/werewolf/breed_form/corax/corvid)
								owner.malkavian_voices("The heart of this corvid is one born of nature's world — an outsider to the realm of man.", range=4)
							if (/datum/subsplat/werewolf/breed_form/garou/lupus)
								owner.malkavian_voices("This true form of this wolf is one of the wild. A beast bestowed the gift of higher thought.", range=4)
							if (/datum/subsplat/werewolf/breed_form/corax/homid)
								owner.malkavian_voices("An outsider to the skies imbued with a spirit egg; humanity unshackled by the world below", range=4)
							if (/datum/subsplat/werewolf/breed_form/garou/homid)
								owner.malkavian_voices("Closer to man than beast, [target] has more familiarity with forests of concrete than ones of wood", range=4)
							if (/datum/subsplat/werewolf/breed_form/garou/crinos)
								owner.malkavian_voices("An abberant beast neither man or wolf, yet not quite not either. A being born of taboo imbued with rage.", range=4)
					if (OPTION_AUSPICE)
						//if (target.is_auspice(/datum/subsplat/werewolf/auspice/garou/ahroun))
						switch (target.get_our_auspice()?.name)
							if (/datum/subsplat/werewolf/auspice/garou/ahroun)
								target.malkavian_voices("An embodiment of the Moon's rage; battle is ingrained within their very being! Renown and glory are vital parts of themselves.", range=4)
							if (AUSPICE_PHILODOX)
								target.malkavian_voices("A creature of balance and order; a tempered mind able to see both sides — honor and wisdom define them.", range=4)
							if (AUSPICE_GALLIARD)
								target.malkavian_voices("A passionate muse, [target] is tasked with the preservation and celebration of the culture they hail from. Glory and renown remedy their soul.", range=4)
							if (AUSPICE_THEURGE)
								target.malkavian_voices("Seer, explorer, conduit, [target] is a spiritual guide and healer to their kind. Wisdom and honor guide them true.", range=4)
							if (AUSPICE_RAGABASH)
								target.malkavian_voices("The joker of the deck, this individual is the wild card of their group. The aspects that empower them are entirely their own to decide.", range=4)
							if (AUSPICE_NONE)
								target.malkavian_voices("This individual has changed far more than any shifter could ever hope... In the most twisted of ways. A stolen gift repurposed for their own use — though to what end?", range=4)




						//var/datum/action/discipline/target_disciplines = pick(discipline_splat.powers) // Ditto ^
					//	var/list/all_disciplines = discipline_splat




				//sleep(2 SECONDS) // make into proper timer function that's not sleep

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
#undef OPTION_AUSPICE

/datum/discipline_power/dementation/eyes_of_chaos/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = SSroll.storyteller_roll_datum(owner, target, difficulty = 7, applic_stats = list(STAT_PERCEPTION, STAT_OCCULT), numerical = FALSE)
	if(target == owner)
		return TRUE
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
