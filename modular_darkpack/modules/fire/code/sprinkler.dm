/obj/effect/temp_visual/rain
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rain"
	duration = 2 SECONDS

/datum/looping_sound/sprinkler
	mid_sounds = list('modular_darkpack/modules/deprecated/sounds/rain.ogg' = 1)
	mid_length = 1 SECONDS
	volume = 50


/obj/machinery/sprinkler
	name = "fire sprinkler"
	icon = 'modular_darkpack/modules/fire/icons/sprinkler.dmi'
	#warn get better sprite
	icon_state = "sprinkler"
	layer = ABOVE_ALL_MOB_LAYER
	pixel_y = 8
	var/fire_detection_range = 2
	var/sprinkler_spray_range = 5

	var/has_water_reclaimer = TRUE
	var/last_fire_detection
	var/datum/looping_sound/sprinkler/looping_sound

/obj/machinery/sprinkler/Initialize(mapload)
	. = ..()
	looping_sound = new(src)
	create_reagents(5)
	if(src.has_water_reclaimer)
		reagents.add_reagent(/datum/reagent/water, 5)
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_DEFAULT)
	//AddComponent(/datum/component/plumbing/simple_demand)

/obj/machinery/sprinkler/fire_act(exposed_temperature, exposed_volume)
	trigger_sprinkler()
	. = ..()

/obj/machinery/sprinkler/process(seconds_per_tick)
	if(has_water_reclaimer)
		reagents.add_reagent(/datum/reagent/water, 0.5 * seconds_per_tick)

	#warn likely rework to a signal
	if(locate(/obj/effect/abstract/turf_fire) in view(fire_detection_range, src))
		trigger_sprinkler()

	if(is_active())
		looping_sound.start()
		icon_state = "sprinkler_on"
		for(var/turf/open/turf in view(sprinkler_spray_range, src))
			reagents.expose(turf, TOUCH)
			new /obj/effect/temp_visual/rain(turf)
		reagents.remove_all(1 * seconds_per_tick)
	else
		looping_sound.stop()
		icon_state = "sprinkler"

/obj/machinery/sprinkler/proc/trigger_sprinkler()
	//var/area/my_area = get_area(src)
	//if(my_area)
	//	my_area.set_fire_effect(TRUE, AREA_FAULT_AUTOMATIC, name)
	//	my_area.alarm_manager.send_alarm(ALARM_FIRE, src)
	last_fire_detection = world.time

/obj/machinery/sprinkler/proc/is_active()
	if(last_fire_detection && (last_fire_detection + 10 SECONDS > world.time))
		return TRUE
	//var/area/my_area = get_area(src)
	//if(my_area)
	//	return my_area.fire
