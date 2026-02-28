/datum/action/cooldown/power/gift/falling_touch
	name = "Falling Touch"
	desc = "This Gift allows the Garou to send her foe sprawling with but a touch."
	button_icon_state = "falling_touch"
	click_to_activate = TRUE

/datum/action/cooldown/power/gift/falling_touch/set_click_ability(mob/on_who)
	. = ..()
	SEND_SOUND(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/falling_touch.ogg')


/datum/action/cooldown/power/gift/falling_touch/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(1, owner)))
		return

	. = ..()

	var/mob/living/victim = target
	var/mob/living/caster = owner
	var/datum/splat/werewolf/casting_splat = iswerewolfsplat(owner)
	var/holding = caster.get_active_held_item()
	if(caster.combat_mode)
		victim.Knockdown(1 TURNS)
		victim.Immobilize(1 TURNS)
		playsound(get_turf(caster), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/falling_touch_activate.ogg', 75, FALSE) // red-tailed hawk sound mixed with disintegrate.ogg
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
		if(holding)
			victim.attackby(holding, caster)
		else
			victim.attack_hand(caster)

		if(casting_splat.rage)
			casting_splat.adjust_rage(-1)
		else
			caster.st_set_stat(STAT_TEMPORARY_WILLPOWER, max((caster.st_get_stat(STAT_TEMPORARY_WILLPOWER) - 1),0))
			to_chat(caster, span_userdanger("You used <b>WILLPOWER</b> to cast [src]!"))
	else
		victim.Knockdown(1 TURNS)
		to_chat(caster, span_notice("You brush up against [victim], knocking them prone!"))
		to_chat(victim, span_userdanger("You fall prone!"))

	StartCooldown()
	return TRUE
