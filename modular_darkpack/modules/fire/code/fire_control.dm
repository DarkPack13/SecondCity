#warn rework all of this

/**
 * Trigger the fire alarm visual affects in an area
 *
 * Updates the fire light on fire alarms in the area and sets all lights to emergency mode
 */

/obj/effect/decal/firecontrol
	name = "fire shower"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rain"
	layer = ABOVE_ALL_MOB_LAYER
	alpha = 28
	var/last_fire_extinguish = 0

/obj/effect/decal/firecontrol/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/decal/firecontrol/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/effect/decal/firecontrol/process(delta_time)
	if(last_fire_extinguish+30 < world.time)
		last_fire_extinguish = world.time
		var/turf/my_turf = get_turf(src)
		for(var/mob/M in my_turf)
			SEND_SOUND(M, sound('modular_darkpack/modules/deprecated/sounds/rain.ogg', 0, 0, CHANNEL_RAIN, 25))
		my_turf.extinguish_turf()

/area/proc/fire_extinguishment()
	if(fire_controling)
		return
	fire_controling = TRUE
	sound_to_players_in_area(src, 'sound/effects/alert.ogg', 100, FALSE)
	set_fire_alarm_effect()
	for(var/turf/open/O in src)
		new /obj/effect/decal/firecontrol(O)
	spawn(300)
		unset_fire_alarm_effects()
		fire_controling = FALSE
		for(var/obj/effect/decal/firecontrol/F in src)
			qdel(F)
