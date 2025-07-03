/datum/action/cooldown/blood_power
	name = "Blood Power"
	desc = "Use vitae to gain supernatural abilities."
	button_icon = 'icons/wod13/ui/actions.dmi'
	button_icon_state = "bloodpower"
	background_icon = 'icons/wod13/ui/actions.dmi'
	background_icon_state = "discipline"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_IMMOBILE | AB_CHECK_LYING | AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS
	vampiric = TRUE

	var/datum/armor/old_armor
	var/list/obj/item/bodypart/strengthened_limbs

/datum/action/cooldown/blood_power/IsAvailable(feedback)
	. = ..()

	if (HAS_TRAIT(owner, TRAIT_TORPOR))
		if (feedback)
			owner.balloon_alert(owner, "in Torpor!")
		return FALSE

	if (!ishuman(owner))
		if (feedback)
			owner.balloon_alert(owner, "not human!")
		return FALSE

	var/mob/living/carbon/human/human_owner = owner
	var/cost = HAS_TRAIT(human_owner, TRAIT_HUNGRY) ? 3 : 2
	if (human_owner.bloodpool < cost)
		if (feedback)
			SEND_SOUND(human_owner, sound('sound/wod13/need_blood.ogg', 0, 0, 75))
			owner.balloon_alert(owner, "not enough BLOOD!")
		return FALSE

/datum/action/cooldown/blood_power/Activate(mob/living/target)
	cooldown_time = 10 SECONDS + target.discipline_time_plus + target.bloodpower_time_plus

	. = ..()

	var/mob/living/carbon/human/human_owner = owner

	playsound(usr, 'sound/wod13/bloodhealing.ogg', 50, FALSE)
	to_chat(human_owner, span_notice("You use blood to become more powerful."))

	for (var/obj/item/bodypart/limb in human_owner.bodyparts)
		limb.unarmed_damage_low += 5
		limb.unarmed_damage_high += 5
		LAZYADD(strengthened_limbs, limb)

	old_armor = human_owner.physiology.armor
	human_owner.physiology.armor = old_armor.generate_new_with_modifiers(list(MELEE = 15, BULLET = 15))

	human_owner.dexterity += 2
	human_owner.athletics += 2
	human_owner.lockpicking += 2

	var/cost = HAS_TRAIT(owner, TRAIT_HUNGRY) ? 3 : 2
	human_owner.bloodpool = max(0, human_owner.bloodpool - cost)
	// TODO: [Lucia] reimplement the hud
	//human_owner.update_blood_hud()

	ADD_TRAIT(human_owner, TRAIT_IGNORESLOWDOWN, MAGIC_TRAIT)

	addtimer(CALLBACK(src, PROC_REF(end_bloodpower)), cooldown_time)

/datum/action/cooldown/blood_power/proc/end_bloodpower()
	if (!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner
	to_chat(human_owner, span_warning("You feel like your <b>BLOOD</b> power slowly decreases."))

	for (var/obj/item/bodypart/limb in strengthened_limbs)
		limb.unarmed_damage_low -= 5
		limb.unarmed_damage_high -= 5
	strengthened_limbs = null

	human_owner.physiology.armor = old_armor

	human_owner.dexterity -= 2
	human_owner.athletics -= 2
	human_owner.lockpicking -= 2

	REMOVE_TRAIT(human_owner, TRAIT_IGNORESLOWDOWN, MAGIC_TRAIT)
