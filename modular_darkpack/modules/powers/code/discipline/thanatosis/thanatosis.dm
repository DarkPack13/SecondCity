/datum/discipline/thanatosis
	name = "Thanatosis"
	desc = "Offers control over your own rotted body"
	icon_state = "thanatosis"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/thanatosis

/datum/discipline_power/thanatosis
	name = "Thanatosis power name"
	desc = "Thanatosis power description"

//HAG'S WRINKLES
/datum/discipline_power/thanatosis/hag_wrinkles
	name = "Hag's Wrinkles"
	desc = "Morph your face to become unknowing."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 1

	activate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg'
	deactivate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1off.ogg'

	cancelable = TRUE
	duration_length = 1 HOURS

/datum/discipline_power/thanatosis/hag_wrinkles/pre_activation_checks()
	. = ..()
	var/dice = owner.st_get_stat(STAT_STAMINA) + owner.st_get_stat(STAT_SUBTERFUGE)
	var/roll = SSroll.storyteller_roll(dice, 8, owner)
	if(roll == ROLL_SUCCESS)
		return TRUE
	else
		return FALSE

/datum/discipline_power/thanatosis/hag_wrinkles/activate()
	. = ..()

	var/obj/item/implant/storage/imp = new()
	imp.implant(owner, owner)


/datum/discipline_power/thanatosis/hag_wrinkles/deactivate()
	. = ..()
	for(var/obj/item/implant/storage/i in owner.implants)
		i.removed(owner)

//PUTREFACTION
/datum/discipline_power/thanatosis/putrefaction
	name = "Putrefaction"
	desc = "Rot and Decay at a Touch."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	vitae_cost = 1

	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy2.ogg'

	violates_masquerade = TRUE

	range = 1
	cooldown_length = 5 SECONDS
	var/successes

/datum/discipline_power/thanatosis/putrefaction/pre_activation_checks(mob/living/target)
	. = ..()
	var/fortitudelevel
	var/totaldice
	var/totaldiff
	var/mob/living/carbon/human/vampire = target
	var/datum/splat/vampire/kindred/kindred_splat = iskindred(vampire)
	if(kindred_splat)
		var/datum/discipline/fortitude/fortitude_check = kindred_splat.get_discipline(/datum/discipline/fortitude)
		if(fortitude_check)
			fortitudelevel = fortitude_check.level


	totaldice = (owner.st_get_stat(STAT_DEXTERITY) + owner.st_get_stat(STAT_MEDICINE))
	totaldiff = (target.st_get_stat(STAT_STAMINA) + fortitudelevel)
	successes = SSroll.storyteller_roll(totaldice, totaldiff, owner, numerical = TRUE)

	if(successes > 0)
		return TRUE
	else
		to_chat(owner, span_warning("Putrefaction has failed to affect [target]!"))
		return FALSE

/datum/discipline_power/thanatosis/putrefaction/activate(mob/living/target)
	. = ..()
	target.adjust_brute_loss(successes * 25)
	target.apply_status_effect(STATUS_EFFECT_PUTREFACTION, owner)

//ASHES TO ASHES
/mob/living/basic/samedi_ash_pile
	name = "ash"
	desc = "Ashes to ashes, dust to dust, and into space."
	icon = 'icons/obj/debris.dmi'
	icon_state = "ash"
	icon_living = "ash"
	speed = 2 //'the character cannot move'
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_verb_continuous = "splashes"
	attack_verb_simple = "splash"

/datum/action/cooldown/spell/shapeshift/samedi_ash
	name = "Ashes to Ashes"
	desc = "Turn into ash to hide."
	button_icon_state = "ash"

	possible_shapes = list(/mob/living/basic/samedi_ash_pile)
	convert_damage = TRUE
	convert_damage_type = BRUTE

/datum/discipline_power/thanatosis/ashes_to_ashes
	name = "Ashes to Ashes"
	desc = "Turn into ash to hide."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	vitae_cost = 2

	activate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy3.ogg'

	violates_masquerade = TRUE
	toggled = TRUE
	cancelable = TRUE
	duration_length = 0
	cooldown_length = 1 TURNS

	var/datum/action/cooldown/spell/shapeshift/samedi_ash/dust_transformation

/datum/discipline_power/thanatosis/ashes_to_ashes/activate()
	. = ..()
	if(dust_transformation)
		CRASH("[src] somehow already has a spell?")
	owner.drop_all_held_items()
	dust_transformation = new(owner.mind)
	dust_transformation.Grant(owner)
	dust_transformation.Activate(owner)
	RegisterSignal(owner, COMSIG_LIVING_RETURNED_FROM_SHAPESHIFT, PROC_REF(deactivate))

/datum/discipline_power/thanatosis/ashes_to_ashes/deactivate()
	UnregisterSignal(owner, COMSIG_LIVING_RETURNED_FROM_SHAPESHIFT)
	. = ..()
	dust_transformation.Remove(owner)
	QDEL_NULL(dust_transformation)
	owner.Stun(1.5 SECONDS)
	owner.do_jitter_animation(30)


//WITHERING
/datum/discipline_power/thanatosis/withering
	name = "Withering"
	desc = "Wither Bodies into Decay"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 1
	willpower_cost = 1

	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy4.ogg'

	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 1 TURNS
	var/successes

