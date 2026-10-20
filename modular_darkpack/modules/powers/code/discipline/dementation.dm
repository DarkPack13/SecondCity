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
	cooldown_length = 2 TURNS // Return to 5
	duration_length = 1 TURNS
	activate_sound = null // dont play a sound
	vitae_cost = 1
	var/list/choice_options = list("Secrets", "Information",)
	var/datum/tgui_window/eyes_of_chaos_window

/datum/discipline_power/dementation/eyes_of_chaos/proc/update_choices()
	choice_options["Secrets"] = icon('modular_darkpack/modules/powers/icons/dementation.dmi', "scroll_icon")
	choice_options["Information"] = icon('modular_darkpack/modules/powers/icons/dementation.dmi', "eye_brain_icon")

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
#define OPTION_BLOOD_BONDED "Blood Bonded" // + Unbondable
#define OPTION_IS_INFLUENCED "Influenced" // Any power that would control, influence or coerce someone (excluding dominate)
#define OPTION_IS_DOMINATED "Dominated" // Dominate 4 or 5
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
#define OPTION_HAS_SIRE "Sire"
#define OPTION_HAS_KILLED "Murder Count"
#define OPTION_FEEDING_SPECIFICATIONS "Feeding Specifications"
#define OPTION_WILL "Will"
#define OPTION_SPIRIT_MARKS "Marks"
#define OPTION_VITAE "Vitae"
#define OPTION_RAGE_FRENZY "Rage and Frenzy"
#define OPTION_SEE_GHOSTS "See Ghosts"
#define OPTION_BLOOD_HUNGRY "Hungry for Blood"
#define OPTION_SHAPESHIFTING_MODIFIERS "Shapeshifting"
#define OPTION_PROMETHEAN_CLAY "Promethean Clay"
#define OPTION_SANGUINE_INCONGRUITY "Sanguine Incongruity"
#define OPTION_THE_LARGEST_MAW "The Largest Maw"
#define OPTION_PIERCED_VEIL "Pierced Veil"
#define OPTION_STOMACH "Strong Stomach"
#define OPTION_ENCHANTING_VOICE "Enchanting Voice"
#define OPTION_DERANGEMENT "Derangement"
#define OPTION_GLABRO "Fair Glabro"
#define OPTION_LOGICAL "Coldly Logical"
#define OPTION_ACUTE_SENSES "Acute Senses"
#define OPTION_SEIZURES "Seizures"
#define OPTION_APPEARANCE "Appearances"
#define OPTION_ILLITERATE "Illiterate"
#define OPTION_HEMOPHILIAC "Hemophiliac"
#define OPTION_AMNESIA "Amnesia"
#define OPTION_VENGEFUL "Vengeful"
#define OPTION_NO_REFLECTION "No Reflection"
#define OPTION_MASQUERADE_VICTIM "Victim of the Masquerade"
#define OPTION_DAMNED_GRIP "Grip of the Damned"
#define OPTION_THAUMATURGICALLY_INEPT "Thaumaturgically Inept"
#define OPTION_THIRD_EYE "Third Eye"
#define OPTION_TERRITORIAL "Territorial"
#define OPTION_LIGHT_SENSITIVE "Light Sensitive"
#define OPTION_MUTE "Mute"
#define OPTION_BLIND "Blind"
#define OPTION_DEAF "Deaf"
#define OPTION_DECEPTIVE_AURA "Deceptive Aura"
#define OPTION_PALE_AURA "Pale Aura"
#define OPTION_HOLINESS_REPELLED "Repelled by Holiness"
#define OPTION_TECHNOLOGY_REJECTED "Rejected by Technology"
#define OPTION_METAL_WEAKNESS "Metal Weakness"
#define OPTION_DEATH_STILLNESS "Stillness of Death"
#define OPTION_SENSITIVE_HUMANITY "Sensitive Humanity"
#define OPTION_TIME_SENSE "Time Sense"
#define OPTION_TIMEWARPER "Timewarper"
#define OPTION_VIRTUOSA "Virtuosa"
#define OPTION_STAKE_RESISTANCE "Stake Resistance"
#define OPTION_FANGS "Fangs"

	// Add options to the master list if conditions are met. "Information" will draw from "available_options".
	var/list/available_options = list(OPTION_BIOLOGICAL_AGE, OPTION_WILLPOWER, OPTION_SPLAT)
	if (get_kindred_splat(target)) // Vampire
		available_options += list(OPTION_DISCIPLINES, OPTION_GENERATION, OPTION_MORALITY_PATH, OPTION_HUMANITY, OPTION_CLAN)
	if (get_ghoul_splat(target)) // Ghoul
		available_options += list(OPTION_DISCIPLINES)
	if (get_garou_splat(target)) // Garou
		available_options += list(OPTION_TRIBE, OPTION_BREED, OPTION_AUSPICE)
	if (get_corax_splat(target)) // Corax
		available_options += list(OPTION_BREED)
	if (target.client?.prefs) // If preferences (avoid issues with NPCs)
		available_options += list(OPTION_COUNTRY_OF_ORIGIN, OPTION_CHARACTER_NAME)
	if (target.client?.prefs && get_kindred_splat(target)) // (Literally just for Immortal Age)
		available_options += list(OPTION_IMMORTAL_AGE)
	if (HAS_TRAIT(target, TRAIT_POSSIBLE_WYRM) || (get_kindred_splat(target) && (target.st_get_stat(STAT_MORALITY) <= 7))) // Wyrm-Tainted or Sub-7 Humanity
		available_options += list(OPTION_WYRM_TAINTED)
	if (length(target.get_traumas())) // If Brain Trauma(s)
		if (target.has_trauma_type(/datum/brain_trauma/severe/split_personality) || (target.has_trauma_type(/datum/brain_trauma/special/imaginary_friend)))
			available_options += list(OPTION_SECOND_PRESENCE) // Split Personality / Imaginary Friend
		else
			available_options += list(OPTION_BRAIN_TRAUMA)
	if (HAS_TRAIT(target, TRAIT_DIABLERIE)) // Diablerist
		available_options += list(OPTION_DIABLERIE)
	if (target.has_status_effect(/datum/status_effect/blood_bond) || (HAS_TRAIT(target, TRAIT_UNBONDABLE))) // Blood Bond & Unbondable
		available_options += list(OPTION_BLOOD_BONDED)
	if (target.current_emotion != "Innocent") // Emotions if not default (innocent)
		available_options += list(OPTION_EMOTION)
	if (HAS_TRAIT(target, TRAIT_FORCED_EMOTION) ||  target.has_status_effect(/datum/status_effect/awe) || target.has_status_effect(/datum/status_effect/dread_gaze)) //DARKPACK TODO Presence 3-5 do not have tied status effects currently, cannot nicely check for them until that
		available_options += list(OPTION_IS_INFLUENCED)
	if (target.possessed == TRUE || target.conditioner) // Dominate 4 & 5
		available_options += list(OPTION_IS_DOMINATED)
	if (get_kindred_splat(target))
		var/datum/splat/vampire/kindred/target_kindred = get_kindred_splat(target) // If defined Sire
		if (target_kindred.sire != null)
			available_options += list(OPTION_HAS_SIRE)
	if (target.killed_count > 0) // If Killcount above 0 in-round
		available_options += list(OPTION_HAS_KILLED)
	if (HAS_TRAIT(target, TRAIT_ORGANOVORE || TRAIT_ANTHROPIC_TASTE || TRAIT_THIRST_OF_AGES || TRAIT_EAT_FOOD))
		available_options += list(OPTION_FEEDING_SPECIFICATIONS)
	if (HAS_TRAIT(target, TRAIT_IRON_WILL || TRAIT_WEAK_WILLED || TRAIT_WEAK_TO_DOMINATE || TRAIT_MERIT_UNTAMABLE))
		available_options += list(OPTION_WILL)
	if (HAS_TRAIT(target, TRAIT_BEACON_OF_THE_UNHOLY || TRAIT_BETRAYERS_MARK || TRAIT_AURA_OF_CONFIDENCE))
		available_options += list(OPTION_SPIRIT_MARKS)
	if (HAS_TRAIT(target, TRAIT_IRRESISTIBLE_VITAE || TRAIT_DEFICIENT_VITAE) || target.has_quirk(/datum/quirk/darkpack/mage_blood)) // Mage Blood - Tremere Trait
		available_options += list(OPTION_VITAE)
	if (HAS_TRAIT(target, TRAIT_DIFFICULT_RAGE || TRAIT_DIFFICULT_FRENZY || TRAIT_CALM_HEART || TRAIT_UNCONTROLLABLE) || target.has_quirk(/datum/quirk/darkpack/beserker))
		available_options += list(OPTION_RAGE_FRENZY)
	if (HAS_TRAIT(target, TRAIT_GHOST_VISION || TRAIT_LOCAL_SIXTHSENSE))
		available_options += list(OPTION_SEE_GHOSTS)
	if (HAS_TRAIT(target, TRAIT_NEEDS_BLOOD))
		available_options += list(OPTION_BLOOD_HUNGRY)
	if (HAS_TRAIT(target, TRAIT_BANNED_TRANSFORMATION || TRAIT_METAMORPH))
		available_options += list(OPTION_SHAPESHIFTING_MODIFIERS)
	if (HAS_TRAIT(target, TRAIT_PROMETHEAN_CLAY)) // Tzimisce Trait
		available_options += list(OPTION_PROMETHEAN_CLAY)
	if (HAS_TRAIT(target, TRAIT_SANGUINE_INCONGRUITY)) // Giovanni Trait
		available_options += list(OPTION_SANGUINE_INCONGRUITY)
	if (HAS_TRAIT(target, TRAIT_THE_LARGEST_MAW)) // Nagaraja Trait
		available_options += list(OPTION_THE_LARGEST_MAW)
	if (HAS_TRAIT(target, TRAIT_PIERCED_VEIL))
		available_options += list(OPTION_PIERCED_VEIL)
	if (HAS_TRAIT(target, TRAIT_STRONG_STOMACH) || target.has_quirk(/datum/quirk/darkpack/cast_iron_stomach))
		available_options += list(OPTION_STOMACH)
	if (HAS_TRAIT(target, TRAIT_ENCHANTING_VOICE))
		available_options += list(OPTION_ENCHANTING_VOICE)
	if (target.has_quirk(/datum/quirk/darkpack/derangement))
		available_options += list(OPTION_DERANGEMENT)
	if (HAS_TRAIT(target, TRAIT_FAIR_GLABRO))
		available_options += list(OPTION_GLABRO)
	if (HAS_TRAIT(target, TRAIT_COLDLY_LOGICAL))
		available_options += list(OPTION_LOGICAL)
	if (target.has_quirk(/datum/quirk/darkpack/acute_sense))
		available_options += list(OPTION_ACUTE_SENSES)
	if (target.has_quirk(/datum/quirk/darkpack/seizures))
		available_options += list(OPTION_SEIZURES)
	if (target.has_quirk(/datum/quirk/darkpack/horrific_appearance) || target.has_quirk(/datum/quirk/darkpack/disfigured) || target.has_quirk(/datum/quirk/darkpack/monstrous) || HAS_TRAIT(target, TRAIT_MASQUERADE_VIOLATING_FACE)) // Horrific Appearance - Cappadocian Trait
		available_options += list(OPTION_APPEARANCE)
	if (HAS_TRAIT(target, TRAIT_EASYBLEED))
		available_options += list(OPTION_HEMOPHILIAC)
	if (HAS_TRAIT(target, TRAIT_ILLITERATE))
		available_options += list(OPTION_ILLITERATE)
	if (target.has_quirk(/datum/quirk/darkpack/amnesia))
		available_options += list(OPTION_AMNESIA)
	if (target.has_quirk(/datum/quirk/darkpack/vengeful))
		available_options += list(OPTION_VENGEFUL)
	if (HAS_TRAIT(target, TRAIT_NO_MIRROR_REFLECTION))
		available_options += list(OPTION_NO_REFLECTION)
	if (HAS_TRAIT(target, TRAIT_VICTIM_OF_THE_MASQUERADE))
		available_options += list(OPTION_MASQUERADE_VICTIM)
	if (HAS_TRAIT(target, TRAIT_PAINFUL_VAMPIRE_KISS))
		available_options += list(OPTION_DAMNED_GRIP)
	if (target.has_quirk(/datum/quirk/darkpack/thaumaturgically_inept)) // Tremere Trait
		available_options += list(OPTION_THAUMATURGICALLY_INEPT)
	if (HAS_TRAIT(target, TRAIT_THIRD_EYE) || (get_kindred_splat(target) && target.is_clan(/datum/subsplat/vampire_clan/salubri/warrior) || target.is_clan(/datum/subsplat/vampire_clan/salubri))) // Salubri / Tremere
		available_options += list(OPTION_THIRD_EYE)
	if (HAS_TRAIT(target, TRAIT_VAMPIRE_TERRITORIAL))
		available_options += list(OPTION_TERRITORIAL)
	if (HAS_TRAIT(target, TRAIT_LIGHT_WEAKNESS))
		available_options += list(OPTION_LIGHT_SENSITIVE)
	if (HAS_TRAIT(target, TRAIT_MUTE))
		available_options += list(OPTION_MUTE)
	if (target.has_quirk(/datum/quirk/item_quirk/blindness))
		available_options += list(OPTION_BLIND)
	if (HAS_TRAIT(target, TRAIT_DEAF))
		available_options += list(OPTION_DEAF)
	if (target.has_quirk(/datum/quirk/darkpack/deceptive_aura)) // Needs quirk not trait specifically
		available_options += list(OPTION_DECEPTIVE_AURA)
	if (target.has_quirk(/datum/quirk/darkpack/pale_aura)) // Needs quirk not trait specifically
		available_options += list(OPTION_PALE_AURA)
	if (HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS)) // Baali
		available_options += list(OPTION_HOLINESS_REPELLED)
	if (HAS_TRAIT(target, TRAIT_REJECTED_BY_TECHNOLOGY)) // Lasombra
		available_options += list(OPTION_TECHNOLOGY_REJECTED)
	if (HAS_TRAIT(target, TRAIT_SILVER_WEAKNESS || TRAIT_SILVER_WEAKNESS))
		available_options += list(OPTION_METAL_WEAKNESS)
	if (HAS_TRAIT(target, TRAIT_STILLNESS_OF_DEATH)) // Gargoyle Trait
		available_options += list(OPTION_DEATH_STILLNESS)
	if (HAS_TRAIT(target, TRAIT_SENSITIVE_HUMANITY))
		available_options += list(OPTION_SENSITIVE_HUMANITY)
	if (HAS_TRAIT(target, TRAIT_TIME_SENSE))
		available_options += list(OPTION_TIME_SENSE)
	if (HAS_TRAIT(target, TRAIT_TIMEWARPER)) // Temporis
		available_options += list(OPTION_TIMEWARPER)
	if (HAS_TRAIT(target, TRAIT_VIRTUOSA)) // Melpominee
		available_options += list(OPTION_VIRTUOSA)
	if (HAS_TRAIT(target, TRAIT_STAKE_RESISTANT || TRAIT_STAKE_IMMUNE))
		available_options += list(OPTION_STAKE_RESISTANCE)
	if (HAS_TRAIT(target, TRAIT_DULLFANGS || TRAIT_PERMAFANGS))
		available_options += list(OPTION_FANGS)

	switch (chosen_option)
		if ("Secrets")
			open_chaos_eyes_window(target)
			playsound(target, 'sound/items/haunted/ghostitemattack.ogg', 30, vary = TRUE)
		if ("Information")
			var/list/selected_options = list()
			for (var/i in 1 to 15) // Revert to 3 on full PR NEED TIMER!!!!
				selected_options += pick_n_take(available_options)
				playsound(target, 'sound/items/haunted/ghostitemattack.ogg', 30, vary = TRUE)
				//COOLDOWN_START(src, pick_cooldown, 2 SECONDS) i have no idea what to put here to make it work yet
			for (var/option in selected_options)
				switch (option)
					if (OPTION_IMMORTAL_AGE)
						var/target_immortal_age = target?.client?.prefs.read_preference(/datum/preference/numeric/immortal_age) // Get Immortal Age
						var/determined_age = "This fledgling has just been thrust into this new world; the pitiable thing is not even past their first year."
						if (target_immortal_age < 100)
							determined_age = "[target] has surpassed their first mortal lifetime; a growing disconnect to the living begins to bloom."
						else if (target_immortal_age < 200)
							determined_age = "The normality of time has fully fractured for [target] — far exceeding a mortal's lifespan."
						else
							determined_age = "The crushing weight of time is held up by [target]. Further burdened with each passing decade."
						owner.malkavian_voices("[determined_age]", range=4)
					if (OPTION_BIOLOGICAL_AGE)
						owner.malkavian_voices("We count [target.age] rings within their shell. Each embedded with many stories to tell.", range=4)
					if (OPTION_CLAN) // NOTE - Potentially expand to a unique message for all clans (that might take a while)
						if (target.is_clan(/datum/subsplat/vampire_clan/caitiff))
							owner.malkavian_voices("No bloodline can be distilled out of [target]... An absence of clan in a world where such is ever-important.", range=4)
						else if (get_kindred_splat(target))
							owner.malkavian_voices("Blood is thicker than water in this world; the [target.get_clan()] lineage seems to have made [target] their own.", range=4)
					if (OPTION_TRIBE) // NOTE - Potentially expand to a unique message for all tribes
						if (target.get_our_tribe(/datum/subsplat/werewolf/tribe/garou/blackspiraldancers))
							owner.malkavian_voices("[target] has peered into the spiraling abyss; coming back changed, twisted... Yet craving more. The madness they've lost themselves to may even outshine ours", range=4)
						else if (target.get_our_tribe(/datum/subsplat/werewolf/tribe/garou/ronin))
							owner.malkavian_voices("An outcast amongst their kind, [target] finds little solace found in the kin around them — a dire predicament for such a being.", range=4)
						else
							owner.malkavian_voices("[target] is amongst the [target.get_our_tribe()] through one way or another — faithful to the principles of such a family.", range=4)
					if (OPTION_DISCIPLINES)
						var/datum/splat/vampire/discipline_splat = get_vampire_splat(target) // Get a Vampire's/Ghoul's power details and see what disciplines those powers are under
						var/list/discipline_filtered_list = list()
						for (var/datum/action/discipline/individual_discipline in discipline_splat.powers) // We don't want Bloodheal, filters it out
							if (istype(individual_discipline.discipline, /datum/discipline/bloodheal))
								continue
							discipline_filtered_list += individual_discipline // Ensure everything but Bloodheal makes it to the filtered list
						if (!length(discipline_filtered_list))
							owner.malkavian_voices("The bounty of [target]'s clan bears no fruit! Devoid of substance!", range=4)
						else
							var/datum/action/discipline/target_disciplines = pick(discipline_filtered_list) // Pick from the filtered list
							owner.malkavian_voices("Much knowledge is embedded within this fiend of vitae. [target_disciplines.discipline] is but one gift of blood bestowed upon them.", range=4)
					if (OPTION_BRAIN_TRAUMA)
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
						owner.malkavian_voices("Their Beast's incessant cravings are tamed by the [get_morality_path(target)]", range=4)
					if (OPTION_DIABLERIE)
						if (HAS_TRAIT(target, TRAIT_HIDDEN_DIABLERIE))
							owner.malkavian_voices("Creeping vines of black veins encompass the soul of [target] in an embrace most constricting.", range=4)
						else
							owner.malkavian_voices("[target]'s soul is marked with a grave sin. Stolen essence is devoured within — veins of tar supplying the scourge it inhabits.", range=4)
					if (OPTION_HUMANITY)
						switch (target.st_get_stat(STAT_MORALITY)) // STAT_MORALITY = Humanity
							if (0)
								owner.malkavian_voices("Drooling, gnawing, aching. An emaciated body gorged with stolen life breaks its mind in starvation.", range=4) // Wight
							if (1)
								owner.malkavian_voices("[target] is savagely hounded by their Beast, one moment away from plunging into the brink of madness", range=4)
							if (2,3)
								owner.malkavian_voices("The Beast pounds the mind of [target] day after day; demands ever-made to pervert such fragile humanity with nary a reprive.", range=4)
							if (4,5)
								owner.malkavian_voices("The reality of undeath has long since sunken in comfortably for [target]. After all, a predator pays no mind to the thought of its prey.", range=4)
							if (6)
								owner.malkavian_voices("That's that, and this is this. This kindred isn't quite Beast, yet not much closer to a human either.", range=4)
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
							var/datum/status_effect/blood_bond/target_blood_bond = target.has_status_effect(/datum/status_effect/blood_bond) // Lets us access regnant_name here
							owner.malkavian_voices("Chains interlock [target]'s blood — binding them to another. the call of [target_blood_bond.regnant_name.real_name] beckons them in some way or form.", range=4)
					if (OPTION_WYRM_TAINTED)
						if (get_kindred_splat(target) && (HAS_TRAIT(target, TRAIT_HIDDEN_WYRMTAINT))) // if Vampire with hidden Wyrmtaint
							owner.malkavian_voices("A faint glimmer of decay is embracing [target].", range=4)
						else if (get_kindred_splat(target)) // Vampire with no Hidden Wyrmtaint
							owner.malkavian_voices("The Beast of this vampire still gnaws at some recess of their mind, an entropic taint is noticable.", range=4)
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
							owner.malkavian_voices("Addiction defines this mortal's extended existence. The vices that urge them bring both great boons and banes", range=4)
						else if (get_garou_splat(target))
							owner.malkavian_voices("An ancient rage defines [target]. The fangs and claws of a dreaming god, fervently protecting her domain.", range=4)
						else if (get_corax_splat(target))
							owner.malkavian_voices("Blessed by both bird and sun - [target] wings carry them through a world full of delectable secrets.", range=4)
						else if (get_kinfolk_splat(target))
							owner.malkavian_voices("the faint presence of The Emerald Mother can be seen within [target]'s essence — nature is dear to them.", range=4)
						else
							owner.malkavian_voices("A creature untouched by the deviations of normalcy, not a touch of the supernatural in their being.", range=4)
					if (OPTION_EMOTION)
						switch (target.current_emotion)
							if ("Aggressive", "Angry")
								owner.malkavian_voices("Our eyes see spite and fury within the heart of our observed.", range=4)
							if ("Bitter")
								owner.malkavian_voices("[target]'s emotions are effected by a percieved past unfairness, misfortune or similar ilk.", range=4)
							if ("Hateful")
								owner.malkavian_voices("The seething rage within them is comparable to the most baleful of demons!", range=4)
							if ("Desirous")
								owner.malkavian_voices("The heart of [target] intensively yearns for something more.", range=4)
							if ("Daydreaming")
								owner.malkavian_voices("Their head is firmly stuck in the clouds", range=4)
							if ("Depressed")
								owner.malkavian_voices("This sorry soul is falling down a spiral of cruel despair and apathy", range=4)
							if ("Lovestruck")
								owner.malkavian_voices("[target] has an infatuation with someone or something", range=4)
							if ("Conservative")
								owner.malkavian_voices("This individual has a fairly neutral state; no strong pulls towards any other emotional influence.", range=4)
							if ("Obsessed")
								owner.malkavian_voices("Twitching senses have been overtaken by a fixation — but what could inspire such captivation?", range=4)
							if ("Happy", "Excited")
								owner.malkavian_voices("Joyous jubilations follow [target] wherever they go. Such a smile borders on contagious", range=4)
							if ("Idealistic")
								owner.malkavian_voices("An optimistic viewpoint for the future; starry-eyed believfs in better possibilities", range=4)
							if ("Anxious")
								owner.malkavian_voices("Fear and worry plague [target], a worry that cannot simply be willed away.", range=4)
							if ("Compassionate")
								owner.malkavian_voices("The thought and care possessed by this one could comfort even the most wounded soul", range=4)
							if ("Confused")
								owner.malkavian_voices("A ditzy mess confounded by the world around them — perhaps on the edge of a muddled stupor.", range=4)
							if ("Suspicious")
								owner.malkavian_voices("Narrowed, ever-shifting eyes meet everything around them with suspicion and distrust", range=4)
							if ("Envious")
								owner.malkavian_voices("A want for what they don't have stains another heart.", range=4)
							if ("Generous")
								owner.malkavian_voices("An abundance of selflessness enriches those around them — sharing is caring.", range=4)
							if ("Spiritual")
								owner.malkavian_voices("The emotions of [target] feel beyond themselves; a form of peace is found in the spirit of life", range=4)
							if ("Sad")
								owner.malkavian_voices("Persisent woe covers our target under a blanket of sadness.", range=4)
							if ("Calm")
								owner.malkavian_voices("Even your fractured psyche is eased by the serenity of this calm mind.", range=4)
							if ("Disrustful")
								owner.malkavian_voices("This heart is kept under lock and key — hurt far too much as of late to express what is inside.", range=4)
							if ("Psychotic")
								owner.malkavian_voices("A kindred spirit of your affliction. Perhaps another prophet of delirium? Perhaps just another madman...", range=4)
							if ("Innocent")
								owner.malkavian_voices("They are innocent to the world surrounding them — or perhaps at ease to it, even.", range=4)
					if (OPTION_BREED)
						switch (get_fera_breed_form(target).name)
							if (BREED_CORVID)
								owner.malkavian_voices("The heart of this corvid is one born of nature's world — an outsider to the realm of man.", range=4)
							if (BREED_LUPUS)
								owner.malkavian_voices("This true form of this wolf is one of the wild. A beast bestowed the gift of higher thought.", range=4)
							if (BREED_CORAX_HOMID)
								owner.malkavian_voices("An outsider to the skies imbued with a spirit egg; humanity unshackled by the world below", range=4)
							if (BREED_GAROU_HOMID)
								owner.malkavian_voices("Closer to man than beast, [target] has more familiarity with forests of concrete than ones of wood", range=4)
							if (BREED_CRINOS)
								owner.malkavian_voices("An abberant beast neither man or wolf, yet not quite not either. A being born of taboo imbued with rage.", range=4)
					if (OPTION_AUSPICE)
						switch (target.get_our_auspice().name)
							if (AUSPICE_AHROUN)
								owner.malkavian_voices("An embodiment of the Moon's rage; battle is ingrained within their very being! Renown and glory are vital parts of themselves.", range=4)
							if (AUSPICE_PHILODOX)
								owner.malkavian_voices("A creature of balance and order; a tempered mind able to see both sides — honor and wisdom define them.", range=4)
							if (AUSPICE_GALLIARD)
								owner.malkavian_voices("A passionate muse, [target] is tasked with the preservation and celebration of the culture they hail from. Glory and renown remedy their soul.", range=4)
							if (AUSPICE_THEURGE)
								owner.malkavian_voices("Seer, explorer, conduit, [target] is a spiritual guide and healer to their kind. Wisdom and honor guide them true.", range=4)
							if (AUSPICE_RAGABASH)
								owner.malkavian_voices("The joker of the deck, this individual is the wild card of their group. The aspects that empower them are entirely their own to decide.", range=4)
							if (AUSPICE_NONE)
								owner.malkavian_voices("This individual has changed far more than any shifter could ever hope... In the most twisted of ways. A stolen gift repurposed for their own use — though to what end?", range=4)
					if (OPTION_IS_INFLUENCED)
						if (HAS_TRAIT(target, TRAIT_FORCED_EMOTION))
							owner.malkavian_voices("The emotions [target]'s heart bleeds is not off their own accord — brought on by another artificially.", range=4)
						else if (target.has_status_effect(/datum/status_effect/awe))
							owner.malkavian_voices("Our target is completely captivated by another!", range=4)
						else if (target.has_status_effect(/datum/status_effect/dread_gaze))
							owner.malkavian_voices("[target] has had an unnatural terror instilled deep within them.", range=4)
					if (OPTION_IS_DOMINATED)
						if (target.possessed == TRUE)
							owner.malkavian_voices("This individual is merely a puppet of flesh; their ego sealed away within by another.", range=4)
						else if (target.conditioner)
							owner.malkavian_voices("A mind shattered into pieces then re-assembled to suit another; The agency of this poor thing is completely dominated by another.", range=4)
					if (OPTION_HAS_SIRE)
						var/datum/splat/vampire/kindred/target_kindred = get_kindred_splat(target) // Access .sire
						owner.malkavian_voices("The animated corpse of this kindred bears [target_kindred.sire.real_name]'s imprint — engraved into their very essence.", range=4)
					if (OPTION_HAS_KILLED)
						switch (target.killed_count)
							if (1)
								owner.malkavian_voices("A soul run cold haunts our gazed. Through some tragedy or another their death is linked to [target].", range=4)
							if (2 to 4)
								owner.malkavian_voices("The murders enacted by our target have began to be seen as serial by the eyes of the city...", range=4)
							if (5 to 9)
								owner.malkavian_voices("The lives lost to [target] could begin to populate a graveyard!", range=4)
							if (10 to 19)
								owner.malkavian_voices("The city is quiet, the streets are still, the beast had took them all — claiming kill after kill.")
							if (20 to INFINITY)
								owner.malkavian_voices("A mountain of smiling bodies towers ever higher over the cityscape. On top, [target]... closer to the heavens with each addition.", range=4)
					if (OPTION_FEEDING_SPECIFICATIONS)
						if (HAS_TRAIT(target, TRAIT_ORGANOVORE))
							owner.malkavian_voices("The hunger of this Kindred is not one so easily sated by traditional means; the gutteral screech of hunger craves the flesh of others!", range=4)
						else if (HAS_TRAIT(target, TRAIT_THIRST_OF_AGES))
							owner.malkavian_voices("The void of this Kindred's hunger can only be sated by the most potent of blood.", range=4)
						else if (HAS_TRAIT(target, TRAIT_ANTHROPIC_TASTE))
							owner.malkavian_voices("Both body and mind are key to truly deriving nutrition for our target, nary a beast or creature could temper their thirst.", range=4)
						else if (HAS_TRAIT(target, TRAIT_EAT_FOOD))
							owner.malkavian_voices("Unlike most of our ilk - [target] is still able to derive the pleasures of life from cuisine.", range=4)
					if (OPTION_WILL)
						if (HAS_TRAIT(target, TRAIT_MERIT_UNTAMABLE))
							owner.malkavian_voices("The only call this beast heeds is the call of their own, a resolve everlasting.", range=4)
						else if (HAS_TRAIT(target, TRAIT_IRON_WILL))
							owner.malkavian_voices("The mountains of [target]'s mind are a seemingly impossible obstacle to overcome!", range=4)
						else if (HAS_TRAIT(target, TRAIT_WEAK_WILLED))
							owner.malkavian_voices("Our eyes see a fragile ego desperately craving approval; the rivers of their unconscious easily divertable.", range=4)
						else if (HAS_TRAIT(target, TRAIT_WEAK_TO_DOMINATE))
							owner.malkavian_voices("The mind before us is most tenuous — artificially inhibited synapses easily absorbing outside influence. ", range=4)
					if (OPTION_SPIRIT_MARKS)
						if (HAS_TRAIT(target, TRAIT_BETRAYERS_MARK))
							owner.malkavian_voices("[target] pays a grave penance for one reason or another, retribution for broken chains.", range=4)
						else if (HAS_TRAIT(target, TRAIT_AURA_OF_CONFIDENCE))
							owner.malkavian_voices("The ego before us soars higher than any angel ever could... The envy of the heavens it towers over!", range=4)
						else if (HAS_TRAIT(target, TRAIT_BEACON_OF_THE_UNHOLY))
							owner.malkavian_voices("An unholy insurgency plagues our tainted friend; the scent of profane akin to that of a rotting carcass.", range=4)
					if (OPTION_VITAE)
						if (target.has_quirk(/datum/quirk/darkpack/mage_blood)) // Tremere Trait
							owner.malkavian_voices("Such a being is overflowing with a suffocating sortilege smothering out every other seed of talent.", range=4)
						else if (HAS_TRAIT(target, TRAIT_IRRESISTIBLE_VITAE))
							owner.malkavian_voices("The smell of a delicacy most divine blesses our senses... A bloody bounty of tantalizing nature!", range=4)
						else if (HAS_TRAIT(target, TRAIT_DEFICIENT_VITAE))
							owner.malkavian_voices("The diminished mockery of what this one calls their bloodline would collapse if attempting to sustain another.", range=4)
					if (OPTION_RAGE_FRENZY)
						if (HAS_TRAIT(target, TRAIT_UNCONTROLLABLE)) // Brujah Trait
							owner.malkavian_voices("The boiling blood of this fiend fully defines their character with a dire volatility!", range=4)
						else if (HAS_TRAIT(target, TRAIT_CALM_HEART))
							owner.malkavian_voices("We feel an unusual ease from their Beast within; trained, somehow, but a beast will always be a beast.", range=4)
						else if  (target.has_quirk(/datum/quirk/darkpack/beserker))
							owner.malkavian_voices("Behind bloodshot eyes lays some semblance of control, a method to the madness of rage.", range=4)
						else if (HAS_TRAIT(target, TRAIT_DIFFICULT_FRENZY))
							owner.malkavian_voices("The psyche of [target] is eternally enduring the call of the Beast — ravenous frenzies forcing submissal.", range=4)
						else if (HAS_TRAIT(target, TRAIT_DIFFICULT_RAGE))
							owner.malkavian_voices("Seething rage has wrought a great temper to this child of the wild — serenity is a bygone, fleeting emotion.", range=4)
					if (OPTION_SEE_GHOSTS)
						if (HAS_TRAIT(target, TRAIT_GHOST_VISION))
							owner.malkavian_voices("They stare out into places you and I can only imagine, greeting those unpercieved by flesh.", range=4)
						else if (HAS_TRAIT(target, TRAIT_LOCAL_SIXTHSENSE))
							owner.malkavian_voices("Voices unheard by us whisper sweet nothings into the vessel before us... Why does such gospel forsake you?!", range=4)
					if (OPTION_BLOOD_HUNGRY)
						owner.malkavian_voices("A hungering growl can be heard from within... Through eyes not our own you see yourself as nothing but blood.", range=4)
					if (OPTION_SHAPESHIFTING_MODIFIERS)
						if (HAS_TRAIT(target, TRAIT_BANNED_TRANSFORMATION))
							owner.malkavian_voices("A shapeshifter who struggles to shapeshift? What a pitiful subversion of one's supposed nature.", range=4)
						else if (HAS_TRAIT(target, TRAIT_METAMORPH))
							owner.malkavian_voices("The fluidity of form is a freedom not so easily obtained; the twain of identity meeting as a whole.", range=4)
					if (OPTION_PROMETHEAN_CLAY) // Tzimisce Trait
						owner.malkavian_voices("Flesh is merely a canvas to be molded to one's own desires. Before you stands a master of such a craft.", range=4)
					if (OPTION_SANGUINE_INCONGRUITY) // Giovanni Trait
						owner.malkavian_voices("The mark of a betrayed heritage finds its way into [target]; much renown follows such an exchange of curses.", range=4)
					if (OPTION_THE_LARGEST_MAW) // Nagaraja Trait
						owner.malkavian_voices("Squelching, gnawing, chewing - utterances made trapped within a cavern of teeth, bone weaving in and out of their own flesh.", range=4)
					if (OPTION_PIERCED_VEIL)
						owner.malkavian_voices("What should sing a chorus of pandemonium instead bears their full monstrosity to the perception of others.", range=4)
					if (OPTION_STOMACH)
						if (target.has_quirk(/datum/quirk/darkpack/cast_iron_stomach))
							owner.malkavian_voices("Anything can be eaten is a concept embraced by the 'gourmand' before us... incredible!", range=4)
						else if (HAS_TRAIT(target, TRAIT_STRONG_STOMACH))
							owner.malkavian_voices("The simple hunger of [target] has no qualm in what it's sated by. Something a portion of our ilk can relate to.", range=4)
					if (OPTION_ENCHANTING_VOICE)
						owner.malkavian_voices("Hypnotic melodies are uttered by [target] in place of their voice.", range=4)
					if (OPTION_DERANGEMENT)
						owner.malkavian_voices("A cerebrum blessed with the gift of greater insight; your target sings the same melodies as you.", range=4)
					if (OPTION_GLABRO)
						owner.malkavian_voices("The dichotomy of man and beast leans towards the former in this one; the met twain able to masquerade as human.", range=4)
					if (OPTION_LOGICAL)
						owner.malkavian_voices("A mind able to look inwards, even at the summit of emotion, crowns the one before us.", range=4)
					if (OPTION_ACUTE_SENSES)
						if (HAS_TRAIT(target, TRAIT_ACUTE_HEARING))
							owner.malkavian_voices("The auditory regions of [target] twitch with whispers and words unheard by others.", range=4)
						else if (HAS_TRAIT(target, TRAIT_KEEN_NOSE))
							owner.malkavian_voices("The senses of olfaction before us could pick up even the most faintest scent!", range=4)
						else if (HAS_TRAIT(target, TRAIT_NIGHT_VISION))
							owner.malkavian_voices("The eyes meeting our eyes can pierce even the thickest shroud of darkness.", range=4)
						else if (HAS_TRAIT(target, TRAIT_DETECTIVES_TASTE))
							owner.malkavian_voices("Our target's gustatory system is impressively developed to pick out even the slighest flavours.", range=4)
						else if (HAS_TRAIT(target, TRAIT_SELF_AWARE)) // Touch
							owner.malkavian_voices("A hypersensitive touch is present within [target]; even seeming able to feel things not quite truly there.", range=4)
					if (OPTION_SEIZURES)
						owner.malkavian_voices("The paths of [target]'s neurons are prone to disruption leading to volatile results.", range=4)
					if (OPTION_APPEARANCE)
						if (target.has_quirk(/datum/quirk/darkpack/horrific_appearance))
							owner.malkavian_voices("Our target endures more punishment from their bloodline than most of their ilk — a rot-claimed zombie.", range=4) // Cappadocian Trait
						else if (target.has_quirk(/datum/quirk/darkpack/monstrous))
							owner.malkavian_voices("An inhumanely twisted form is bestowed upon [target]; more abberant than any mortal affliction could do.", range=4)
						else if (target.has_quirk(/datum/quirk/darkpack/disfigured))
							owner.malkavian_voices("The visage before us bares a hideous, yet reasonable, disfigurement.", range=4)
						else if (HAS_TRAIT(target, TRAIT_MASQUERADE_VIOLATING_FACE))
							owner.malkavian_voices("The utter outlandish appeareance we see here could never pass for anything less than the eldritch before the eyes of man.", range=4)
					if (OPTION_HEMOPHILIAC)
						owner.malkavian_voices("The veins and arteries of [target] are a fountain of nourishment.", range=4)
					if (OPTION_ILLITERATE)
						owner.malkavian_voices("The language of words eludes the mind of them, marks of ink without meaning.", range=4)
					if (OPTION_AMNESIA)
						owner.malkavian_voices("Confusion about a time long since past haunts this one's mind.", range=4)
					if (OPTION_VENGEFUL)
						owner.malkavian_voices("A seething vengeance completely overpowers all other thought, a burning requirement for retribution!", range=4)
					if (OPTION_NO_REFLECTION)
						owner.malkavian_voices("The mirrored world found through reflections has no counterpart to [target].", range=4)
					if (OPTION_MASQUERADE_VICTIM)
						owner.malkavian_voices("[target]'s folly of the mind deludes themselves to ignore their new nature — unable to cope with such.", range=4)
					if (OPTION_DAMNED_GRIP)
						owner.malkavian_voices("The sweet kiss of our fangs is instead sullied by a cruel agony within [target].", range=4)
					if (OPTION_THAUMATURGICALLY_INEPT)
						owner.malkavian_voices("Knowledge embedded in all of their clan is mysteriously absent from the blood of this individual.", range=4)
					if (OPTION_THIRD_EYE)
						owner.malkavian_voices("Ancient aspects of this one's bloodline bestows upon them a glaringly conspicuous eye embedded within their forehead.", range=4)
					if (OPTION_TERRITORIAL)
						owner.malkavian_voices("A marked territory is prowled by this predator of the night, a closely guarded feeding ground.", range=4)
					if (OPTION_LIGHT_SENSITIVE)
						owner.malkavian_voices("The judgement of the sun sentences this Kindred harshly; even a brief ray could impart the taste of death upon them.", range=4)
					if (OPTION_MUTE)
						owner.malkavian_voices("An unheard voice shall never leave the mouth of [target].", range=4)
					if (OPTION_BLIND)
						owner.malkavian_voices("The world is percieved as an absence by the eyes of this one — yet still indeed perceived elsewhere.", range=4)
					if (OPTION_DEAF)
						owner.malkavian_voices("Muffled sounds are held back by [target]'s unhearing ears.", range=4)
					if (OPTION_DECEPTIVE_AURA)
						owner.malkavian_voices("The true face of [target] is masked by an aura of lies — pretending to have some semblance of fictitious life.", range=4)
					if (OPTION_PALE_AURA)
						owner.malkavian_voices("The mortal before us has a facade most convincing, the essence of the damned in all but body.", range=4)
					if (OPTION_HOLINESS_REPELLED) // Baali
						owner.malkavian_voices("The sanctified spirit repels the profaned devilry within [target]!", range=4)
					if (OPTION_TECHNOLOGY_REJECTED) // Lasombra
						owner.malkavian_voices("Garbage noise and the hums of static is all the growing technology of the world is willing to impart onto [target].", range=4)
					if (OPTION_METAL_WEAKNESS)
						if (HAS_TRAIT(target, TRAIT_GOLD_WEAKNESS))
							owner.malkavian_voices("Glistening gold bejewels this individual in agonizing pain.", range=4)
						else if (HAS_TRAIT(target, TRAIT_SILVER_WEAKNESS))
							owner.malkavian_voices("Shimmering silver adorns this individual with seering scorches.", range=4)
					if (OPTION_DEATH_STILLNESS) // Gargoyle Trait
						owner.malkavian_voices("Deep-rooted stillness is a comfortable part of the eternal life of this one.", range=4)
					if (OPTION_SENSITIVE_HUMANITY)
						owner.malkavian_voices("Ever-passing days have not crushed this vampire's delicate sense of humanity.", range=4)
					if (OPTION_TIME_SENSE)
						owner.malkavian_voices("An internal clock always seems to point true within [target]", range=4)
					if (OPTION_TIMEWARPER) // Temporis
						owner.malkavian_voices("[target] is within a fractured point of time; we cannot determine from whence they hail.", range=4)
					if (OPTION_VIRTUOSA) // Melpominee
						owner.malkavian_voices("Blood-fueled performance entrances all to this virtuoso before you!", range=4)
					if (OPTION_STAKE_RESISTANCE)
						if (HAS_TRAIT(target, TRAIT_STAKE_RESISTANT))
							owner.malkavian_voices("The heart of this Kindred is not one so easily pierced...", range=4)
						else if (HAS_TRAIT(target, TRAIT_STAKE_IMMUNE))
							owner.malkavian_voices("An arcane shield protects the heart of this Kindred from that aimed true!", range=4)
					if (OPTION_FANGS)
						if (HAS_TRAIT(target, TRAIT_DULLFANGS))
							owner.malkavian_voices("A defanged predator with the bite of a puppy, pitiful.", range=4)
						else if (HAS_TRAIT(target, TRAIT_PERMAFANGS))
							owner.malkavian_voices("Vicious fangs pierce through the gums of [target] with sanguineous pride!", range=4)

