/datum/discipline/quietus
	name = "Quietus"
	desc = "Make a poison out of nowhere and forces all beings in range to mute, poison your touch, poison your weapon, poison your spit and make it acid. Violates Masquerade."
	icon_state = "quietus"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/quietus

/datum/discipline_power/quietus
	name = "Quietus power name"
	desc = "Quietus power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/quietus.ogg' // REPLACE THIS PRICE IS RIGHT ASS SOUND!!!

//SILENCE OF DEATH
/datum/discipline_power/quietus/silence_of_death
	name = "Silence of Death"
	desc = "Create an area of pure silence around you, deafening the screams of your targets. This mystical silence radiates from your body, muting all noise within a 7 tile radius."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	vitae_cost = 1
	cancelable = TRUE

	duration_length = 1 SCENES
	cooldown_length = 2 SCENES
	var/datum/proximity_monitor/advanced/silence_of_death/silence_field

/datum/discipline_power/quietus/silence_of_death/activate()
	. = ..()
	silence_field = new(owner, 7, FALSE)

/datum/discipline_power/quietus/silence_of_death/deactivate(atom/target, direct = FALSE)
	. = ..()
	QDEL_NULL(silence_field)

//SCORPION'S TOUCH
/obj/item/melee/touch_attack/quietus
	name = "\improper poison touch"
	desc = "This is kind of like when you rub your feet on a shag rug so you can zap your friends, only a lot less safe."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	hitsound = 'sound/effects/magic/disintegrate.ogg'
	icon_state = "quietus"
	inhand_icon_state = "mansus"
	var/poison_potency = 1
	var/poison_duration = 0

//requires stats preferences
/obj/item/melee/touch_attack/quietus/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(isliving(target))
		var/mob/living/carbon/human/victim = target

		// victim resists the posion with stamina + fortitude
		var/resistance = SSroll.storyteller_roll(dice = (victim.st_get_stat(STAT_STAMINA)/* + victim.st_get_stat(STAT_FORTITUDE)*/), difficulty = 6, numerical = TRUE, mobs_to_show_output = victim)

		// each resistance success subtracts from the duration
		var/effective_duration = max(0, poison_duration - resistance)

		if(effective_duration <= 0)
			to_chat(victim, span_notice("You resist the poison!"))
			to_chat(user, span_warning("[victim] resists your poison!"))
			qdel(src)
			return

		// stamina stat mod reduction goes here

		// Check if victim reaches zero stamina
		if(victim.st_get_stat(STAT_STAMINA) <= 0)
			if(iskindred(victim))
				victim.torpor()
				to_chat(victim, span_userdanger("Your body shuts down as the poison drains your very essence! You enter torpor!"))
				to_chat(user, span_boldwarning("[victim] collapses into torpor!"))
			else
				// apply non transmittable disease to the mortal victim if they reach zero stamina
				to_chat(victim, span_userdanger("You feel deathly ill as the poison ravages your body!"))

		victim.adjustFireLoss(10 * poison_potency) // this is nasty
		//victim.AdjustKnockdown(3 SECONDS) this is from the old code

		to_chat(user, span_warning("Your venomous touch burns [victim]!"))
		to_chat(victim, span_userdanger("You feel a burning poison sap your strength!"))
		qdel(src)
	return ..()


//COMPONENT FOR WEAPON

/datum/discipline_power/quietus/scorpions_touch
	name = "Scorpion's Touch"
	desc = "Create a powerful venom to apply to your enemies."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND

	violates_masquerade = TRUE
	cooldown_length = 1 MINUTES
	var/blood_converted
	var/debuff_duration

/datum/discipline_power/quietus/scorpions_touch/pre_activation_checks(atom/target)
	. = ..()
	var/success_count = SSroll.storyteller_roll(dice = owner.st_get_stat(STAT_WILLPOWER), difficulty = 6, numerical = TRUE, mobs_to_show_output = owner)

	if(success_count <= 0)
		to_chat(owner, span_warning("Your blood fails to transform into poison!"))
		return FALSE

	switch(success_count)
		if(1)
			debuff_duration = 5 TURNS
		if(2)
			debuff_duration = 10 TURNS
		if(3)
			debuff_duration = 20 TURNS
		if(4)
			debuff_duration = 5 MINUTES
		if(5 to INFINITY)
			debuff_duration = 2 SCENES

	//the book says they can use however many dots in stamina they have to convert bloodpoints into poison just FYI
	//so if this were to be lore accurate max_conversion would be owner.st_get_stat(STAT_STAMINA), but it also says 0 stamina = instant torpor so...
	var/max_conversion = 2 // 2 bps max for the stat mod reduction since instantly torporing people is bad
	var/list/bp_options = list()
	for(var/i in 1 to min(max_conversion, owner.bloodpool))
		bp_options += i

	var/choice = tgui_input_list(owner, "How many blood points will you use to create this toxin?", "Scorpion's Touch", bp_options)
	if(!choice)
		return FALSE

	owner.adjust_blood_pool(-choice)

	return TRUE

