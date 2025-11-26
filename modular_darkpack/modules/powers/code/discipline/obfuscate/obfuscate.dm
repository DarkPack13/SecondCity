#define COMBAT_COOLDOWN_LENGTH 45 SECONDS
#define REVEAL_COOLDOWN_LENGTH 15 SECONDS

/datum/discipline/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable for living and un-living beings."
	icon_state = "obfuscate"
	power_type = /datum/discipline_power/obfuscate

/datum/discipline_power/obfuscate
	name = "Obfuscate power name"
	desc = "Obfuscate power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/obfuscate_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/deprecated/sounds/obfuscate_deactivate.ogg'

	power_group = DISCIPLINE_POWER_GROUP_COMBAT

	//need a signal for talking, being attacked
	var/static/list/aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THROW,
		COMSIG_PROJECTILE_PREHIT,
	)

/*
	var/static/list/aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE,
	)
*/

/datum/discipline_power/obfuscate/proc/on_combat_signal(datum/source)
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Your Obfuscate falls away as you reveal yourself!"))
	try_deactivate(direct = TRUE)

	deltimer(cooldown_timer)
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), COMBAT_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/discipline_power/obfuscate/proc/is_seen_check()
	for (var/mob/living/viewer in oviewers(DEFAULT_SIGHT_DISTANCE, owner))
		//cats cannot stop you from Obfuscating
		if (!istype(viewer, /mob/living/carbon) && !viewer.client)
			continue

		//the corpses are not watching you
		//removed (HAS_TRAIT(viewer, TRAIT_BLIND) || -- this needs to be added
		if (viewer.stat >= UNCONSCIOUS)
			continue

		to_chat(owner, span_warning("You cannot use [src] while you're being observed!"))
		return FALSE

	return TRUE

//CLOAK OF SHADOWS
/datum/discipline_power/obfuscate/cloak_of_shadows
	name = "Cloak of Shadows"
	desc = "Meld into the shadows and stay unnoticed so long as you draw no attention."

	level = 1
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/cloak_of_shadows/pre_activation_checks()
	. = ..()
	return is_seen_check()

/datum/discipline_power/obfuscate/cloak_of_shadows/activate()
	. = ..()
	RegisterSignals(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	ADD_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

/datum/discipline_power/obfuscate/cloak_of_shadows/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	REMOVE_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

/datum/discipline_power/obfuscate/cloak_of_shadows/proc/handle_move(datum/source, atom/moving_thing, dir)
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Your [src] falls away as you move from your position!"))
	try_deactivate(direct = TRUE)

	deltimer(cooldown_timer)
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), REVEAL_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

//UNSEEN PRESENCE
/datum/discipline_power/obfuscate/unseen_presence
	name = "Unseen Presence"
	desc = "Move among the crowds without ever being noticed. Achieve invisibility."

	level = 2
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/unseen_presence/pre_activation_checks()
	. = ..()
	return is_seen_check()

/datum/discipline_power/obfuscate/unseen_presence/activate()
	. = ..()
	RegisterSignals(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null

	ADD_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

/datum/discipline_power/obfuscate/unseen_presence/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	REMOVE_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

//remove this when Mask of a Thousand Faces is made tabletop accurate
/datum/discipline_power/obfuscate/unseen_presence/proc/handle_move(datum/source, atom/moving_thing, dir)
	SIGNAL_HANDLER

	if (owner.move_intent != MOVE_INTENT_WALK)
		to_chat(owner, span_danger("Your [src] falls away as you move too quickly!"))
		try_deactivate(direct = TRUE)

		deltimer(cooldown_timer)
		cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), REVEAL_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

//MASK OF A THOUSAND FACES
/datum/discipline_power/obfuscate/mask_of_a_thousand_faces
	name = "Mask of a Thousand Faces"
	desc = "Be noticed, but incorrectly. Hide your identity but nothing else."

	level = 3
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0 // vitae cost handled in activate()

	toggled = TRUE

	var/datum/dna/original_dna
	var/original_name
	var/original_sprite
	var/original_sprite_greyscale

