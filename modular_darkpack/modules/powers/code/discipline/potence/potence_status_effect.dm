/datum/status_effect/potence
	id = "potence"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/level
	var/datum/component/tackler/tackler
	var/list/obj/item/bodypart/affected_bodyparts

/datum/status_effect/potence/on_apply()
	. = ..()
	if (!.)
		return

	if (iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		for (var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if (!istype(limb, /obj/item/bodypart/arm) && !istype(limb, /obj/item/bodypart/leg))
				continue

			LAZYADD(affected_bodyparts, limb)

			limb.unarmed_damage_low += 8 * level
			limb.unarmed_damage_high += 8 * level
			limb.unarmed_attack_sound = 'modular_darkpack/modules/powers/sounds/heavypunch.ogg'
	else if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner

		basic_owner.melee_damage_lower += 8 * level
		basic_owner.melee_damage_upper += 8 * level
		basic_owner.attack_sound = 'modular_darkpack/modules/powers/sounds/heavypunch.ogg'

	RegisterSignal(owner, COMSIG_MOB_ITEM_ATTACK, PROC_REF(apply_melee_modifier))

	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 2 + level, speed = 1, skill_mod = 0, min_distance = 0)

/datum/status_effect/potence/on_remove()
	. = ..()

	if (iscarbon(owner))
		for (var/obj/item/bodypart/limb in affected_bodyparts)
			limb.unarmed_damage_low -= 8 * level
			limb.unarmed_damage_high -= 8 * level
			limb.unarmed_attack_sound = initial(limb.unarmed_attack_sound)
	else if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner

		basic_owner.melee_damage_lower -= 8 * level
		basic_owner.melee_damage_upper -= 8 * level
		basic_owner.attack_sound = initial(basic_owner.attack_sound)

	LAZYCLEARLIST(affected_bodyparts)

	UnregisterSignal(owner, COMSIG_MOB_ITEM_ATTACK)

	qdel(tackler)

/datum/status_effect/potence/proc/apply_melee_modifier(mob/source, mob/M, mob/user, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER

	attack_modifiers[FORCE_MULTIPLIER] += 0.4 * level

// Status effect ranks
/datum/status_effect/potence/one
	level = 1

/datum/status_effect/potence/two
	level = 2

/datum/status_effect/potence/three
	level = 3

/datum/status_effect/potence/four
	level = 4

/datum/status_effect/potence/five
	level = 5
