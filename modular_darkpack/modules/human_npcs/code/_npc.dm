/mob/living/carbon/human/npc
	faction = list(FACTION_NPC)
	ai_controller = /datum/ai_controller/npc
	move_intent = MOVE_INTENT_WALK

	// NPC humans get the area of effect, player humans dont.
	violation_aoe = TRUE

	COOLDOWN_DECLARE(car_dodge)

	/// Used to hold a bunch of global lists for stuff like speech
	var/datum/socialrole/socialrole

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()
	GLOB.human_npc_list += src
	GLOB.alive_human_npc_list += src

	AddElement(/datum/element/ai_retaliate)

/mob/living/carbon/human/npc/Destroy()
	. = ..()
	GLOB.human_npc_list -= src

/mob/living/carbon/human/npc/death(gibbed)
	. = ..()
	GLOB.alive_human_npc_list -= src

/*
/mob/living/carbon/human/npc/RangedAttack(atom/atom_target, modifiers)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fire_gun), atom_target, modifiers)

/mob/living/carbon/human/npc/proc/fire_gun(atom/target, modifiers)
	var/obj/item/gun/gun = locate() in contents
	gun.fire_gun(target, user = src, flag = FALSE, params = modifiers) //still make like a cool click click sound if trying to fire empty
*/

/mob/living/carbon/human/npc/ghoulificate(mob/owner)
	deadchat_broadcast(" is ghoulificating [src].", owner, src)

	AddComponent(\
		/datum/component/ghost_direct_control,\
		ban_type = ROLE_GHOUL,\
		poll_candidates = TRUE,\
		role_name = "[owner]'s ghoul",\
		poll_length = 30 SECONDS,\
		poll_question = "Do you want to play as [owner]'s ghoul?",\

		assumed_control_message = "You are now [owner]'s ghoul!",\
		after_assumed_control = CALLBACK(src, PROC_REF(ghoul_player_controlled), owner)\
	)

	//poll_ignore_key = POLL_IGNORE_GHOUL,

	. = ..()
	return TRUE

/mob/living/carbon/human/npc/proc/ghoul_player_controlled(mob/owner)
	message_admins("[key_name_admin(src)] has became a ghoul by [key_name_admin(owner)].")
	QDEL_NULL(ai_controller)