//mask of a thousand faces is supposed to have varying levels of success based on successes rolled
/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/pre_activation_checks()
	var/successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_MANIPULATION) + owner.st_get_stat(STAT_PERFORMANCE), 7, owner, numerical = TRUE)
	if(successes > 0)
		return is_seen_check()
	else
		to_chat(owner, span_warning("You fail to focus your mind on the disguise."))
		return FALSE

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/activate()
	. = ..()

	//this 'only within 12 tiles' limitation is extremely lazy and should be treated as a placeholder for a more robust system down the line
	//probably something like examining the target. COMSIG_ATOM_EXAMINE or something.
	var/list/targets = list()
	for(var/mob/living/carbon/human/H in range(12, owner))
		if(H == owner)
			continue
		targets[H.real_name] = image(icon = H.icon, icon_state = H.icon_state)

	if(!targets.len)
		to_chat(owner, span_warning("There isn't anyone nearby to mimic!"))
		return

	var/chosen_name = show_radial_menu(owner, owner, targets, radius = 40, require_near = TRUE, tooltips = TRUE)
	if(!chosen_name)
		return

	var/mob/living/carbon/human/target
	for(var/mob/living/carbon/human/H in range(12, owner))
		if(H.real_name == chosen_name)
			target = H
			break

	//transforming into someone more attractive than you requires a higher blood investment
	var/appearance_difference = target.st_get_stat(STAT_APPEARANCE) - owner.st_get_stat(STAT_APPEARANCE)
	if(appearance_difference > 1)
		owner.bloodpool = max(owner.bloodpool - appearance_difference, 0)
	else
		owner.bloodpool = max(owner.bloodpool - 1, 0)

	if(!original_dna)
		original_dna = new /datum/dna()
		owner.dna.copy_dna(original_dna, 0)
		original_name = owner.real_name
		if(owner.clan?.alt_sprite)
			original_sprite = owner.clan.alt_sprite
			original_sprite_greyscale = owner.clan.alt_sprite_greyscale
		else
			original_sprite = SPECIES_HUMAN
			original_sprite_greyscale = TRUE

	owner.name = target.name
	owner.real_name = target.real_name
	owner.dna.real_name = target.real_name
	target.dna.copy_dna(owner.dna, 0)

	if(target.clan?.alt_sprite)
		owner.set_body_sprite(target.clan.alt_sprite, target.clan.alt_sprite_greyscale, TRUE)
	else
		if(owner.clan && (TRAIT_MASQUERADE_VIOLATING_FACE in owner.clan.clan_traits))
			REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)
		if(owner.clan && (TRAIT_MASQUERADE_VIOLATING_EYES in owner.clan.clan_traits))
			REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_EYES, MAGIC_TRAIT)
		owner.set_body_sprite(SPECIES_HUMAN, TRUE, TRUE)

	owner.updateappearance(mutcolor_update = TRUE)
	to_chat(owner, span_notice("You assume the appearance of [target.real_name]."))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/deactivate()
	. = ..()
	owner.name = original_name
	owner.real_name = original_name
	owner.dna.real_name = original_name
	original_dna.copy_dna(owner.dna, 0)
	if(owner.clan && (TRAIT_MASQUERADE_VIOLATING_FACE in owner.clan.clan_traits))
		ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)
	if(owner.clan && (TRAIT_MASQUERADE_VIOLATING_EYES in owner.clan.clan_traits))
		ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_EYES, MAGIC_TRAIT)
	owner.set_body_sprite(original_sprite, original_sprite_greyscale, TRUE)
	owner.updateappearance(mutcolor_update = TRUE)
	to_chat(owner, span_notice("You assume your original form."))

//VANISH FROM THE MIND'S EYE
/datum/discipline_power/obfuscate/vanish_from_the_minds_eye
	name = "Vanish from the Mind's Eye"
	desc = "Disappear from plain view, and possibly wipe your past presence from recollection."

	level = 4
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 2

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/vanish_from_the_minds_eye/pre_activation_checks(atom/target)
	if(SSroll.storyteller_roll(owner.st_get_stat(STAT_CHARISMA) + owner.st_get_stat(STAT_STEALTH), 6, owner))
		return TRUE
	return FALSE

/datum/discipline_power/obfuscate/vanish_from_the_minds_eye/activate()
	. = ..()
	RegisterSignals(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	if(prob(1))
		SEND_SIGNAL(SSmasquerade, COMSIG_PLAYER_MASQUERADE_REINFORCE, owner)

	ADD_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

/datum/discipline_power/obfuscate/vanish_from_the_minds_eye/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)

	REMOVE_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

//CLOAK THE GATHERING
/datum/discipline_power/obfuscate/cloak_the_gathering
	name = "Cloak the Gathering"
	desc = "Hide yourself and others, scheme in peace."

	level = 5
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/cloak_the_gathering/activate()
	. = ..()
	RegisterSignals(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	ADD_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

/datum/discipline_power/obfuscate/cloak_the_gathering/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)

	REMOVE_TRAIT(owner, TRAIT_OBFUSCATED, OBFUSCATE_TRAIT)

#undef COMBAT_COOLDOWN_LENGTH
#undef REVEAL_COOLDOWN_LENGTH
