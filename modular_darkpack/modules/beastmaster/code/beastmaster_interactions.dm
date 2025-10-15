/mob/living/carbon/human/proc/register_beastmaster_signals()
	if(GetComponent(/datum/component/beastmaster_defender))
		return // Already registered
	AddComponent(/datum/component/beastmaster_defender)

/datum/component/beastmaster_defender/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_hit))
	RegisterSignal(parent, COMSIG_ATOM_HITBY, PROC_REF(on_hitby))

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
