/obj/effect/vip_barrier
	name = "Basic Check Point"
	desc = "Not a real checkpoint."
	icon = 'modular_darkpack/modules/npc/icons/barrier.dmi'
	icon_state = "camarilla_blocking"
	can_astar_pass = CANASTARPASS_ALWAYS_PROC
	var/list/allow_list = list()
	var/list/block_list = list("Unknown")
	var/datum/weakref/standing_guard = null
	var/social_roll_difficulty = 7
	var/datum/storyteller_roll/scene_cooldown/bypass_roll

/obj/effect/vip_barrier/Initialize(mapload)
	. = ..()
	for(var/mob/living/carbon/human/npc/bouncer_npc in view(3, src))
		standing_guard = WEAKREF(bouncer_npc)

/obj/effect/vip_barrier/Destroy(force)
	standing_guard = null
	return ..()

/obj/effect/vip_barrier/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(!isliving(mover))
		return TRUE

	if(check_direction_always_allowed(mover))
		return TRUE

	if(check_entry_permission_base(mover))
		return TRUE

	var/has_guard = FALSE
	for(var/mob/living/carbon/human/npc/bouncer_npc in view(1, src))
		if(bouncer_npc == standing_guard.resolve())
			has_guard = TRUE
	if(!has_guard)
		return TRUE

	if(target)
		INVOKE_ASYNC(src, GLOBAL_PROC_REF(playsound), src, 'modular_darkpack/modules/npc/sound/bouncer_blocked.ogg', 50)
	return FALSE

/obj/effect/vip_barrier/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	. = ..()
	. = CanPass(pass_info.requester_ref.resolve(), get_open_turf_in_dir(pass_info.requester_ref.resolve(), to_dir))

/obj/effect/vip_barrier/proc/check_entry_permission_base(mob/living/carbon/human/entering_mob)
	if(LAZYFIND(allow_list, entering_mob.real_name))
		return TRUE

	if(LAZYFIND(block_list, entering_mob.real_name))
		return FALSE

	return check_entry_permission_custom(entering_mob)

/obj/effect/vip_barrier/proc/check_direction_always_allowed(atom/movable/mover)
	if(loc == mover.loc)
		return TRUE
	var/origin_dir = get_dir(src, mover)
	return !(origin_dir & src.dir)

/obj/effect/vip_barrier/proc/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	return TRUE

/obj/effect/vip_barrier/proc/handle_social_bypass(mob/living/carbon/human/user, mob/bouncer, used_stat = STAT_EMPATHY)
	if(user.get_face_name() == "Unknown")
		to_chat(user, span_notice("They won't talk to someone they can't look in the eye."))
		return

	if(check_entry_permission_base(user))
		to_chat(user, span_notice("...But you are already allowed entry."))
		return

	if(LAZYFIND(block_list, user.real_name))
		return

	if(!do_after(user, 1 TURNS, bouncer))
		return

	if(!bypass_roll)
		bypass_roll = new()
		bypass_roll.bumper_text = "persuade guard"
	bypass_roll.difficulty = social_roll_difficulty
	bypass_roll.applicable_stats = list(STAT_CHARISMA)
	var/verbage
	if(used_stat == STAT_INTIMIDATION)
		verbage = "intimidate"
		bypass_roll.applicable_stats += used_stat
	else
		verbage = "persuade"
		bypass_roll.applicable_stats += used_stat

	if(bypass_roll.st_roll(user, src) == ROLL_SUCCESS)
		to_chat(user, span_notice("You manage to [verbage] your way past the guards."))
		allow_list |= user.real_name
		return

	to_chat(user, span_notice("The guards turn you away, taking note of you as they do."))
	block_list |= user.real_name

///////////////////////////////////////////

/obj/effect/vip_barrier/elysium
	name = "Elysium Checkpoint"
	desc = "The barrier between a moonlit night and a world of darkness."
	social_roll_difficulty = 9

/obj/effect/vip_barrier/elysium/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	if(get_kindred_splat(entering_mob) || get_ghoul_splat(entering_mob))
		return TRUE
	return FALSE
