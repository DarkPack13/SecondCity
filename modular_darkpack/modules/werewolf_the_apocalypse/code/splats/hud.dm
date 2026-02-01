#define UI_LIVING_AUSPICE "EAST-2:16,CENTER:40"
#define UI_LIVING_RAGE_AND_GNOSIS "EAST-2:20,CENTER-1:40"

/mob/living/carbon/human
	#warn dont leave here.
	var/last_moon_look = 0

/datum/hud/proc/add_werewolf_elements()
	// transform_werewolf = new(null, src)
	// infodisplay += transform_werewolf

	if(!auspice_icon)
		auspice_icon = new(null, src)
		infodisplay += auspice_icon

	if(!rage_and_gnosis_icon)
		rage_and_gnosis_icon = new(null, src)
		infodisplay += rage_and_gnosis_icon

/datum/splat/werewolf/add_relevent_huds(datum/hud/hud_used)
	hud_used.add_werewolf_elements()

/atom/movable/screen/auspice
	name = "Auspice"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_ui.dmi'
	icon_state = "auspice_bar"
	screen_loc = UI_LIVING_AUSPICE
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/used = FALSE

/atom/movable/screen/auspice/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	register_context()

/atom/movable/screen/auspice/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_LMB] = "Check Moon"

	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/auspice/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/human/clicker = usr
	if(!istype(clicker))
		return
	var/datum/splat/werewolf/clicker_splat = iswerewolfsplat(clicker)
	if(!istype(clicker_splat))
		return

	var/area/my_area = get_area(clicker)
	if(!my_area || !my_area.outdoors)
		to_chat(clicker, span_warning("You need to be outside to look at the moon!"))
		return

	if(clicker.last_moon_look != 0 && clicker.last_moon_look + 1 SCENES > world.time)
		return
	clicker.last_moon_look = world.time
	used = TRUE

	to_chat(clicker, span_notice("The phase of the Moon is a [GLOB.moon_state]."))

	update_icon()

	var/rage_amount = 1
	//switch(GLOB.moon_state)
	clicker_splat.adjust_rage(rage_amount, TRUE)

/atom/movable/screen/auspice/update_icon_state()
	if(used)
		icon_state = "[GLOB.moon_state]"
	return ..()

/atom/movable/screen/rage_and_gnosis
	name = "Rage and Gnosis"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/hud_meters.dmi'
	icon_state = "rage0"
	screen_loc = UI_LIVING_RAGE_AND_GNOSIS

/mob/living/proc/update_werewolf_hud()
	if(!hud_used)
		return
	hud_used.rage_and_gnosis_icon?.update_icon()


/atom/movable/screen/rage_and_gnosis/update_icon_state()
	var/mob/living/owner = hud?.mymob
	if(!istype(owner))
		return

	var/datum/splat/werewolf/our_splat = iswerewolfsplat(owner)
	if(!istype(our_splat))
		return

	icon_state = "rage[our_splat.rage]"

	// Should really be in update_overlays but i wanted to keep it to one iswerewolfsplat fetch
	cut_overlays()
	add_overlay("gnosis[our_splat.gnosis]")

	return ..()

#undef UI_LIVING_AUSPICE
#undef UI_LIVING_RAGE_AND_GNOSIS
