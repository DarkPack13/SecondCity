/datum/element/chanjelin_ward
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 1
	// The guy who placed the ward
	var/mob/living/warder

/datum/element/chanjelin_ward/Attach(mob/placed_by, datum/target) // TODO: cover basically every way of interacting with datum/target
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(target, COMSIG_ATOM_BUMPED, PROC_REF(on_bumped))
	RegisterSignal(target, COMSIG_MOB_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(target, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attack_hand))

	if(ismob(target))
		RegisterSignal(target, COMSIG_MOB_ITEM_ATTACK, PROC_REF(on_attacked))

	if(isturf(target))
		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))

/datum/element/chanjelin_ward/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ATOM_EXAMINE))
	UnregisterSignal(target, list(COMSIG_ATOM_BUMPED))
	UnregisterSignal(target, list(COMSIG_MOB_ATTACK_HAND))
	UnregisterSignal(target, list(COMSIG_ATOM_ATTACKBY))

	if(ismob(target))
		UnregisterSignal(target, list(COMSIG_MOB_ITEM_ATTACK))
	if(isturf(target))
		UnregisterSignal(target, list(COMSIG_ATOM_ENTERED))

	return ..()

/datum/element/chanjelin_ward/proc/do_confused(mob/living/user)
	var/confused_text = pick(
		"...huh? ...whuh?",
		"Weird symbol...",
		"What does that mean...?",
		"Where am I...?",
		"Curvy lines...",
		"Woah...",
		"How... what...?",
		)

	user.apply_status_effect(/datum/status_effect/confusion/chanjelin_ward)

	return span_hypnophrase("[confused_text]")

/datum/element/chanjelin_ward/proc/roll_check(mob/living/user) // Returns TRUE if we pass the check, FALSE if we should procede with being Chanjelined
	if(user == warder)
		return TRUE

	if(!isliving(user))
		return TRUE

	var/datum/storyteller_roll/chanjelin_ward/roll_datum = new() // Subtype defined in the main discipline file
	var/check = roll_datum.st_roll(user)

	if(check == ROLL_SUCCESS)
		return TRUE

	return FALSE


/datum/element/chanjelin_ward/proc/on_examine(atom/movable/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(roll_check(user))
		return

	examine_list = list(do_confused(user))

/datum/element/chanjelin_ward/proc/on_bumped(atom/movable/source)
	SIGNAL_HANDLER
	if(!isliving(source))
		return

	var/mob/living/guy = source

	if(roll_check(guy))
		return

	to_chat(guy, do_confused(guy))

/datum/element/chanjelin_ward/proc/on_entered(atom/movable/source, atom/movable/arrived)
	SIGNAL_HANDLER

	if(roll_check(arrived))
		return

	if(isliving(arrived))
		var/mob/living/guy = arrived
		do_confused(guy)
	else
		return

/datum/element/chanjelin_ward/proc/on_attack_hand(atom/movable/source, mob/user)
	SIGNAL_HANDLER

	if(roll_check(user))
		return

	do_confused(user)

/datum/element/chanjelin_ward/proc/on_attacked(atom/movable/source, mob/attacked, mob/attacker)

	if(roll_check(attacker))
		return
#warn chanjelin_ward_element.dm: this is horribly unfinished!
