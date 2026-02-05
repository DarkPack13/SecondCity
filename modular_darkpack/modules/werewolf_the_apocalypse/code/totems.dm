/obj/structure/werewolf_totem
	abstract_type = /obj/structure/werewolf_totem
	name = "tribe totem"
	desc = "Gives power to all Garou of that tribe and steals it from others."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/totems.dmi'
	icon_state = "wendigo"
	base_icon_state = "wendigo"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	// light_color = "#FFFFFF"
	light_range = 3
	light_power = 0.5

	var/tribes = list()
	var/totem_health = 500 // Fuck you flav.

	COOLDOWN_DECLARE(rage_notify_cd)

	var/turf/teleport_turf
	var/opening = FALSE


/obj/structure/werewolf_totem/Initialize(mapload)
	. = ..()
	for(var/obj/effect/landmark/teleport_mark/T in GLOB.landmarks_list)
		if(T.tribes == tribes)
			teleport_turf = get_turf(T)
	GLOB.totems += src

	update_icon(UPDATE_ICON)

/obj/structure/werewolf_totem/update_icon_state()
	. = ..()

	if(totem_health <= 0)
		icon_state = "[base_icon_state]_broken"
	else
		icon_state = base_icon_state

/obj/structure/werewolf_totem/update_overlays()
	. = ..()

	var/mutable_appearance/totem_light_overlay = mutable_appearance(icon, "[icon_state]_overlay")
	SET_PLANE(totem_light_overlay, ABOVE_LIGHTING_PLANE, src)
	totem_light_overlay.color = light_color
	// totem_light_overlay.layer = ABOVE_LIGHTING_LAYER
	. += totem_light_overlay

/obj/structure/werewolf_totem/Destroy(force)
	. = ..()
	GLOB.totems -= src

// DARKPACK TODO - WEREWOLF - Fuck this not respecting normal integrity

/obj/structure/werewolf_totem/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(attacking_item.force > 0)
		adjust_totem_health(attacking_item)

/obj/structure/werewolf_totem/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE, blocked = null)
	. = ..()
	adjust_totem_health(hitting_projectile.damage)

/obj/structure/werewolf_totem/proc/adjust_totem_health(amount)
	if(amount > 0)
		if(totem_health == 0)
			return
		totem_health = max(0, totem_health-amount)
		if(totem_health <= 0)
			set_light(0)
			update_icon(UPDATE_ICON)
			var/obj/umbra_portal/prev = locate() in get_step(src, SOUTH)
			if(prev)
				qdel(prev.exit)
				qdel(prev)
			notify_fera(amount)
		else
			if(!COOLDOWN_FINISHED(src, rage_notify_cd))
				return
			notify_fera(amount)
			START_COOLDOWN(src, rage_notify_cd, 5 SECONDS)

	if(amount < 0)
		totem_health = min(initial(totem_health), totem_health-amount)
		if(totem_health > 0)
			update_icon(UPDATE_ICON)
			notify_fera(amount)

/obj/structure/werewolf_totem/proc/notify_fera(damage_change)
	for(var/mob/living/carbon/human/human in GLOB.player_list)
		var/datum/splat/werewolf/shifter/shifter_splat = isshifter(human)
		if(!istype(shifter_splat))
			continue
		if(shifter_splat.stat <= DEAD)
			continue
		if(!(shifter.tribe.name in tribes))
			continue

		if(amount > 0)
			if(totem_health <= 0)
				to_chat(human, span_userdanger("<b>YOUR TOTEM IS DESTROYED</b>"))
				SEND_SOUND(human, sound('sound/effects/tendril_destroyed.ogg', 0, 0, 50))
				shifter_splat.adjust_gnosis(-5, FALSE)
			else
				to_chat(human, span_userdanger("<b>YOUR TOTEM IS BREAKING DOWN</b>"))
				SEND_SOUND(human, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/bumps.ogg', 0, 0, 50))
				shifter_splat.adjust_rage(1, FALSE)
		else
			to_chat(human, span_userhelp("<b>YOUR TOTEM IS RESTORED</b>"))
			SEND_SOUND(human, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/inspire.ogg', 0, 0, 50))
			shifter_splat.adjust_gnosis(1, FALSE)

// DARKPACK TODO - WEREWOLF
/*
/obj/structure/werewolf_totem/attack_hand(mob/user)
	. = ..()
	if(iswerewolf(user) || isgarou(user))
		var/mob/living/carbon/C = user
		if(C.a_intent != INTENT_HARM)
			if(totem_health <= 0)
				to_chat(C, span_warning("[src] is broken!"))
				return
			var/obj/umbra_portal/prev = locate() in get_step(src, SOUTH)
			if(!prev)
				if(C.auspice.name == "Theurge")
					if(!opening)
						opening = TRUE
						if(do_mob(user, src, 10 SECONDS))
							playsound(loc, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/portal.ogg', 75, FALSE)
							var/obj/umbra_portal/U = new (get_step(src, SOUTH))
							// New code doesnt relay on ID for these two's connections buy why not.
							U.id = "[tribe][rand(1, 999)]"
							var/obj/umbra_portal/P = new (teleport_turf)
							P.id = U.id
							U.link_portal(P)
							opening = FALSE
						else
							opening = FALSE
				else
					to_chat(C, span_warning("You need a Theurge to open the Moon Gates!"))
			else
				if(C.auspice.name == "Theurge")
					playsound(loc, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/portal.ogg', 75, FALSE)
					qdel(prev.exit)
					qdel(prev)
		else
			adjust_totem_health(round(C.melee_damage_lower/2))
*/

/obj/structure/werewolf_totem/wendigo
	name = "Galestalkers Totem"
	tribes = list(TRIBE_GALESTALKERS)
	light_color = "#81ff4f"

/obj/structure/werewolf_totem/children_of_gaia
	name = "Children of Gaia Totem"
	tribes = list(TRIBE_CHILDREN_OF_GAIA)
	light_color = "#00CEC8"

/obj/structure/werewolf_totem/bone_gnawer
	name = "Bone Gnawer Totem""
	light_color = "#FFA500"
	tribes = list(TRIBE_BONEGNAWERS)

/obj/structure/werewolf_totem/glasswalker
	name = "\improper Glasswalker totem"
	icon_state = "glassw"
	base_icon_state = "glassw"
	light_color = "#35b0ff"
	tribes = list(TRIBE_GLASSWALKERS)

/obj/structure/werewolf_totem/spiral
	name = "spiral totem"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/spiral_totem.dmi'
	icon_state = "spiral"
	base_icon_state = "spiral"
	light_color = "#ff5235"
	tribes = list(TRIBE_BLACK_SPIRAL_DANCERS)


/obj/structure/werewolf_totem/generic
	light_color = "#81ff4f"
	tribes = TRIBE_GAIA

/obj/structure/werewolf_totem/generic/wyld
	icon_state = "glassw"
	base_icon_state = "glassw"
	light_color = "#00CEC8"
	tribes = TRIBE_WYLD

/obj/structure/werewolf_totem/generic/weaver
	icon_state = "glassw"
	base_icon_state = "glassw"
	light_color = "#35b0ff"
	tribes = TRIBE_WEAVER

/obj/structure/werewolf_totem/generic/wyrm
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/spiral_totem.dmi'
	icon_state = "spiral"
	base_icon_state = "spiral"
	light_color = "#ff5235"
	tribes = TRIBE_WYRM

/obj/structure/werewolf_totem/generic/alltribes
	tribes = TRIBE_ALL


/obj/effect/landmark/teleport_mark
	name = "Teleport"
	icon_state = "x"
	var/tribes
