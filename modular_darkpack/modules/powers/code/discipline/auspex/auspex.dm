#define SENSE_VISION "Vision"
#define SENSE_HEARING "Hearing"
#define SENSE_SMELL "Smell"
#define SENSE_TASTE "Taste"
#define SENSE_TOUCH "Touch"

/datum/discipline/auspex
	name = "Auspex"
	desc = "Allows to see entities, auras and their health through walls."
	icon_state = "auspex"
	power_type = /datum/discipline_power/auspex

/datum/discipline_power/auspex
	name = "Auspex power name"
	desc = "Auspex power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/auspex/auspex.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/auspex/auspex_deactivate.ogg'

//HEIGHTENED SENSES
/datum/discipline_power/auspex/heightened_senses
	name = "Heightened Senses"
	desc = "Enhances your senses far past human limitations."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS

	toggled = TRUE

/datum/discipline_power/auspex/heightened_senses/activate()
	. = ..()

	var/list/chosen_sense = tgui_input_checkboxes(owner, "Choose a sense to heighten", "Heightened Senses", list(
		SENSE_VISION,
		SENSE_HEARING,
		SENSE_SMELL,
		SENSE_TASTE,
		SENSE_TOUCH
	))
	if(isnull(chosen_sense))
		deactivate()
		return
	var/list/output_senses = list()
	for(var/list/sense as anything in chosen_sense)
		output_senses += sense[1]

	if(SENSE_VISION in output_senses)
		owner.client?.view_size?.setTo(2) // This increases the view size of the player by 2 tiles in each direction. I dont know why it's called Set if it Adds.
		ADD_TRAIT(owner, TRAIT_REFLECTIVE_EYES, DISCIPLINE_TRAIT)
		var/obj/item/organ/eyes/kindred_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
		if(kindred_eyes)
			kindred_eyes.flash_protect = max(kindred_eyes.flash_protect += -2, FLASH_PROTECTION_HYPER_SENSITIVE)
	if(SENSE_HEARING in output_senses)
		ADD_TRAIT(owner, TRAIT_GOOD_HEARING, DISCIPLINE_TRAIT)
		var/obj/item/organ/ears/kindred_ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
		kindred_ears.damage_multiplier = kindred_ears.damage_multiplier + 1
	if(SENSE_SMELL in output_senses)
		owner.dna?.add_mutation(/datum/mutation/olfaction, DISCIPLINE_TRAIT)
	if(SENSE_TASTE in output_senses)
		ADD_TRAIT(owner, TRAIT_REAGENT_SCANNER, DISCIPLINE_TRAIT)
	if(SENSE_TOUCH in output_senses)
		RegisterSignals(owner, list(COMSIG_CARBON_HELP_ACT, COMSIG_ON_CARBON_SLIP, COMSIG_LIVING_DISARM_HIT, COMSIG_LIVING_TRYING_TO_PULL), PROC_REF(on_touch))
		owner.AddComponent(/datum/component/heartbeat_sensing, color_path = /datum/client_colour/psyker)

	owner.st_add_stat_mod(STAT_PERCEPTION, discipline.level, "heightened_senses")

/datum/discipline_power/auspex/heightened_senses/deactivate()
	. = ..()
	// Smell
	var/datum/mutation/mutation = owner.dna?.get_mutation(/datum/mutation/olfaction)
	if(mutation)
		owner.dna?.remove_mutation(mutation, mutation.sources)
	// Hearing
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, DISCIPLINE_TRAIT)
	var/obj/item/organ/ears/kindred_ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	kindred_ears.damage_multiplier = initial(kindred_ears.damage_multiplier)
	// Vision
	owner.client?.view_size?.resetToDefault()
	REMOVE_TRAIT(owner, TRAIT_REFLECTIVE_EYES, DISCIPLINE_TRAIT)
	var/obj/item/organ/eyes/kindred_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	if(kindred_eyes)
		kindred_eyes.flash_protect = max(kindred_eyes.flash_protect += 2, FLASH_PROTECTION_NONE)
	// Taste
	REMOVE_TRAIT(owner, TRAIT_REAGENT_SCANNER, DISCIPLINE_TRAIT)
	// Touch
	UnregisterSignal(owner, list(COMSIG_CARBON_HELP_ACT, COMSIG_ON_CARBON_SLIP, COMSIG_LIVING_DISARM_HIT, COMSIG_LIVING_TRYING_TO_PULL))
	qdel(owner.GetComponent(/datum/component/heartbeat_sensing))

	owner.st_remove_stat_mod(STAT_PERCEPTION, "heightened_senses")

/datum/discipline_power/auspex/heightened_senses/proc/on_touch(datum/source)
	SIGNAL_HANDLER

	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "shiver", forced = TRUE)
	owner.Stun(0.5 SECONDS)

//AURA PERCEPTION
/datum/discipline_power/auspex/aura_perception
	name = "Aura Perception"
	desc = "Allows you to perceive the auras of those near you."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS
	duration_length = 1 SCENES
	cooldown_length = 1 SCENES
	vitae_cost = 0

/datum/discipline_power/auspex/aura_perception/activate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.show_to(owner)

/datum/discipline_power/auspex/aura_perception/deactivate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.hide_from(owner)

//THE SPIRIT'S TOUCH
/datum/discipline_power/auspex/the_spirits_touch
	name = "The Spirit's Touch"
	desc = "Allows you to feel the physical wellbeing of those near you."

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

/datum/discipline_power/auspex/the_spirits_touch/proc/scan(mob/user, atom/scanned_atom, list/examine_strings)
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

//TELEPATHY
/datum/discipline_power/auspex/telepathy
	name = "Telepathy"
	desc = "Project your thoughts into the mind of another."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS
	target_type = TARGET_LIVING
	vitae_cost = 0
	cooldown_length = 1 TURNS
	range = 7

/datum/discipline_power/auspex/telepathy/activate(mob/living/target)
	. = ..()
	var/input_message = tgui_input_text(owner, "What message will you project to them?", max_length = MAX_MESSAGE_LEN, encode = FALSE)
	if (!input_message)
		return

	//sanitisation!
	input_message = CAN_BYPASS_FILTER(owner) ? strip_html_full(input_message, MAX_MESSAGE_LEN) : input_message
	var/list/filter_result = CAN_BYPASS_FILTER(owner) ? null : is_ooc_filtered(input_message)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(owner, filter_result)
		log_filter("OOC", input_message, filter_result)
		return

	log_directed_talk(owner, target, input_message, LOG_SAY, "Telepathy")
	to_chat(owner, span_notice("You project your thoughts into [target]'s mind: [input_message]"))
	to_chat(target, span_boldannounce("You hear a voice in your head: [input_message]"))

//PSYCHIC PROJECTION
/datum/discipline_power/auspex/psychic_projection
	name = "Psychic Projection"
	desc = "Leave your body behind and fly across the land."

	willpower_cost = 1
	level = 5
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS

/datum/discipline_power/auspex/psychic_projection/activate()
	. = ..()
	var/roll = SSroll.storyteller_roll(owner.st_get_stat(STAT_PERCEPTION) + owner.st_get_stat(STAT_AWARENESS), 7, owner, owner, TRUE)
	if(roll > 0)
		owner.enter_avatar()
	else
		to_chat(owner, span_warning("Your mind fails to leave your body."))

#undef SENSE_VISION
#undef SENSE_HEARING
#undef SENSE_SMELL
#undef SENSE_TASTE
#undef SENSE_TOUCH
