/obj/effect/decal/dirt_pile // Should only be used for Earth Meld!
	name = "disturbed earth"
	icon = 'modular_darkpack/modules/powers/icons/dirt_pile.dmi'
	icon_state = "dirt_pile"
	alpha = 64
	var/expiring

/obj/effect/decal/dirt_pile/attackby(obj/item/I, mob/user)
	if(I.tool_behaviour == TOOL_SHOVEL)
		playsound(user, 'sound/effects/shovel_dig.ogg', 100)
		to_chat(user,"You begin to dig up the disturbed earth.")
		if(do_after(user, 20))
			expiring = 1
			if(contents) // Is there a mob in here?
				for(var/mob/living/L in contents)
					to_chat(L, "<span class='warning'>Your resting place is disturbed by [user]!</span>")
					L.forceMove(get_turf(loc))
					L.Knockdown(3 SECONDS) // Get-up lag for anyone hiding in here
					L.SetStun(0) // End the hider's stun to allow them to crawl
			remove_dirt_pile()

/obj/effect/decal/dirt_pile/Initialize(mapload)
	. = ..()
	var/turf/turf_color_to_copy = get_turf(src)
	var/turf/turf_alpha_to_copy = get_turf(src)
	add_atom_colour(turf_color_to_copy.turf_mask_color, FIXED_COLOUR_PRIORITY)
	alpha = (turf_alpha_to_copy.turf_mask_alpha/2)


/obj/effect/decal/dirt_pile/proc/remove_dirt_pile()
	animate(src, alpha = 0, time = 1 SECONDS) // Fade out
	spawn(3 SECONDS)
		qdel(src)

/turf
	var/turf_mask_color = "#FFFFFF"
	var/turf_mask_alpha = 255

/turf/open/floor/plating/vampgrass
	turf_mask_color = "#4A6843"

/turf/open/floor/plating/vampbeach
	turf_mask_color = "#968978"
	turf_mask_alpha = 128

/turf/open/floor/plating/vampdirt
	turf_mask_color = "#725C53"

/turf/open/floor/plating/rough/cave
	turf_mask_color = "#7A7876"
	turf_mask_alpha = 128

/turf/open/floor/plating/stone
	turf_mask_color = "#827E7E"
	turf_mask_alpha = 128

/turf/open/floor/plating/sandy_dirt
	turf_mask_color = "#8C7C56"
	turf_mask_alpha = 128

/turf/open/floor/plating/dirt
	turf_mask_color = "#7A6965"
