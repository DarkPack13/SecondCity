
/datum/discipline/dementation
	name = "Dementation"
	desc = "Makes all humans in radius mentally ill for a moment, supressing their defending ability."
	icon_state = "dementation"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/dementation

/datum/discipline/dementation/post_gain()
	. = ..()

/datum/discipline_power/dementation
	name = "Dementation power name"
	desc = "Dementation power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/insanity.ogg'

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
	var/dementation_phrase //will be filled when activated via tgui_input_text

/datum/discipline_power/dementation/passion/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA) + target.st_get_stat(STAT_EMPATHY)
	var/theirpower = target.st_get_stat(STAT_WILLPOWER) //if this was their humanity rating as stated in v20, anyone who maxes charisma or empathy (or both) gaurantees this attack to work
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to influence!"))
		return FALSE
	dementation_phrase = tgui_input_text(owner, "What will you say to [target] to stir their emotions?")
	if(!dementation_phrase)
		to_chat(owner, span_warning("You must say something to your target to influence their emotions."))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/passion/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)
	target.Stun(1 TURNS)
	target.emote(pick("laugh","scream","cry")) // pick a random emotion for them to experience
	var/attack_text = spooky_font_replace(dementation_phrase) // malk-ify what the attacker said
	owner.say(attack_text, spans = list("bold", "singing")) // the malk speech uses bold and singing spans
	// TODO: when the derangement port is merged, update the sound paths here
	//owner.playsound_local(get_turf(H), pick('sound/items/SitcomLaugh1.ogg', 'sound/items/SitcomLaugh2.ogg', 'sound/items/SitcomLaugh3.ogg'), 100, FALSE)
	if(target.body_position == STANDING_UP)
		target.toggle_resting()

/datum/discipline_power/dementation/passion/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)


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
	cooldown_length = 3 TURNS
	duration_length = 2 TURNS //this determines how long the visual affected overlay will be applied to their mob sprite, not the hallucination duration
	var/mypower = 0 //store this up here for later use so we can use its value to help determine the duration of the hallucination on a successful roll

/datum/discipline_power/dementation/the_haunting/pre_activation_checks(mob/living/carbon/human/target)
	mypower = owner.st_get_stat(STAT_MANIPULATION) + owner.st_get_stat(STAT_SUBTERFUGE)
	var/theirpower = target.st_get_stat(STAT_PERCEPTION) + target.st_get_stat(STAT_WITS)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to influence!"))
		return FALSE
	var/dementation_phrase = tgui_input_text(owner, "What will you say to [target] to haunt them?")
	if(!dementation_phrase)
		to_chat(owner, span_warning("You must say something to your target to haunt them."))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/the_haunting/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)
	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/delusion/preset), \
			"the haunting", \
			duration = 1 TURNS + (mypower SECONDS), \
			affects_us = FALSE, \
			affects_others = TRUE, \
			skip_nearby = FALSE, \
		)

/datum/discipline_power/dementation/the_haunting/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

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
	cooldown_length = 5 TURNS
	duration_length = 1 TURNS
	activate_sound = null // dont play a sound
	var/choice_options = list("Secrets", "Age")

/datum/discipline_power/dementation/eyes_of_chaos/proc/update_choices()
	for(var/i in choice_options)
		choice_options[i] = icon('icons/effects/effects.dmi', i)

/datum/discipline_power/dementation/eyes_of_chaos/proc/display_select_menu(mob/living/carbon/human/target)
	update_choices()
	var/chosen_option = show_radial_menu(owner, target, choice_options, target, radius = 36, tooltips = TRUE)
	if(!chosen_option)
		return FALSE
	if(!do_after(owner, 2 TURNS))
		return FALSE

	var/exploitable_information = sanitize_text(target.client?.prefs.read_preference(/datum/preference/text/exploitable))
	var/datum/browser/popup = new(owner, "eyes_of_chaos_menu", "Eyes of Chaos", 600, 400)
	var/list/dat = list()
	dat += "<div class='panel redborder'>"
	switch(chosen_option)
		if("Secrets")
			if(exploitable_information == EXPLOITABLE_DEFAULT_TEXT) //they havent set exploitable text
				exploitable_information = "but you do not detect any secrets." //completes the below to_chat string if they havent set any text
			dat += "<BR> <center>[target]</center> <BR> [exploitable_information] <BR></div>"
			popup.set_content(dat.Join())
			popup.open()
		if("Age")
			var/total_age = target.chronological_age
			var/determined_age = "but can't seem to find anything."
			if(total_age < 100)
				determined_age = "[target] is less than a century old."
			else if(total_age < 200)
				determined_age = "[target] is in their second century."
			else
				determined_age = "[target] is an elder."
			to_chat(owner, span_abductor("You search [target]'s mind for information about their age... [determined_age]  DEBUG [total_age]"))


/datum/discipline_power/dementation/eyes_of_chaos/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = owner.st_get_stat(STAT_PERCEPTION) + owner.st_get_stat(STAT_OCCULT)
	var/theirpower = target.st_get_stat(STAT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind resists you!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/eyes_of_chaos/activate(mob/living/carbon/human/target)
	. = ..()
	display_select_menu(target)

/datum/discipline_power/dementation/eyes_of_chaos/deactivate(mob/living/carbon/human/target)
	. = ..()

/*
//VOICE OF MADNESS
/datum/discipline_power/dementation/voice_of_madness
	name = "Voice of Madness"
	desc = "Your voice becomes a source of utter insanity, affecting you and all those around you."

	level = 4

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/voice_of_madness/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/voice_of_madness/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	//change this to something better than an 8 second instastun
	new /datum/hallucination/death(target, TRUE)

/datum/discipline_power/dementation/voice_of_madness/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//TOTAL INSANITY
/datum/discipline_power/dementation/total_insanity
	name = "Total Insanity"
	desc = "Bring out the darkest parts of a person's psyche, bringing them to utter insanity."

	level = 5

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/total_insanity/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/total_insanity/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/attack_myself_command)
	for(var/i in 1 to 20)
		addtimer(cb, (i - 1) * 1.5 SECONDS)

/datum/discipline_power/dementation/total_insanity/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
*/