/datum/discipline_power/quietus/scorpions_touch/activate()
	. = ..()
	owner.drop_all_held_items()
	//this should probably be changed to a normal ranged attack
	owner.put_in_active_hand(new /obj/item/melee/touch_attack/quietus(owner))

//signals_living_mob_carbon.dm for signals or whatever
//DAGON'S CALL
/datum/discipline_power/quietus/dagons_call
	name = "Dagon's Call"
	desc = "Curse the last person you attacked to drown in their own blood."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING

	cooldown_length = 5 SECONDS

/datum/discipline_power/quietus/dagons_call/activate()
	. = ..()
	if(owner.lastattacked)
		if(isliving(owner.lastattacked))
			var/mob/living/L = owner.lastattacked
			L.adjustStaminaLoss(80)
			L.adjustFireLoss(10)
			to_chat(owner, "You send your curse on [L], the last creature you attacked.")
		else
			to_chat(owner, "You don't seem to have last attacked soul earlier...")
			return
	else
		to_chat(owner, "You don't seem to have last attacked soul earlier...")
		return

//BAAL'S CARESS
/datum/discipline_power/quietus/baals_caress
	name = "Baal's Caress"
	desc = "Transmute your vitae into a toxin that destroys all flesh it touches."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND
	vitae_cost = 3
	target_type = TARGET_OBJ
	range = 1

	violates_masquerade = TRUE

	cooldown_length = 15 SECONDS

/datum/discipline_power/quietus/baals_caress/can_activate(atom/target, alert = FALSE)
	. = ..()

	if (!istype(target, /obj/item/melee/vamp))
		if (alert)
			to_chat(owner, span_warning("[src] can only be used on weapons!"))
		return FALSE
	var/obj/item/melee/vamp/weapon = target

	//ensure the target is a weapon with an edge to use the toxin with
	if (!weapon.sharpness)
		if (alert)
			to_chat(owner, span_warning("[src] can only be used on bladed weapons!"))
		return FALSE

	return .

/datum/discipline_power/quietus/baals_caress/activate(obj/item/melee/vamp/target)
	. = ..()
	if(!target.quieted)
		target.quieted = TRUE
		target.armour_penetration = min(100, target.armour_penetration+30)
		target.force += 20
		target.color = "#72b27c"

//TASTE OF DEATH
/obj/projectile/quietus
	name = "acid spit"
	icon_state = "har4ok"
	pass_flags = PASSTABLE
	damage = 80
	damage_type = BURN
	hitsound = 'sound/items/weapons/effects/searwall.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	ricochets_max = 0
	ricochet_chance = 0

/obj/item/gun/magic/quietus
	name = "acid spit"
	desc = "Spit poison on your targets."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "har4ok"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/quietus
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	item_flags = DROPDEL

/obj/item/ammo_casing/magic/quietus
	name = "acid spit"
	desc = "A spit."
	projectile_type = /obj/projectile/quietus
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	item_flags = DROPDEL

/obj/item/gun/magic/quietus/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)
/*
	playsound(target.loc, 'modular_darkpack/modules/deprecated/sounds/quietus.ogg', 50, TRUE)
	target.Stun(5*level_casting)
	if(level_casting >= 3)
		if(target.bloodpool > 1)
			var/transfered = max(1, target.bloodpool-3)
			owner.adjust_blood_points(transfered)
			target.adjust_blood_points(-transfered)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/quietus_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "quietus", -MUTATIONS_LAYER)
		H.overlays_standing[MUTATIONS_LAYER] = quietus_overlay
		H.apply_overlay(MUTATIONS_LAYER)
		spawn(5*level_casting)
			H.remove_overlay(MUTATIONS_LAYER)
*/

/datum/discipline_power/quietus/taste_of_death
	name = "Taste of Death"
	desc = "Spit a glob of caustic blood at your enemies."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND

	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS

/datum/discipline_power/quietus/taste_of_death/activate()
	. = ..()
	owner.drop_all_held_items()
	//should be changed to a ranged attack targeting turfs
	owner.put_in_active_hand(new /obj/item/gun/magic/quietus(owner))
