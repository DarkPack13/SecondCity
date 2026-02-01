/obj/item/vtm_artifact/odious_chalice
	true_name = "Odious Chalice"
	true_desc = "Stores blood from every attack."
	icon_state = "o_chalice"
	var/stored_blood = 0
	research_value = 30

/obj/item/vtm_artifact/odious_chalice/examine(mob/user)
	. = ..()
	. += "[src] contains [stored_blood] blood points..."

/obj/item/vtm_artifact/odious_chalice/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		return
	if(!stored_blood)
		return
	if(!identified)
		return
	M.adjust_brute_loss(-5*stored_blood, TRUE)
	M.adjust_fire_loss(-5*stored_blood, TRUE)
	M.update_damage_overlays()
	M.update_health_hud()
	M.update_blood_hud()
	playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
	return
