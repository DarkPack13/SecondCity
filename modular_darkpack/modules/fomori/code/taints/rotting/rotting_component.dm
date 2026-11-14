/datum/component/rotting
	var/parent_stamina = 1

/datum/component/rotting/Initialize()
	. = ..()
	if(!ishuman(parent))
		return ELEMENT_INCOMPATIBLE
	var/mob/living/carbon/human/human_parent = parent
	parent_stamina = human_parent.st_get_stat(STAT_STAMINA)

	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_apply_damage))

/datum/component/rotting/proc/on_apply_damage(datum/source, damage, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item)
	var/mob/living/carbon/human/human_parent = parent
	switch(damagetype)
		if(TOX, OXY, STAMINA, BRAIN)
			return

	if(damage*((100 - blocked) / 100) > parent_stamina*10)
		var/obj/item/bodypart/target_bodypart
		if(istype(def_zone, /obj/item/bodypart))
			target_bodypart = def_zone
		else
			target_bodypart = human_parent.get_bodypart(def_zone)

		if(istype(def_zone, /obj/item/bodypart/chest) || def_zone == BODY_ZONE_CHEST)
			var/list/elligible_organs = human_parent.organs.Copy()
			if(elligible_organs.len == 0)
				return

			for(var/obj/item/organ/organ in elligible_organs)
				if(istype(organ, /obj/item/organ/brain))
					elligible_organs -= organ
				if(istype(organ, /obj/item/organ/heart) && prob(50)) // Heart is half as likely to be picked as it's an instant kill
					elligible_organs -= organ
			var/obj/item/organ/picked_organ = pick(elligible_organs)
			picked_organ.Remove(human_parent)
			picked_organ.forceMove(human_parent.drop_location())
			picked_organ.throw_at(get_edge_target_turf(human_parent, pick(GLOB.alldirs)), rand(1,3), 5)
			elligible_organs = null
		else
			target_bodypart.dismember(damagetype)

/datum/component/rotting/Destroy()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE)
