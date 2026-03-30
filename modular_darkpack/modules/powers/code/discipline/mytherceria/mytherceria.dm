/datum/discipline/mytherceria
	name = "Mytherceria"
	desc = "Command fae-like powers to beguile and ensorcell your foes."
	icon_state = "mytherceria"
	power_type = /datum/discipline_power/mytherceria

/datum/discipline_power/mytherceria
	name = "Mytherceria power name"
	desc = "Mytherceria power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/kiasyd.ogg'

/**
 * • Folderol - p.455
 *
 * The Kiasyd can cleave truth from lies. The exact effect varies from vampire to vampire.
 * Some Kiasyd experience bleeding from the eyes or ears when they hear
 * a lie, while some Weirdlings’ eyes glow when told a falsehood. Whatever the effect, this power detects lies,
 * not mistakes, meaning that a target has to know he is lying in order for this power to work.
 *
 * The character knows when a target is deliberately lying. No roll or cost associated with this power, but it must be activated
 * by the Kiasyd deliberately. Does not in any way give hints to the truth. Has no effect on people who are not lying intentionally.
 */
/datum/discipline_power/mytherceria/folderol
	name = "Folderol"
	desc = "Detect if a target is deliberately lying."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	target_type = TARGET_PLAYER
	vitae_cost = 0
	cooldown_length = 1 TURNS
	range = 7

/datum/discipline_power/mytherceria/folderol/activate(mob/living/target)
	. = ..()
	var/mob/living/L = target

	SEND_SOUND(L, sound(activate_sound, 0, 0, 50)) // LOOK OUT! THERE'S A FAIRY!

	var/response_w = input(L, "Does your character believe your last statement to be the truth?") in list("Yes", "No")

	if(response_w == "Yes") // Telling the truth!
		to_chat(owner, "<span class='notice'>[L] is not intentionally lying.</span>")
	else if(response_w == "No") // Lying!
		to_chat(owner, "<span class='notice'>[L] is LYING!</span>")
	else // Dunno
		to_chat(owner, "<span class='notice'>[L]'s truthfulness is difficult to determine.</span>")

	log_directed_talk(owner, target, "[owner] used Folderol on [target]. Response: [response_w]", LOG_SAY, "Folderol")
	return

/**
 * •• Fae Sight - p.455
 *
 * The Kiasyd’s knowledge of magic isn’t just theoretical. Their strangely-colored eyes are capable of
 * detecting the arcane energies of the fae, as well as magic from other, more esoteric sources.
 * They are not, however, capable of using this power to detect the residue of ghosts or vampiric magic.
 *
 * The Kiasyd sees faeries and other faetouched mortals for what they really are, no roll required.
 * Additionally, the player can detect ANY magic that is not undead in nature (including ghosts, wraiths, vampires, etc.)
 * This is functionally Scent of the True Form but it can detect magical items and spells as well.
 *
 * TODO: HUD overlays - code/__DEFINES/~darkpack/auras.dm
 *
 */
/datum/discipline_power/mytherceria/fae_sight
	name = "Fae Sight"
	desc = "Sense magical residue and see magical beings for what they really are."

	level = 2
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	range = 7
	duration_length = 1 SCENES
	cooldown_length = 1 SCENES

	toggled = TRUE

/*/datum/discipline_power/mytherceria/fey_sight/activate(mob/living/target)
	. = ..()
	var/list/total_list = list()
	for(var/obj/item/item in target.contents)
		if(istype(item, /obj/item/storage))
			total_list |= item.contents
		total_list |= item
	to_chat(owner, "<span class='purple'>Your fae senses reach out to detect what they're carrying...</span>")
	for(var/obj/item/item in total_list)
		if(item)
			if(item.is_magic)
				to_chat(owner, "- <span class='nicegreen'>[item.name]</span>")
			else if(item.is_iron)
				to_chat(owner, "- <span class='danger'>[item.name]</span>")
			else
				to_chat(owner, "- [item.name]")*/

/datum/discipline_power/mytherceria/fae_sight/activate()
	. = ..()
	var/datum/atom_hud/data/fae_sight_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	target_hud.show_to(owner)

/datum/discipline_power/mytherceria/fae_sight/deactivate()
	. = ..()
	var/datum/atom_hud/data/fae_sight_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	target_hud.hide_from(owner)
	#warn MYTHERCERIA 2 WIP
/**
 * ••• Aura Absorption - p.455-456
 *
 * The Kiasyd is capable of seeing images of events and emotions past by touching an object or an area.
 * However, unlike the Auspex Power The Spirit’s Touch, this power absorbs the images, making them harder for
 * other beings with similar powers to access. Anyone attempting to use this power, Spirit’s Touch,
 * or a similar ability to see what the Kiasyd has seen finds that the images are hard to hold,
 * slipping through his mind’s eye like minnows through a stream.
 *
 * Perception + Empathy roll. Functionally spirits touch but erases whatever's discovered.
 *
 * TODO: If we ever add Natures and/or Demeanors, make them temporarily undetectable unless someone beats the first roll.
 * TODO: "The first Kiasyd’s successes subtract from the number of successes scored by anyone trying to read the object thereafter."
 *
 * TODO: Came back to this a few days later (1/30/26) to find that our implementation of Spirit's Touch isn't robust enough to make this TTRPG accurate. Fix that.
 */
