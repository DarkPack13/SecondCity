/obj/item/occult_artifact/vampire/odious_chalice
	true_name = "Odious Chalice"
	true_desc = "Stores blood from every attack."
	icon_state = "o_chalice"
	var/stored_blood = 0
	research_value = 30
	COOLDOWN_DECLARE(chalice_alert_cooldown)

/obj/item/occult_artifact/vampire/odious_chalice/examine(mob/user)
	. = ..()
	. += "[src] contains [stored_blood] blood points..."

/obj/item/occult_artifact/vampire/odious_chalice/grant_powers()
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_ITEM_ATTACK, PROC_REF(on_attack))

/obj/item/occult_artifact/vampire/odious_chalice/proc/on_attack(mob/living/source, mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!identified)
		return
	var/obj/item/weapon = source.get_active_held_item()
	if(!weapon?.get_sharpness())
		return
	if(!prob(50))
		return
	if(!(src in source.get_all_contents()))
		return
	if(!target.bloodpool && !target.blood_volume)
		return
	stored_blood++
	if(COOLDOWN_FINISHED(src, chalice_alert_cooldown))
		//rather spammy. 1 scene cooldown
		balloon_alert(source, "the chalice drinks...")
		COOLDOWN_START(src, chalice_alert_cooldown, 1 SCENES)

/obj/item/occult_artifact/vampire/odious_chalice/ungrant_powers()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_ITEM_ATTACK)

/obj/item/occult_artifact/vampire/odious_chalice/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!get_kindred_splat(M))
		return
	if(stored_blood <= 0)
		return
	if(!identified)
		return
	M.adjust_brute_loss(-5*stored_blood, TRUE)
	M.adjust_fire_loss(-5*stored_blood, TRUE)
	M.update_damage_overlays()
	M.update_health_hud()
	stored_blood--
	playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
	return
