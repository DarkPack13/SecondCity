// The way this completely bypasses the entire power system is so strange
/obj/fusebox
	name = "fuse box"
	desc = "Power the controlled area with pure electricity."
	icon = 'modular_darkpack/modules/electricity/icons/electricity.dmi'
	icon_state = "fusebox"
	base_icon_state = "fusebox"
	layer = SIGN_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_y = 32

	//Damage on the fusebox
	var/damaged = 0
	//If our door is open/closed. bool
	var/open = FALSE
	//Repairing var for the loop
	var/repairing = FALSE
	//Soundloop for Transformers
	var/datum/looping_sound/generator/soundloop

/obj/fusebox/update_icon_state()
	. = ..()
	if(damaged > 100)
		icon_state = "[base_icon_state]_off"
	else
		icon_state = base_icon_state

/obj/fusebox/proc/update_sound_state()
	if(!isnull(soundloop))
		if(damaged > 100)
			soundloop.stop()
		else
			soundloop.start(src)

/obj/fusebox/proc/check_damage(mob/living/user)
	if(damaged > 100 && !open)
		open = TRUE
		var/area/power_area = get_area(src)
		power_area.power_light = FALSE
		power_area.power_equip = FALSE
		power_area.power_environ = FALSE
		power_area.power_change()
		power_area.fire_controled = FALSE
		var/datum/effect_system/spark_spread/local_spark = new /datum/effect_system/spark_spread
		local_spark.set_up(5, 1, get_turf(src))
		local_spark.start()
		for(var/obj/machinery/light/L in power_area)
			L.update(FALSE)
		playsound(loc, 'modular_darkpack/modules/electricity/sounds/generator_break.ogg', 100, TRUE)
		user?.electrocute_act(50, src, siemens_coeff = 1, flags = NONE)
	update_icon()
	update_sound_state()

/obj/fusebox/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		if(!repairing)
			repairing = TRUE
			if(do_after(user, 10 SECONDS, src))
				damaged = 0
				update_icon_state()
				update_sound_state()
				playsound(get_turf(src),'modular_darkpack/modules/electricity/sounds/fusebox_fix.ogg', 50, FALSE)
				var/area/power_area = get_area(src)
				power_area.power_light = TRUE
				power_area.power_equip = TRUE
				power_area.power_environ = TRUE
				power_area.power_change()
				if(initial(power_area.fire_controled))
					power_area.fire_controled = TRUE
				for(var/obj/machinery/light/L in power_area)
					L.update(FALSE)
				repairing = FALSE
			else
				repairing = FALSE
	else
		..()
		if(I.force)
			damaged += I.force
			check_damage(user)

// transformers (another type of fusebox)
/obj/fusebox/transformer
	name = "transformer"
	icon_state = "sstation"
	base_icon_state = "sstation"
	pixel_y = 0
	density = 1

/obj/fusebox/transformer/Initialize(mapload)
	. = ..()
	soundloop = new(src, TRUE)

