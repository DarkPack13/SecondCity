/datum/personality/martyr
	savefile_key = "martyr"
	name = "Martyr"
	desc = "I suffer for the greater good."
	// pos_gameplay_desc = "Likes being inflicted pain"
	pos_gameplay_desc = "Likes being inflicted wounds"

/datum/personality/martyr/apply_to_mob(mob/living/who)
	. = ..()
	// RegisterSignal(who, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(on_take_damage))
	RegisterSignal(who, COMSIG_CARBON_GAIN_WOUND, PROC_REF(on_wound_gain))

/datum/personality/martyr/remove_from_mob(mob/living/who)
	. = ..()
	// UnregisterSignal(who, list(COMSIG_ATOM_TAKE_DAMAGE))

/datum/personality/martyr/proc/on_wound_gain(mob/living/source, datum/wound/gained_wound, obj/item/bodypart/limb)
	SIGNAL_HANDLER

	source.add_mood_event("martyr_pain", /datum/mood_event/martyr_pain)

// I cant remeber what sig humans use
/*
/datum/personality/martyr/proc/on_take_damage(mob/living/carbon/human/target, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, aurmor_penetration)
	SIGNAL_HANDLER
	if(!damage_amount)
		return

	if(damage_type == STAMINA || damage_type == OXY)
		return

	target.add_mood_event("martyr_pain", /datum/mood_event/martyr_pain)
*/

/datum/mood_event/martyr_pain
	description = "I suffer for the greater good."
	mood_change = 5
	timeout = 3 MINUTES


/datum/personality/sadist
	savefile_key = "sadist"
	name = "Sadist"
	desc = "I live to cause pain."
	pos_gameplay_desc = "Likes inflicting pain"

/datum/personality/sadist/apply_to_mob(mob/living/who)
	. = ..()
	RegisterSignal(who, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(unarmed_attack))
	RegisterSignal(who, COMSIG_MOB_ITEM_ATTACK, PROC_REF(item_attack))
	RegisterSignal(who, COMSIG_MOB_TRYING_TO_FIRE_GUN, PROC_REF(trying_to_fire_gun))

/datum/personality/sadist/remove_from_mob(mob/living/who)
	. = ..()
	UnregisterSignal(who, list(COMSIG_LIVING_EARLY_UNARMED_ATTACK, COMSIG_MOB_ITEM_ATTACK, COMSIG_MOB_TRYING_TO_FIRE_GUN))

/datum/personality/sadist/proc/unarmed_attack(mob/living/carbon/human/attacker, atom/target, proximity_flag, modifiers)
	SIGNAL_HANDLER

	if(modifiers[ALT_CLICK] || modifiers[SHIFT_CLICK] || modifiers[CTRL_CLICK] || modifiers[MIDDLE_CLICK])
		return

	if(!proximity_flag || !isliving(target))
		return NONE

	if((attacker.combat_mode || modifiers[RIGHT_CLICK]))
		attacker.add_mood_event("sadist_pain", /datum/mood_event/sadist_pain)

/datum/personality/sadist/proc/item_attack(mob/living/carbon/human/attacker, atom/attacked, list/modifiers)
	SIGNAL_HANDLER

	if(!isliving(attacked))
		return

	var/mob/living/attacked_mob = attacked
	var/obj/item/weapon = attacker.get_active_held_item()

	if(weapon?.item_flags & NOBLUDGEON)
		return

	if(((weapon?.item_flags & NEEDS_PERMIT) || attacker.combat_mode || weapon?.force > 0))
		attacker.add_mood_event("sadist_pain", /datum/mood_event/sadist_pain)

/datum/personality/sadist/proc/trying_to_fire_gun(mob/living/carbon/human/attacker, obj/item/gun/the_gun_in_question, atom/target, flag, params)
	SIGNAL_HANDLER

	if(!isliving(target))
		return

	attacker.add_mood_event("sadist_pain", /datum/mood_event/sadist_pain)

/datum/mood_event/sadist_pain
	description = "I live to cause pain."
	mood_change = 5
	timeout = 3 MINUTES
