/obj/item/gun/energy/taser/darkpack
	name = "V26 taser"
	desc = "A less-than-lethal stun gun. Fires an electrode pair that will impale and electrocute noncompliant suspects."
	icon = 'modular_darkpack/modules/taser/icons/taser.dmi'
	icon_state = "taser_wod"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/darkpack)
	charge_sections = 2

/obj/item/ammo_casing/energy/electrode/darkpack
	projectile_type = /obj/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'modular_darkpack/modules/taser/sounds/tasershock.ogg'
	e_cost = LASER_SHOTS(4, STANDARD_CELL_CHARGE)
	harmful = FALSE

/obj/item/melee/baton/security/handtaser
	icon = 'modular_darkpack/modules/taser/icons/taser.dmi'
	icon_state = "handtaser"
	base_icon_state = "handtaser"
	inhand_icon_state = "handtaser"
	worn_icon_state = "baton"
	on_stun_sound = 'modular_darkpack/modules/taser/sounds/handtaser_activate.ogg'

/obj/item/melee/baton/security/handtaser/turn_on(mob/user)
	active = TRUE
	playsound(src, 'modular_darkpack/modules/taser/sounds/electric_zap.ogg', 75, TRUE, -1)
	update_appearance()
	toggle_light()
	do_sparks(1, TRUE, src)
	drop_sound = active_drop_sound
	pickup_sound = active_pickup_sound


/obj/item/melee/baton/security/hand_taser/turn_off()
	active = FALSE
	set_light_on(FALSE)
	update_appearance()
	playsound(src, 'modular_darkpack/modules/taser/sounds/electric_zap.ogg', 75, TRUE, -1)
	drop_sound = inactive_drop_sound
	pickup_sound = inactive_pickup_sound
