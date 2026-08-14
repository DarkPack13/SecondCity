// Used for things that detect masquerade violations.
// Usually NPCs or cameras.
/datum/component/violation_observer
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Time between us checking for violations
	COOLDOWN_DECLARE(scan_cooldown)
	var/list/breached_players

/datum/component/violation_observer/Initialize(add_area_of_effect) //Only add the AOE checker for NPCs and camera objects.
	breached_players = new()

/datum/component/violation_observer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_SEEN_MASQUERADE_VIOLATION, PROC_REF(on_observed_violation))
	RegisterSignal(parent, COMSIG_MASQUERADE_REINFORCE, PROC_REF(on_masquerade_violation_reinforced))
	RegisterSignals(parent, list(COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE), PROC_REF(on_death))

/datum/component/violation_observer/UnregisterFromParent(force, silent)
	breached_players = null
	UnregisterSignal(parent, list(COMSIG_SEEN_MASQUERADE_VIOLATION, COMSIG_MASQUERADE_REINFORCE, COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE))


// violate. sent by comsig_masquerade_violation, checks for mob/living/carbon/human/npc
/atom/proc/on_observed_violation(atom/source, mob/living/player_breacher)
	SIGNAL_HANDLER

	if(!source || !player_breacher || ismundane(player_breacher)) //Humans cant break the masquerade. Because reasons.
		return

	if(isliving(source))
		var/mob/living/mob_parent = source
		if(!INCAPACITATED_IGNORING(mob_parent, INCAPABLE_RESTRAINTS))
			mob_parent.face_atom(player_breacher)
	source.observe_masquerade_violation(player_breacher)

	var/mutable_appearance/alert = mutable_appearance('icons/obj/storage/closet.dmi', "cardboard_special")
	SET_PLANE_EXPLICIT(alert, ABOVE_LIGHTING_PLANE, source)
	var/atom/movable/flick_visual/exclamation = source.flick_overlay_view(alert, 1 SECONDS)
	exclamation.alpha = 0
	exclamation.pixel_x = -source.pixel_x
	animate(exclamation, pixel_z = 32, alpha = 255, time = 0.5 SECONDS, easing = ELASTIC_EASING)

	source.AddComponent(/datum/component/masquerade_hud, player_breacher)
	SSmasquerade.masquerade_breach(source, player_breacher, (isliving(source) ? MASQUERADE_REASON_NPC : MASQUERADE_REASON_OBJECT))
	RegisterSignal(player_breacher, COMSIG_LIVING_DEATH, PROC_REF(on_breacher_death))

	return TRUE

/atom/proc/on_masquerade_violation_reinforced(atom/source, mob/living/player_breacher)
	SIGNAL_HANDLER

	for(var/breach in SSmasquerade.masquerade_breachers)
		if(breach[1] != player_breacher)
			continue
		if(breach[2] != src)
			continue
		SEND_SIGNAL(src, COMSIG_MASQUERADE_HUD_DELETE, player_breacher)
		SSmasquerade.masquerade_reinforce(src, player_breacher)
		src.observe_masquerade_reinforce(player_breacher)
		UnregisterSignal(player_breacher, COMSIG_LIVING_DEATH)

		return TRUE

/atom/proc/on_death()
	SIGNAL_HANDLER

	for(var/breach in SSmasquerade.masquerade_breachers)
		var/mob/living/player_breacher = breach[1]
		var/atom/breach_witness = breach[2]
		if(breach_witness != src)
			continue
		SEND_SIGNAL(src, COMSIG_MASQUERADE_HUD_DELETE, player_breacher)
		SSmasquerade.masquerade_reinforce(src, player_breacher)
		observe_masquerade_reinforce(player_breacher)
		UnregisterSignal(player_breacher, COMSIG_LIVING_DEATH)

/atom/proc/on_breacher_death(mob/living/dead_breacher, gibbed)
	SIGNAL_HANDLER

	for(var/breach in SSmasquerade.masquerade_breachers)
		if(breach[1] != dead_breacher)
			continue
		SEND_SIGNAL(src, COMSIG_MASQUERADE_HUD_DELETE, dead_breacher)
		SSmasquerade.masquerade_reinforce(src, dead_breacher)
		observe_masquerade_reinforce(dead_breacher)
		UnregisterSignal(dead_breacher, COMSIG_LIVING_DEATH)

/atom/proc/observe_masquerade_violation(player_breacher)
	do_alert_animation()
	if(get_werewolf_splat(player_breacher))
		to_chat(player_breacher, span_userdanger(span_bold("VEIL VIOLATION")))
		playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/veil_violation.ogg', 50, FALSE, -5)
		return
	playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/masquerade_violation.ogg', 50, FALSE, -5)
	to_chat(player_breacher, span_userdanger(span_bold("MASQUERADE VIOLATION")))

/atom/proc/observe_masquerade_reinforce(player_breacher)
	if(get_werewolf_splat(player_breacher))
		to_chat(player_breacher, span_big(span_boldnicegreen("VEIL REINFORCED")))
		playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/humanity_gain.ogg', 50, FALSE, -5)
		return
	to_chat(player_breacher, span_big(span_boldnicegreen("MASQUERADE REINFORCED")))
	playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/masquerade_reinforce.ogg', 50, FALSE, -5)
