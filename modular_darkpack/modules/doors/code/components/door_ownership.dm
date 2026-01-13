/datum/component/door_ownership
	/// Whether keys are still available to grant
	var/grant_keys = FALSE
	/// Type of ownership (apartment, car, etc.)
	var/ownership_type = "apartment"

/datum/component/door_ownership/Initialize(grant_keys = FALSE)

	src.grant_keys = grant_keys

	if(istype(parent, /obj/darkpack_car))
		ownership_type = "car"
	else if(istype(parent, /obj/structure/vampdoor))
		ownership_type = "apartment"

/datum/component/door_ownership/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(try_award_key))

/datum/component/door_ownership/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_ATTACK_HAND)

/datum/component/door_ownership/proc/try_award_key(atom/source, mob/user)
	SIGNAL_HANDLER

	if(!grant_keys)
		return
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

/datum/component/door_ownership/proc/award_key_async(mob/living/carbon/human/human, lock_id)

	var/ownership_question
	var/alert_title

	switch(ownership_type)
		if("car")
			ownership_question = "Is this my car?"
			alert_title = "Vehicle"
		if("apartment")
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
	grant_keys = FALSE

