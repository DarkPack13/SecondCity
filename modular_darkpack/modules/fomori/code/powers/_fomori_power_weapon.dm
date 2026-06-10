/datum/action/cooldown/power/fomori_power/weapon
	name = "fomor weapon power"
	desc = "Report on github if you see this!"
	cooldown_time = 1 TURNS // Can't sheathe/unsheathe for at least 5 seconds after use

	shared_cooldown = MOB_SHARED_COOLDOWN_2

	feature_bodypart = null // Makes the overlay code skip us unless we define on subtype

	var/sheathe_text = "Your skub melts back into your skin."

	var/weapon_type = /obj/item/skub
	var/unsheathe_sound = 'sound/effects/blob/blobattack.ogg'
	var/sheathe_sound = 'sound/effects/meatslap.ogg'

/datum/action/cooldown/power/fomori_power/weapon/Activate(atom/target)
	var/obj/item/held = owner.get_active_held_item()
	var/obj/item/off_held = owner.get_inactive_held_item()
	if(held && off_held && deployed)
		qdel(held)
		qdel(off_held)
		to_chat(owner, span_warning(sheathe_text))
		playsound(get_turf(owner), sheathe_sound, 50)
		deployed = FALSE
		return

	if(held && !owner.dropItemToGround(held))
		owner.balloon_alert(owner, "hand occupied!")
		return FALSE
	else if(off_held && !owner.dropItemToGround(off_held))
		owner.balloon_alert(owner, "off-hand occupied!")
		return FALSE

	. = ..()

	var/obj/item/weapon = new weapon_type(owner)
	var/obj/item/weapon_offhand = new weapon_type(owner)

	deployed = TRUE

	playsound(get_turf(owner), unsheathe_sound, 50)
	owner.put_in_l_hand(weapon)
	owner.put_in_r_hand(weapon_offhand)





