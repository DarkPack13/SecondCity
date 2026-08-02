// Used for things that detect masquerade violations.
// Usually NPCs or cameras.
/datum/component/violation_observer
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/datum/proximity_monitor/advanced/violation_check_aoe/area_of_effect
	/// Time between us checking for violations
	COOLDOWN_DECLARE(scan_cooldown)
	var/list/breached_players
	var/aoe_range = 7

/datum/component/violation_observer/Initialize(add_area_of_effect, range) //Only add the AOE checker for NPCs and camera objects.
	if(add_area_of_effect)
		area_of_effect = new(parent, (range || aoe_range))
	breached_players = new()

/datum/component/violation_observer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_SEEN_MASQUERADE_VIOLATION, PROC_REF(on_observed_violation))
	RegisterSignal(parent, COMSIG_MASQUERADE_REINFORCE, PROC_REF(on_masquerade_violation_reinforced))
	RegisterSignals(parent, list(COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE), PROC_REF(on_death))
	if(area_of_effect)
		RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(on_life_rescan))

/datum/component/violation_observer/UnregisterFromParent(force, silent)
	QDEL_NULL(area_of_effect)
	breached_players = null
	UnregisterSignal(parent, list(COMSIG_SEEN_MASQUERADE_VIOLATION, COMSIG_MASQUERADE_REINFORCE, COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE, COMSIG_LIVING_LIFE))

/datum/component/violation_observer/proc/on_life_rescan(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER
	if(!area_of_effect || !COOLDOWN_FINISHED(src, scan_cooldown))
		return
	COOLDOWN_START(src, scan_cooldown, 2 SECONDS)
	for(var/mob/living/carbon/tracked_mob in area_of_effect.tracking_mobs)
		if(HAS_TRAIT(tracked_mob, TRAIT_MASQUERADE_VIOLATING_FACE) && !(tracked_mob.obscured_slots & HIDEFACE))
			SEND_SIGNAL(tracked_mob, COMSIG_MASQUERADE_VIOLATION)
		else if(HAS_TRAIT(tracked_mob, TRAIT_MASQUERADE_VIOLATING_EYES) && !tracked_mob.is_eyes_covered())
			SEND_SIGNAL(tracked_mob, COMSIG_MASQUERADE_VIOLATION)

/datum/component/violation_observer/proc/on_observed_violation(atom/source, mob/living/player_breacher, player_report)
	SIGNAL_HANDLER

	if(!source || !player_breacher || ismundane(player_breacher) || (player_breacher in breached_players))
		return
	var/reporter_descriptor = source
	if(isliving(source))
		var/mob/living/mob_parent = source
		if(HAS_CONNECTED_PLAYER(mob_parent) && !player_report) // return here if a player is piloting the npc and did NOT make a manual report
			return
		if(!INCAPACITATED_IGNORING(mob_parent, INCAPABLE_RESTRAINTS))
			mob_parent.face_atom(player_breacher)
		if(ishuman(source))
			var/mob/living/carbon/human/reporting_human = source
			reporter_descriptor = GET_GUESTBOOK_NAME(reporting_human, player_breacher)

	message_admins("VIOLATION: [ADMIN_LOOKUPFLW(source)] observed a masquerade violation.")
	to_chat(player_breacher, span_userdanger(span_bold("[reporter_descriptor] observed a masquerade violation.")))
	source.observe_masquerade_violation(player_breacher)

	var/mutable_appearance/alert = mutable_appearance('icons/obj/storage/closet.dmi', "cardboard_special")
	SET_PLANE_EXPLICIT(alert, ABOVE_LIGHTING_PLANE, source)
	var/atom/movable/flick_visual/exclamation = source.flick_overlay_view(alert, 1 SECONDS)
	exclamation.alpha = 0
	exclamation.pixel_x = -source.pixel_x
	animate(exclamation, pixel_z = 32, alpha = 255, time = 0.5 SECONDS, easing = ELASTIC_EASING)

	source.AddComponent(/datum/component/masquerade_hud, player_breacher)
	breached_players += player_breacher
	SSmasquerade.masquerade_breach(source, player_breacher, (isliving(source) ? MASQUERADE_REASON_NPC : MASQUERADE_REASON_OBJECT))
	RegisterSignal(player_breacher, COMSIG_LIVING_DEATH, PROC_REF(on_breacher_death))

	return TRUE

/datum/component/violation_observer/proc/on_masquerade_violation_reinforced(atom/source, mob/living/player_breacher)
	SIGNAL_HANDLER

	if(player_breacher in breached_players)
		SEND_SIGNAL(source, COMSIG_MASQUERADE_HUD_DELETE, player_breacher)
		SSmasquerade.masquerade_reinforce(source, player_breacher)
		source.observe_masquerade_reinforce(player_breacher)
		breached_players -= player_breacher
		UnregisterSignal(player_breacher, COMSIG_LIVING_DEATH)
		message_admins("REINFORCED: [ADMIN_LOOKUPFLW(source)] is no longer tracking a breach for [ADMIN_LOOKUPFLW(player_breacher)]")
		to_chat(player_breacher, span_boldnicegreen("[source] is no longer aware of your masquerade violation."))

		return TRUE

/datum/component/violation_observer/proc/on_death(atom/source)
	SIGNAL_HANDLER

	for(var/player_breacher in breached_players)
		SEND_SIGNAL(source, COMSIG_MASQUERADE_HUD_DELETE, player_breacher)
		SSmasquerade.masquerade_reinforce(source, player_breacher)
		source.observe_masquerade_reinforce(player_breacher)
		breached_players -= player_breacher
		UnregisterSignal(player_breacher, COMSIG_LIVING_DEATH)

/datum/component/violation_observer/proc/on_breacher_death(mob/living/dead_breacher, gibbed)
	SIGNAL_HANDLER

	if(dead_breacher in breached_players)
		var/atom/parent_atom = parent
		SEND_SIGNAL(parent, COMSIG_MASQUERADE_HUD_DELETE, dead_breacher)
		SSmasquerade.masquerade_reinforce(parent, dead_breacher)
		parent_atom.observe_masquerade_reinforce(dead_breacher)
		breached_players -= dead_breacher
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