/datum/discipline_power/mytherceria/aura_absorption
	name = "Aura Absorption"
	desc = "Find out something about an object and absorb it's resonance."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS

	toggled = TRUE

/datum/discipline_power/auspex/the_spirits_touch/activate()
	. = ..()

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.show_to(owner)
	owner.update_sight()

	RegisterSignal(owner, COMSIG_MOB_EXAMINING, PROC_REF(scan))

/datum/discipline_power/auspex/the_spirits_touch/deactivate()
	. = ..()

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.hide_from(owner)
	owner.update_sight()

	UnregisterSignal(owner, COMSIG_MOB_EXAMINING)

/datum/discipline_power/mytherceria/aura_absorption/proc/scan(mob/user, atom/scanned_atom, list/examine_strings) // Copypasta
	var/our_power = SSroll.storyteller_roll(owner.st_get_stat(STAT_EMPATHY) + owner.st_get_stat(STAT_PERCEPTION), 6, user, scanned_atom, numerical = TRUE)
	if(isnull(scanned_atom.aura_scanner))
		scanned_atom.aura_scanner = user
		scanned_atom.aura_difficulty = our_power
	else if(!scanned_atom.aura_scanner == user)
		to_chat(user, span_warning("The energy coming from this object is faint... you begin trying to focus on it."))
		if(!do_after(user, max((1 TURNS - our_power SECONDS), 1 SECONDS), scanned_atom, max_interact_count = 1))
			to_chat(user, span_warning("You find it hard to focus on [scanned_atom]."))
			return
		if(scanned_atom.aura_difficulty > our_power)
			to_chat(user, span_warning("You find it hard to focus on [scanned_atom]... like the thoughts are slipping through your mind."))
			return
		else
			to_chat(user, span_nicegreen("[scanned_atom]'s secrets are revealed to you."))
			scanned_atom.aura_scanner = user
			scanned_atom.aura_difficulty = our_power

	// Can scan items we hold and store
	if(!(scanned_atom in user.get_all_contents()))
		// Can remotely scan objects and mobs.
		if((get_dist(scanned_atom, user) > 8) || (!(scanned_atom in view(8, user))))
			return TRUE
	playsound(owner, SFX_INDUSTRIAL_SCAN, 20, TRUE, -2, TRUE, FALSE)

	// GATHER INFORMATION

	var/datum/detective_scanner_log/log_entry = new

	// Start gathering

	log_entry.scan_target = scanned_atom.name

	var/list/atom_fibers = GET_ATOM_FIBRES(scanned_atom)
	if(length(atom_fibers))
		log_entry.add_data_entry(DETSCAN_CATEGORY_FIBER, atom_fibers.Copy())

	var/list/blood = GET_ATOM_BLOOD_DNA(scanned_atom)
	if(length(blood))
		log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, blood.Copy())

	if(ishuman(scanned_atom))
		var/mob/living/carbon/human/scanned_human = scanned_atom
		if(!scanned_human.gloves)
			log_entry.add_data_entry(
				DETSCAN_CATEGORY_FINGERS,
				rustg_hash_string(RUSTG_HASH_MD5, scanned_human.dna?.unique_identity)
			)

	else if(!ismob(scanned_atom))

		var/list/atom_fingerprints = GET_ATOM_FINGERPRINTS(scanned_atom)
		if(length(atom_fingerprints))
			log_entry.add_data_entry(DETSCAN_CATEGORY_FINGERS, atom_fingerprints.Copy())

		// Only get reagents from non-mobs.
		for(var/datum/reagent/present_reagent as anything in scanned_atom.reagents?.reagent_list)
			log_entry.add_data_entry(DETSCAN_CATEGORY_REAGENTS, list(present_reagent.name = present_reagent.volume))

			// Get blood data from the blood reagent.
			if(!istype(present_reagent, /datum/reagent/blood))
				continue

			var/blood_DNA = present_reagent.data["blood_DNA"]
			var/blood_type = present_reagent.data["blood_type"]
			if(!blood_DNA || !blood_type)
				continue

			log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, list(blood_DNA = blood_type))

	if(istype(scanned_atom, /obj/item/card/id))
		var/obj/item/card/id/user_id = scanned_atom
		for(var/region in DETSCAN_ACCESS_ORDER())
			var/access_in_region = SSid_access.accesses_by_region[region] & user_id.GetAccess()
			if(!length(access_in_region))
				continue
			var/list/access_names = list()
			for(var/access_num in access_in_region)
				access_names += SSid_access.get_access_desc(access_num)

			log_entry.add_data_entry(DETSCAN_CATEGORY_ACCESS, list("[region]" = english_list(access_names)))

	// sends it off to be modified by the items
	SEND_SIGNAL(scanned_atom, COMSIG_DETECTIVE_SCANNED, user, log_entry)

	// Perform sorting now, because probably this will be never modified
	log_entry.sort_data_entries()
	var/list/generated_report_text = log_entry.generate_report_text()
	var/output_report = generated_report_text.Join()

	examine_strings += boxed_message(output_report)
	return TRUE

