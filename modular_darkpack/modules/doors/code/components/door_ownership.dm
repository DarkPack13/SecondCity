/datum/component/door_ownership
	/// Type of ownership (apartment, car, etc.)
	var/ownership_type = LOCK_OWNERSHIP_APARTMENT

/datum/component/door_ownership/Initialize()

	if(istype(parent, /obj/darkpack_car))
		ownership_type = LOCK_OWNERSHIP_CAR
	else if(istype(parent, /obj/structure/vampdoor))
		ownership_type = LOCK_OWNERSHIP_APARTMENT

/datum/component/door_ownership/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(try_award_key))

/datum/component/door_ownership/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CLICK_ALT)

/datum/component/door_ownership/proc/try_award_key(atom/source, mob/user)
	SIGNAL_HANDLER

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/human = user
	// can only have one apartment key, one car key
	if(ownership_type in human.received_ownership_keys)
		return

	var/lock_id
	if(istype(parent, /obj/darkpack_car))
		var/obj/darkpack_car/car = parent
		lock_id = car.access
	else if(istype(parent, /obj/structure/vampdoor))
		var/obj/structure/vampdoor/door = parent
		lock_id = door.lock_id

	if(!lock_id)
		return

	// async proc because signal handler
	INVOKE_ASYNC(src, PROC_REF(award_key_async), human, lock_id)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/door_ownership/proc/award_key_async(mob/living/carbon/human/human, lock_id)

	var/ownership_question
	var/alert_title

	switch(ownership_type)
		if(LOCK_OWNERSHIP_CAR)
			if(human.st_get_stat(STAT_DRIVE) < 1)
				to_chat(human, span_danger("Shouldnt you learn how to drive before owning a car?"))
				return
			ownership_question = "Is this my car?"
			alert_title = "Vehicle"
		if(LOCK_OWNERSHIP_APARTMENT)
			ownership_question = "Is this my apartment?"
			alert_title = "Apartment"

	var/alert = tgui_alert(human, ownership_question, alert_title, list("Yes", "No"))
	if(alert != "Yes")
		return

	var/spare_key = tgui_alert(human, "Do I have a spare key?", alert_title, list("Yes", "No"))

	var/key_amount = 1
	if(spare_key == "Yes")
		key_amount = 2

	for(var/i in 1 to key_amount)
		var/obj/item/vamp/keys/key = new /obj/item/vamp/keys(get_turf(human))
		key.accesslocks = list("[lock_id]")
		human.put_in_hands(key)

	human.received_ownership_keys += ownership_type
	qdel(src)

