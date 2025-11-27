/mob/living/carbon/human/Life()
	if(!iskindred(src))
		if(prob(5))
			adjustAggLoss(-5, TRUE)
	update_blood_hud()
	update_zone_hud()
	update_rage_hud()
	update_shadow()
	if(warrant)
		last_nonraid = world.time
		if(key)
			if(stat != DEAD)
				if(istype(get_area(src), /area/vtm))
					var/area/vtm/V = get_area(src)
					if(V.outdoors)
						last_showed = world.time
						if(last_raid+600 < world.time)
							last_raid = world.time
							for(var/turf/open/O in range(1, src))
								if(prob(25))
									new /obj/effect/temp_visual/desant(O)
							playsound(loc, 'modular_darkpack/modules/deprecated/sounds/helicopter.ogg', 50, TRUE)
				if(last_showed+9000 < world.time)
					to_chat(src, "<b>POLICE STOPPED SEARCHING</b>")
					SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', 0, 0, 75))
					killed_count = 0
					warrant = FALSE
			else
				warrant = FALSE
		else
			warrant = FALSE
	else
		if(last_nonraid+1800 < world.time)
			last_nonraid = world.time
			killed_count = max(0, killed_count-1)

	. = ..()