/**
 * •••• Chanjelin Ward - p.455
 *
 * The vampire inscribes a ward on an object, a location, or a person. That ward disorients and befuddles anyone that sees it,
 * meaning that even if an intruder can penetrate a Weirdling’s security and steal an object of value, he’s unlikely to be able to find his way to the exit.
 * Spiteful Kiasyd use these wards as punishment — one story tells of a Weirdling that drew a ward on an enemy’s shirt as dawn approached,
 * and then watched (from safety) as the unfortunate vampire burned in the sun, unable to remember which way to run.
 *
 * When activated, select a target that you can physically touch including an object, a mob, or a turf. The Ward takes 10 seconds if the users
 * Dexterity + Occult is equal to or greater than 5, and takes a mere 5 seconds when the user's Dexterity + Occult is equal to or greater than 8.
 * When placed on an object, anyone coming into contact with that object (such as picking it up or otherwise touching it) suffer a severe movement speed penalty
 * and a short period of randomized controls. When placed on a mob, they also suffer from this penalty. When placed on a turf, it functions as a tripmine.
 */
/datum/storyteller_roll/chanjelin_ward // For resisting it
	bumper_text = "resist (Chanjelin Ward)"
	applicable_stats = list(STAT_WITS, STAT_INVESTIGATION)
	roll_output_type = ROLL_NONE // don't dox the kiasyd if the lemming doesn't notice
	difficulty = 8

/datum/status_effect/confusion/chanjelin_ward/on_creation(mob/living/new_owner, duration = INFINITY)
	return ..()

/datum/discipline_power/mytherceria/chanjelin_ward
	name = "Chanjelin Ward"
	desc = "Place a ward that confuses and befuddles your foes."

	level = 4
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE
	target_type = TARGET_MOB | TARGET_OBJ | TARGET_TURF | TARGET_SELF
	vitae_cost = 0
	cooldown_length = 4 TURNS

/datum/discipline_power/mytherceria/chanjelin_ward/pre_activation_checks(atom/target)
	var/activate_time = max(3 TURNS - (owner.st_get_stat(STAT_DEXTERITY) + owner.st_get_stat(STAT_OCCULT)), 1 SECONDS) // realtime gameplay concession
	to_chat(owner, span_notice("You begin inscribing a ward on [target]."))
	if(!do_after(owner, activate_time, target, interaction_key = "chanjelin_ward", max_interact_count = 1))
		to_chat(owner, span_warning("You decide not to finish the ward and erase your progress."))
		return FALSE
	. = ..()
/*
/datum/discipline_power/mytherceria/chanjelin_ward/activate(atom/target)
	. = ..()
	AddElement(/datum/element/chanjelin_ward, user, target)
*/

/**
 * ••••• The Riddle Phantastique - p.456
 *
 * The Kiasyd whispers a riddle to an opponent, and the riddle consumes his mind.
 * The target can do nothing until he solves the riddle, and no one can help him — answers provided by others,
 * even correct answers, fail to counteract this affliction.
 *
 * When possessed, add an action button to open the riddle manager. Create a new riddle with up to 5 answers.
 * Select a riddle as "active" and when clicking on a target that can hear the Weirdling ask them that riddle aloud.
 * They roll Wits + Occult (difficulty 8) once per turn until they accumulate 3x the successes of the riddler, who rolls Manipulation + Occult..
 * The riddle wears off after 6 turns. If the victim botches a roll, take a large amount of brute damage (30?) and lose all accumulated successes.
 * This damage cannot be healed until the riddle is solved. If a non-victim says the correct answer aloud, the victim is rendered unconcious and
 * is dealt a tremendous amount of brute damage. The riddle can be ended early if the Riddler says the correct answer aloud.
 */
/datum/discipline_power/mytherceria/the_riddle_phantastique
	name = "The Riddle Phantastique"
	desc = "Ensorcel your foe with a riddle that one can do nothing but ponder."

	level = 4
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE | DISC_CHECK_SPEAK
	target_type = TARGET_MOB
	vitae_cost = 0
	cooldown_length = 4 TURNS
	range = 3

/*/datum/discipline_power/mytherceria/the_riddle_phantastique/pre_activation_checks(atom/target)
	if(ismob(target))
		var/mob/living/guy = target
//		if(guy.can_hear()) // could've sworn this was a real proc... replace with real method
			return TRUE

	return FALSE*/
