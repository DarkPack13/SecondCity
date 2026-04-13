/obj/item/occult_artifact/werewolf/dagger_of_retribution
	name = "iron knife"
	desc = "A crude knife wrought from iron."
	true_name = "dagger of retribution"
	true_desc = "An ugly iron dagger imbued with a vengeance-spirit."
	icon = 'modular_darkpack/modules/occult_artifacts/icons/fetishes.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "knife"
	lefthand_file = 'modular_darkpack/modules/occult_artifacts/icons/fetishes_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/occult_artifacts/icons/fetishes_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/occult_artifacts/icons/fetishes_onfloor.dmi')
	icon_state = "dagger"
	force = 30
	wound_bonus = -5
	throwforce = 15
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/slash.ogg'
	armour_penetration = 35
	block_chance = 5
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	subsystem_type = /datum/controller/subsystem/processing/fastprocess

	var/obj/bound_item
	var/spinning


/obj/item/occult_artifact/werewolf/dagger_of_retribution/Initialize(mapload)
	. = ..()
	spirit_type = SPIRIT_VENGEANCE
	spirit_name = generate_spirit_name(spirit_type)


/obj/item/occult_artifact/werewolf/dagger_of_retribution/identify()
	. = ..()
	say("I am [spirit_name]... That which is lost will be found...")

/obj/item/occult_artifact/werewolf/dagger_of_retribution/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("Concentrate on a lost item while holding the dagger; the weapon will gently tug in the direction of the item until you reclaim it.")
		. += span_notice("Bind an item by <b>CLICK</b>ing on it with [src] while on <b><span color='yellow'>GRAB</span></b> intent.")
		. += span_purple("Imbued with [spirit_name].")
		if(bound_item)
			. += span_purple("Bound to [bound_item].")
			if(iscarbon(loc))
				var/mob/living/carbon/C = loc

				var/obj/item/mainhand = C.get_active_held_item()
				var/obj/item/offhand = C.get_inactive_held_item()

				if(mainhand == src || offhand == src)
					. += span_notice("It's tugging you to the [angle2text(angle_between_points(get_turf(src), get_turf(bound_item)))]")


/obj/item/occult_artifact/werewolf/dagger_of_retribution/pickup(mob/user)
	. = ..()
	if(bound_item)
		start_live_tracking(user)


/obj/item/occult_artifact/werewolf/dagger_of_retribution/dropped(mob/M)
	. = ..()
	if(bound_item)
		stop_live_tracking(M)


/*
/obj/item/occult_artifact/werewolf/dagger_of_retribution/pre_attack(atom/target, mob/living/user)
	. = ..()
	if(user.combat_mode) // If we're attacking something, skip all of this stuff.
		return FALSE

	if(!identified)
		return FALSE
	else
		if(istype(target, /obj/item/storage) && !user.a_intent == INTENT_GRAB) // We're trying to store it.
			return FALSE

		if(!istype(target, /obj)) // is it an object?
			if(!istype(target, /turf))
				to_chat(user, span_warning("[src] refuses to be bound to [target]!"))
			return TRUE

		if(!user.a_intent == INTENT_GRAB) // are we on grab intent?
			to_chat(user, span_warning("You need to <b>GRAB</b> [src] tighter if you want to bind it to [target]."))
			return FALSE

		if(bound_item) // do we have an item bound to us already?
			to_chat(user, span_warning("[src] is already bound to [bound_item]!"))
			return TRUE

		// We are clicking on an object, we're on the right intent, and we're not bound.
		bound_item = target
		start_live_tracking(user)
		return TRUE
*/

/obj/item/occult_artifact/werewolf/dagger_of_retribution/attackby(obj/item/I, mob/living/user)
	if(!bound_item)
		bound_item = I
		start_live_tracking()
		return
	else
		. = ..()



/obj/item/occult_artifact/werewolf/dagger_of_retribution/Destroy()
	stop_live_tracking()
	bound_item = null
	return ..()


/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/start_live_tracking(mob/user)
	RegisterSignal(bound_item, COMSIG_QDELETING, PROC_REF(stop_live_tracking))

	if(bound_item && user)
		to_chat(user, span_notice("[src] starts tugging you towards [bound_item]."))

/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/stop_live_tracking(mob/user)
	UnregisterSignal(bound_item, COMSIG_QDELETING)

	if(QDELING(bound_item))
		bound_item = null

	if(user)
		to_chat(user, span_warning("[src] stops tugging."))

	var/matrix/M = matrix(0, MATRIX_ROTATE)
	animate(src, transform = M, time = 5, loop = 0)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/process()
	var/turf/T = get_turf(src)
	var/turf/bound_item_turf = get_turf(bound_item)

	if(T.z == bound_item_turf.z)
		point_to_target()
		spinning = 0
	else if(!spinning)
		SpinAnimation(5, -1)
		spinning = 1

/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/point_to_target()
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc

		var/obj/item/mainhand = C.get_active_held_item()
		var/obj/item/offhand = C.get_inactive_held_item()

		if(mainhand == src || offhand == src)
			var/bound_dir = angle_between_points(get_turf(src), get_turf(bound_item))-135
			if(bound_item)
				var/matrix/M = matrix(bound_dir, MATRIX_ROTATE)
				animate(src, transform = M, time = 5, loop = 0)
			else
				stop_live_tracking(C)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/click_alt(mob/user)
	. = ..()
	if(bound_item)
		to_chat(user, span_warning("You start to unbind [bound_item] from [src]."))

		if(do_after(user, 3 SECONDS, src))
			stop_live_tracking(user)
			bound_item = null
