/mob/living/carbon/human/npc
	faction = list(FACTION_NPC)
	ai_controller = /datum/ai_controller/npc
	move_intent = MOVE_INTENT_WALK
	var/outfit_type = /datum/outfit/npc

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	equipOutfit(outfit_type)

/mob/living/carbon/human/npc/RangedAttack(atom/atom_target, modifiers)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fire_gun), atom_target, modifiers)

/mob/living/carbon/human/npc/proc/fire_gun(atom/target, modifiers)
	var/obj/item/gun/gun = locate() in contents
	if(!gun.can_shoot())
		if(istype(gun, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/ballistic = gun
			if(!ballistic.chambered || ballistic.bolt_locked)
				ballistic.rack() //we racked so both checked variables should be something else now
			// do we have nothing chambered/chambered is spent AND we have no mag or our mag is empty
			if(!ballistic.chambered?.loaded_projectile && magazine_useless(gun)) // ran out of ammo
				ai_controller?.set_blackboard_key(BB_GUNMIMIC_GUN_EMPTY, TRUE) //BANZAIIIIIIII
				ai_controller?.CancelActions()
		else //if we cant fire we probably like ran out of energy or magic charges or whatever the hell idk
			ai_controller?.set_blackboard_key(BB_GUNMIMIC_GUN_EMPTY, TRUE)
			ai_controller?.CancelActions() // Stop our firing behavior so we can plan melee
	else
		ai_controller?.set_blackboard_key(BB_GUNMIMIC_GUN_EMPTY, FALSE)
	gun.fire_gun(target, user = src, flag = FALSE, params = modifiers) //still make like a cool click click sound if trying to fire empty

/mob/living/carbon/human/npc/proc/magazine_useless(obj/item/gun/ballistic/ballistic)
	if(isnull(ballistic.magazine) || !length(ballistic.magazine.stored_ammo))
		return TRUE
	// is there ATLEAST one unspent round (for the sake of revolvers or a magazine somehow having spent rounds in it)
	for(var/obj/item/ammo_casing/thing as anything in ballistic.magazine.stored_ammo)
		if(ispath(thing))
			return FALSE // unspent
		if(!isnull(thing.loaded_projectile))
			return FALSE //unspent
	return TRUE

/// NPC subtypes

/mob/living/carbon/human/npc/bandit
	ai_controller = /datum/ai_controller/npc/bandit
	outfit_type = /datum/outfit/npc/bandit

/mob/living/carbon/human/npc/rich
	outfit_type = /datum/outfit/npc/rich

/mob/living/carbon/human/npc/average
	outfit_type = /datum/outfit/npc/average

/mob/living/carbon/human/npc/poor
	outfit_type = /datum/outfit/npc/poor

/mob/living/carbon/human/npc/shop
	ai_controller = /datum/ai_controller/npc/stand_still
	outfit_type = /datum/outfit/npc/shop

/mob/living/carbon/human/npc/police
	ai_controller = /datum/ai_controller/npc/police
	outfit_type = /datum/outfit/npc/police

/mob/living/carbon/human/npc/police/standing
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/endron
	ai_controller = /datum/ai_controller/npc/police
	outfit_type = /datum/outfit/npc/endron

/mob/living/carbon/human/npc/endron/standing
	ai_controller = /datum/ai_controller/npc/stand_still
