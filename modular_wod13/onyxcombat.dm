/atom/MouseEntered(location,control,params)
	if(isturf(src) || ismob(src) || isobj(src))
		if(loc && iscarbon(usr))
			var/mob/living/carbon/H = usr
			if(H.a_intent == INTENT_HARM)
				if(!H.IsSleeping() && !H.IsUnconscious() && !H.IsParalyzed() && !H.IsKnockdown() && !H.IsStun() && !HAS_TRAIT(H, TRAIT_RESTRAINED))
					H.face_atom(src)
					H.harm_focus = H.dir

/mob/living/carbon/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	if(a_intent == INTENT_HARM && client)
		setDir(harm_focus)
	else
		harm_focus = dir

/atom/Click(location,control,params)
	if(ishuman(usr))
		if(isopenturf(src.loc) || isopenturf(src))
			var/list/modifiers = params2list(params)
			var/mob/living/carbon/human/HUY = usr
			if(!HUY.get_active_held_item() && Adjacent(usr))
				if(LAZYACCESS(modifiers, "right"))
					var/list/shit = list()
					var/obj/item/item_to_pick
					var/turf/T
					if(isturf(src))
						T = src
					else
						T = src.loc
					for(var/obj/item/I in T)
						if(I)
							if(!I.anchored)
								shit[I.name] = I
						if(length(shit) == 1)
							item_to_pick = I
					if(length(shit) >= 2)
						var/result = input(usr, "Select the item you want to pick up.", "Pick up") as null|anything in shit
						if(result)
							item_to_pick = shit[result]
						else
							return
					if(item_to_pick)
						if(HUY.CanReach(item_to_pick))
							HUY.put_in_active_hand(item_to_pick)
						return
	. = ..()

/mob/living/carbon/werewolf/Life()
	. = ..()
	update_blood_hud()
	update_rage_hud()
	update_auspex_hud()

/mob/living/Initialize(mapload)
	. = ..()
	gnosis = new(src)
	gnosis.icon = 'icons/wod13/48x48.dmi'
	gnosis.plane = ABOVE_HUD_PLANE
	gnosis.layer = ABOVE_HUD_LAYER

/mob/living/proc/update_rage_hud()
	if(!client || !hud_used)
		return
	if(isgarou(src) || iswerewolf(src))
		if(hud_used.rage_icon)
			hud_used.rage_icon.overlays -= gnosis
			var/mob/living/carbon/C = src
			hud_used.rage_icon.icon_state = "rage[C.auspice.rage]"
			gnosis.icon_state = "gnosis[C.auspice.gnosis]"
			hud_used.rage_icon.overlays |= gnosis
		if(hud_used.auspice_icon)
			var/mob/living/carbon/C = src
			if(C.last_moon_look != 0)
				hud_used.auspice_icon.icon_state = "[GLOB.moon_state]"