/datum/discipline_power/thanatosis/withering/pre_activation_checks(mob/living/target)
	. = ..()
	var/fortitudelevel
	var/totaldice
	var/totaldiff
	var/mob/living/carbon/human/vampire = target
	var/datum/splat/vampire/kindred/kindred_splat = iskindred(vampire)
	if(kindred_splat)
		var/datum/discipline/fortitude/fortitude_check = kindred_splat.get_discipline(/datum/discipline/fortitude)
		if(fortitude_check)
			fortitudelevel = fortitude_check.level

	totaldice = (owner.st_get_stat(STAT_MANIPULATION) + owner.st_get_stat(STAT_MEDICINE))
	totaldiff = (target.st_get_stat(STAT_STAMINA) + fortitudelevel)
	successes = SSroll.storyteller_roll(totaldice, totaldiff, owner, numerical = TRUE)

	if(successes > 0)
		return TRUE
	else
		to_chat(owner, span_warning("Withering has failed to affect [target]!"))
		return FALSE

/datum/discipline_power/thanatosis/withering/activate(mob/living/target)
	. = ..()

	if((successes >= 1) && (successes < 3))
		target.adjust_stamina_loss(60)
	else if(successes >= 3)
		if(iscarbon(target))
			var/mob/living/carbon/deady = target
			var/obj/item/bodypart/target_part = deady.get_bodypart(check_zone(owner.zone_selected))
			if(ishumanbasic(target))
				if(target_part.name == "head")
					target.visible_message(span_danger("[target]'s head withers into a nub and falls off!"), span_userdanger("Your last thoughts was that your head was getting smaller"))
					var/obj/item/bodypart/head/head = target.get_bodypart(BODY_ZONE_HEAD)
					head.dismember()
				if(target_part.name == "chest")
					target.visible_message(span_danger("[target]'s left arm withers into nothingness!"), span_userdanger("YOUR LEFT ARM WITHERS INTO NOTHING!"))
					var/obj/item/bodypart/overflow = target.get_bodypart(BODY_ZONE_L_ARM)
					overflow.dismember(BURN)
				else
					target.visible_message(span_danger("[target]'s [target_part.name] withers into nothingness!"), span_userdanger("YOUR <b>[target_part.name]</b> WITHERS INTO NOTHING!"))
					target_part.dismember(BURN)
			//if(iscoraxcrinos(target) || iscrinos(target) || islupus(target) || iscorax(target))
				//target.adjust_brute_loss(30 * successes)
			//else
				//var/datum/wound/blunt/critical/crit_wound = new
				//crit_wound.apply_wound(target_part)
		else
			target.adjust_brute_loss(200)

//NECROSIS
/datum/discipline_power/thanatosis/necrosis
	name = "Necrosis"
	desc = "A more horrific version of Putrefaction"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_HUMAN
	vitae_cost = 2
	range = 1
	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy5.ogg'

	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
	var/successes

/datum/discipline_power/thanatosis/necrosis/pre_activation_checks(mob/living/carbon/human/target)
	. = ..()
	var/fortitudelevel
	var/totaldice
	var/totaldiff
	var/mob/living/carbon/human/vampire = target
	var/datum/splat/vampire/kindred/kindred_splat = iskindred(vampire)
	if(kindred_splat)
		var/datum/discipline/fortitude/fortitude_check = kindred_splat.get_discipline(/datum/discipline/fortitude)
		if(fortitude_check)
			fortitudelevel = fortitude_check.level

	totaldice = (owner.st_get_stat(STAT_DEXTERITY) + owner.st_get_stat(STAT_MEDICINE))
	totaldiff = (target.st_get_stat(STAT_STAMINA) + fortitudelevel)
	successes = SSroll.storyteller_roll(totaldice, totaldiff, owner, numerical = TRUE)

	if(successes > 0)
		return TRUE
	else
		to_chat(owner, span_warning("Necrosis has failed to affect [target]!"))
		return FALSE

/datum/discipline_power/thanatosis/necrosis/activate(mob/living/carbon/human/target)
	. = ..()
	target.adjust_brute_loss(30 * successes)

	if(successes <= 1)
		to_chat(owner, span_warning("Necrosis has failed to affect [target]!"))
		return
	switch(successes)
		if(1)
			return
		if(2)
			target.apply_status_effect(STATUS_EFFECT_PUTREFACTION, owner)
		if(3)
			target.apply_status_effect(STATUS_EFFECT_PUTREFACTION, owner)
			if(iscarbon(target))
				for(var/i in target.bodyparts)
					var/obj/item/bodypart/bodypart = i
					var/datum/wound/burn/flesh/moderate/burnt = new
					burnt.apply_wound(bodypart)
		if(4)
			target.apply_status_effect(STATUS_EFFECT_PUTREFACTIONTWO, owner)
			if(iscarbon(target))
				for(var/i in target.bodyparts)
					var/obj/item/bodypart/bodypart = i
					var/datum/wound/burn/flesh/severe/burnt = new
					burnt.apply_wound(bodypart)
		if(5)
			target.apply_status_effect(STATUS_EFFECT_PUTREFACTIONTHREE, owner)
			if(iscarbon(target))
				for(var/i in target.bodyparts)
					var/obj/item/bodypart/bodypart = i
					var/datum/wound/burn/flesh/critical/burnt = new
					burnt.apply_wound(bodypart)
		else
			target.apply_status_effect(STATUS_EFFECT_PUTREFACTIONFOUR, owner)
			if(iscarbon(target))
				for(var/i in target.bodyparts)
					var/obj/item/bodypart/bodypart = i
					var/datum/wound/burn/flesh/critical/burnt = new
					burnt.apply_wound(bodypart)