#undef OPTION_IMMORTAL_AGE
#undef OPTION_BIOLOGICAL_AGE
#undef OPTION_CLAN
#undef OPTION_TRIBE
#undef OPTION_DISCIPLINES
#undef OPTION_BRAIN_TRAUMA
#undef OPTION_MORALITY_PATH
#undef OPTION_HUMANITY
#undef OPTION_BLOOD_BONDED
#undef OPTION_IS_INFLUENCED
#undef OPTION_IS_DOMINATED
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
#undef OPTION_HAS_SIRE
#undef OPTION_HAS_KILLED
#undef OPTION_FEEDING_SPECIFICATIONS
#undef OPTION_WILL
#undef OPTION_SPIRIT_MARKS
#undef OPTION_VITAE
#undef OPTION_RAGE_FRENZY
#undef OPTION_SEE_GHOSTS
#undef OPTION_BLOOD_HUNGRY
#undef OPTION_SHAPESHIFTING_MODIFIERS
#undef OPTION_PROMETHEAN_CLAY
#undef OPTION_SANGUINE_INCONGRUITY
#undef OPTION_THE_LARGEST_MAW
#undef OPTION_PIERCED_VEIL
#undef OPTION_STOMACH
#undef OPTION_DERANGEMENT
#undef OPTION_GLABRO
#undef OPTION_LOGICAL
#undef OPTION_ACUTE_SENSES
#undef OPTION_SEIZURES
#undef OPTION_APPEARANCE
#undef OPTION_ILLITERATE
#undef OPTION_HEMOPHILIAC
#undef OPTION_AMNESIA
#undef OPTION_VENGEFUL
#undef OPTION_NO_REFLECTION
#undef OPTION_MASQUERADE_VICTIM
#undef OPTION_DAMNED_GRIP
#undef OPTION_THAUMATURGICALLY_INEPT
#undef OPTION_THIRD_EYE
#undef OPTION_TERRITORIAL
#undef OPTION_LIGHT_SENSITIVE
#undef OPTION_MUTE
#undef OPTION_BLIND
#undef OPTION_DEAF
#undef OPTION_DECEPTIVE_AURA
#undef OPTION_PALE_AURA
#undef OPTION_HOLINESS_REPELLED
#undef OPTION_TECHNOLOGY_REJECTED
#undef OPTION_METAL_WEAKNESS
#undef OPTION_DEATH_STILLNESS
#undef OPTION_SENSITIVE_HUMANITY
#undef OPTION_TIME_SENSE
#undef OPTION_TIMEWARPER
#undef OPTION_VIRTUOSA
#undef OPTION_STAKE_RESISTANCE
#undef OPTION_FANGS

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
