// ============= HUMAN PROCS =============
// these procs, called on the master, should handle everything.
/mob/living/carbon/human/proc/add_beastmaster_minion(mob/living/simple_animal/hostile/beastmaster/minion_or_type, turf/spawn_location)
	// check minion limit first
	var/max_minions = st_get_stat(STAT_LEADERSHIP) + 1
	if(length(beastmaster_minions) >= max_minions)
		to_chat(src, span_warning("You cannot control more than [max_minions] minion[max_minions > 1 ? "s" : ""]!"))
		return FALSE

	var/mob/living/simple_animal/hostile/beastmaster/minion

	// If given a type path, spawn it. If given an instance, use it directly
	if(ispath(minion_or_type))
		if(!spawn_location)
			spawn_location = get_turf(src)
		minion = new minion_or_type(spawn_location)
	else if(istype(minion_or_type, /mob/living/simple_animal/hostile/beastmaster))
		minion = minion_or_type
	else
		return FALSE

	var/had_minions = length(beastmaster_minions)
	minion.master = src
	beastmaster_minions += minion

	//register beastmaster signals if this is the first minion added to the list
	if(!had_minions && length(beastmaster_minions))
		register_beastmaster_signals()

	return TRUE

/mob/living/carbon/human/proc/remove_beastmaster_minion(mob/living/simple_animal/hostile/beastmaster/minion)
	if(!minion)
		return

	if(minion.master == src)
		minion.master = null

	beastmaster_minions -= minion

	if(!length(beastmaster_minions))
		unregister_beastmaster_signals()

/mob/living/carbon/human/proc/register_beastmaster_signals()
	if(GetComponent(/datum/component/beastmaster_defender))
		return

	AddComponent(/datum/component/beastmaster_defender)

	var/datum/action/beastmaster_stay/stay_action = new()
	stay_action.Grant(src)

	var/datum/action/beastmaster_deaggro/deaggro_action = new()
	deaggro_action.Grant(src)

/mob/living/carbon/human/proc/unregister_beastmaster_signals()
	var/datum/component/beastmaster_defender/component = GetComponent(/datum/component/beastmaster_defender)
	if(component)
		qdel(component)

	for(var/datum/action/beastmaster_stay/action in actions)
		qdel(action)

	for(var/datum/action/beastmaster_deaggro/action in actions)
		qdel(action)

/mob/living/carbon/human/pointed(atom/A as mob|obj|turf in view(client.view, src))
	if(length(beastmaster_minions) && isliving(A))
		for(var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster_minions)
			B.add_beastmaster_enemies(A)

	return ..()

// ============= COMPONENT PROCS =============
/datum/component/beastmaster_defender/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_hit))
	RegisterSignal(parent, COMSIG_ATOM_HITBY, PROC_REF(on_hitby))
	RegisterSignal(parent, COMSIG_MOVABLE_POINTED, PROC_REF(on_beastmaster_point))

/datum/component/beastmaster_defender/Destroy()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_ATTACKBY,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_ATOM_BULLET_ACT,
		COMSIG_ATOM_HITBY,
		COMSIG_MOVABLE_POINTED
	))
	return ..()

/datum/component/beastmaster_defender/proc/on_attack_hand(datum/source, mob/living/user)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = parent
	if(user)
		for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster_minions)
			B.add_beastmaster_enemies(user)

/datum/component/beastmaster_defender/proc/on_bullet_hit(datum/source, obj/projectile/P)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = parent
	if(P?.firer)
		for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster_minions)
			B.add_beastmaster_enemies(P.firer)

/datum/component/beastmaster_defender/proc/on_hitby(datum/source, atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = parent
	if(throwingdatum?.thrower)
		for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster_minions)
			B.add_beastmaster_enemies(throwingdatum.thrower)

/datum/component/beastmaster_defender/proc/on_attackby(datum/source, obj/item/W, mob/living/user, params)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = parent
	if(user && W.force)
		for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster_minions)
			B.add_beastmaster_enemies(user)

/datum/component/beastmaster_defender/proc/on_beastmaster_point(datum/source, atom/pointed_at)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = parent

	if(!isliving(pointed_at))
		return

	for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster_minions)
		B.add_beastmaster_enemies(pointed_at)
