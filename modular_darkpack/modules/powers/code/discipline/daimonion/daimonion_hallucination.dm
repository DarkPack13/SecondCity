/obj/effect/client_image_holder/baali_demon
	name = "infernal demon"
	image_icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	image_state = "baali"
	var/mob/living/target //person who had daimonion 4 used on them
	COOLDOWN_DECLARE(move_cooldown)

/obj/effect/client_image_holder/baali_demon/Initialize(mapload, list/mobs_which_see_us)
	. = ..()
	for(var/mob/living/possible_target as anything in mobs_which_see_us)
		target = possible_target
		break // daimonion only has a demon chasing after one target at a time but parent init asks for a list.
	var/turf/closed/wall = locate(/turf/closed) in range(7, target)
	if(!wall)
		return INITIALIZE_HINT_QDEL
	forceMove(wall)
	target.playsound_local(wall, 'sound/effects/meteorimpact.ogg', 150, TRUE)
	START_PROCESSING(SSfastprocess, src)

/obj/effect/client_image_holder/baali_demon/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	target = null
	return ..()

/obj/effect/client_image_holder/baali_demon/process()
	if(QDELETED(target) || target.stat == DEAD)
		qdel(src)
		return
	if(!COOLDOWN_FINISHED(src, move_cooldown))
		return
	setDir(get_dir(src, target))
	forceMove(get_step_towards(src, target))
	target.playsound_local(get_turf(src), 'sound/effects/meteorimpact.ogg', 150, TRUE)
	if(Adjacent(target))
		SEND_SIGNAL(src, COMSIG_BAALI_DEMON_REACHED_TARGET, target)
		qdel(src)
	COOLDOWN_START(src, move_cooldown, 0.4 SECONDS)

/obj/effect/client_image_holder/baali_demon/spectre
	name = "specter"
	image_icon = 'modular_darkpack/modules/deprecated/icons/mob.dmi'
	image_state = "shade"

/obj/effect/client_image_holder/baali_demon/wyrm
	name = "wyrmic avatar"
	image_icon = 'modular_darkpack/modules/deprecated/icons/48x64.dmi'
	image_state = "bigskeleton"

/obj/effect/client_image_holder/baali_demon/tremere
	name = "RECLAIMER"
	image_icon = 'modular_darkpack/modules/deprecated/icons/48x64.dmi'
	image_state = "4armstzi"

/obj/effect/client_image_holder/baali_demon/banu
	name = "LOREMASTER"
	image_icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	image_state = "eva"
