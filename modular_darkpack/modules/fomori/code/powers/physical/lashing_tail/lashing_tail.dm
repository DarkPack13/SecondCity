/datum/bodypart_overlay/simple/fomor_lashing_tail
	icon_state = "lashing_tail"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = list(EXTERNAL_ADJACENT = BODY_FRONT_LAYER)

/obj/item/ammo_casing/magic/fomor_lashing_tail
	projectile_type = /obj/projectile/lashing_tail
	icon_state = ""
	firing_effect_type = null

/obj/projectile/lashing_tail
	name = "lashing tail"
	icon_state = "chronobolt" // Could prob get a better icon for this
	damage = 20
	range = 2
	var/mob/living/firing_mob // Set by /datum/component/lashing_tail

/obj/projectile/lashing_tail/Initialize(mapload)
	if(isliving(fired_from))
		var/mob/living/fired_mob = fired_from

		var/datum/storyteller_roll/attack/attack_roll = new /datum/storyteller_roll/attack
		var/datum/storyteller_roll/attack/damage_roll = new /datum/storyteller_roll/damage
		playsound(fired_from, 'modular_darkpack/modules/fomori/sound/lashing_tail_windup.ogg', 50)
		if(attack_roll.st_roll(fired_mob) == ROLL_SUCCESS)
			damage = damage_roll.st_roll(fired_mob) TTRPG_DAMAGE
		else
			damage = 0

	. = ..()

/obj/projectile/lashing_tail/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/total_ticks = firing_mob.st_get_stat(STAT_STAMINA)
		if(isliving(fired_from))
			var/mob/living/fired_mob = fired_from
			var/datum/splat/fomor_splat = get_fomori_splat(fired_mob)
			var/datum/action/cooldown/power/fomori_power/lashing_tail/linked_power = fomor_splat.get_power(/datum/action/cooldown/power/fomori_power/lashing_tail)
			playsound(src, 'modular_darkpack/modules/fomori/sound/lashing_tail_hit.ogg', 50)
			linked_power.damage_tick(target, 2+total_ticks)
	else if(!isliving(target))
		playsound(src, 'sound/items/pillow/pillow_hit2.ogg', 50) // Flub

/datum/action/cooldown/power/fomori_power/lashing_tail/proc/damage_tick(mob/living/target, ticks_left) // TODO: Fianna gift Resist Toxin blocks these damage ticks
	if(ticks_left > 0)
		target.apply_damage(1 TTRPG_DAMAGE, AGGRAVATED, spread_damage = TRUE) // If this is too strong, devise some way to track a running total per target instead of letting it stack
		addtimer(CALLBACK(src, PROC_REF(damage_tick), target, ticks_left-1), 1 TURNS)

/datum/action/cooldown/power/fomori_power/lashing_tail
	name = "Lashing Tail"
	desc = "Use your tail like a whip to impale your enemies."
	button_icon_state = "lashing_tail"
	rank = 1

	ttrpg_sources = list(/datum/source_book/freak_legion = 31)

	fomor_part = /datum/bodypart_overlay/simple/fomor_lashing_tail

/datum/action/cooldown/power/fomori_power/lashing_tail/Grant(mob/granted_to)
	. = ..()
	owner.AddComponent(/datum/component/lashing_tail)

/datum/action/cooldown/power/fomori_power/lashing_tail/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)
	toggle_feature(deployed)

	if(deployed)
		REMOVE_TRAIT(owner, TRAIT_JUMPING_BLOCKED, "fomor_lashing_tail")
	else
		ADD_TRAIT(owner, TRAIT_JUMPING_BLOCKED, "fomor_lashing_tail")
