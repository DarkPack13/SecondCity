#define UI_LIVING_AUSPICE "EAST-2:16,CENTER:40"
#define UI_LIVING_RAGE_AND_GNOSIS "EAST-2:20,CENTER-1:40"
#define UI_LIVING_TRANSFORM_HOMID "EAST-2,CENTER+1:40"
#define UI_LIVING_TRANSFORM_WAR "EAST-1,CENTER+1:40"
#define UI_LIVING_TRANSFORM_FERAL "EAST,CENTER+1:40"

/datum/hud/proc/add_werewolf_elements()
	// transform_werewolf = new(null, src)
	// infodisplay += transform_werewolf

	if(!auspice_icon)
		auspice_icon = new(null, src)
		infodisplay += auspice_icon

	if(!rage_and_gnosis_icon)
		rage_and_gnosis_icon = new(null, src)
		infodisplay += rage_and_gnosis_icon

	if(!homid_trans_icon)
		homid_trans_icon = new(null, src)
		infodisplay += homid_trans_icon
	if(!war_trans_icon)
		war_trans_icon = new(null, src)
		infodisplay += war_trans_icon
	if(!feral_trans_icon)
		feral_trans_icon = new(null, src)
		infodisplay += feral_trans_icon


/datum/splat/werewolf/add_relevent_huds(datum/hud/hud_used)
	hud_used.add_werewolf_elements()

/atom/movable/screen/auspice
	name = "auspice"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_ui.dmi'
	icon_state = "auspice_bar"
	screen_loc = UI_LIVING_AUSPICE
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/used = FALSE

/atom/movable/screen/auspice/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	update_icon()
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

	// TTRPG accurate would be you only do this once at the start of the round.
	if(clicker.last_moon_look != 0 && clicker.last_moon_look + 1 SCENES > world.time)
		return
	clicker.last_moon_look = world.time
	used = TRUE

	to_chat(clicker, span_notice("The phase of the Moon is a [GLOB.moon_state]."))

	update_icon()

	var/rage_amount = 1
	switch(GLOB.moon_state)
		if(MOON_NEW)
			rage_amount = 1
		if(MOON_WANING_GIBBOUS, MOON_WANING_CRESCENT)
			rage_amount = 2
		if(MOON_WAXING_CRESENT, MOON_FIRST_QUARTER, MOON_WAXING_GIBBOUS, MOON_LAST_QUARTER)
			rage_amount = 3
		if(MOON_FULL)
			rage_amount = 4

	if(clicker_splat?.auspice && (GLOB.moon_state in clicker_splat.auspice.moons_born_under))
		#warn I dont think its MAX rage. It might be the default rage of the auspice acctually??
		rage_amount = MAX_RAGE

	clicker_splat.adjust_rage(rage_amount, TRUE)

/atom/movable/screen/auspice/update_icon_state()
	if(used)
		icon_state = "[GLOB.moon_state]"
	return ..()


/mob/living/proc/update_werewolf_hud()
	if(!hud_used)
		return
	hud_used.rage_and_gnosis_icon?.update_icon()

/atom/movable/screen/rage_and_gnosis
	name = "rage and gnosis"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/hud_meters.dmi'
	icon_state = "rage0"
	screen_loc = UI_LIVING_RAGE_AND_GNOSIS

/atom/movable/screen/rage_and_gnosis/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	update_icon()

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

/atom/movable/screen/fera_transform
	abstract_type = /atom/movable/screen/fera_transform
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/hud_transforms.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/datum/species/left_click_transform
	var/datum/species/right_click_transform

/atom/movable/screen/fera_transform/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

	update_icon()
	register_context()

/atom/movable/screen/fera_transform/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/human/clicker = usr
	if(!istype(clicker))
		return
	// if(clicker.stat >= SOFT_CRIT || clicker.IsSleeping() || clicker.IsUnconscious() || clicker.IsParalyzed() || clicker.IsKnockdown() || clicker.IsStun())
	// 	return ..()

	var/datum/splat/werewolf/shifter/shifting = isshifter(clicker)
	var/list/modifiers = params2list(params)
	// Right click for alt forms like glabro and hispo. Ctrl click to use rage to do it instantly (doesnt matter if its breed form tho)
	shifting.transform_fera(LAZYACCESS(modifiers, RIGHT_CLICK) ? right_click_transform : left_click_transform, !!LAZYACCESS(modifiers, CTRL_CLICK))


/atom/movable/screen/fera_transform/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	var/datum/splat/werewolf/shifter/shifting = isshifter(user)

	if(left_click_transform)
		context[SCREENTIP_CONTEXT_LMB] = "Shift to [left_click_transform::name]"
		if(left_click_transform != shifting.get_breed_form())
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "Shift using rage"
	if(right_click_transform)
		context[SCREENTIP_CONTEXT_RMB] = "Shift to [right_click_transform::name]"
		if(right_click_transform != shifting.get_breed_form())
			context[SCREENTIP_CONTEXT_CTRL_RMB] = "Shift using rage"

	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/fera_transform/homid
	name = "homid form"
	icon_state = "homid"
	screen_loc = UI_LIVING_TRANSFORM_HOMID
	left_click_transform = /datum/species/human/shifter/homid
	right_click_transform = /datum/species/human/shifter/bestial

/atom/movable/screen/fera_transform/war
	name = "war form"
	icon_state = "war"
	screen_loc = UI_LIVING_TRANSFORM_WAR
	left_click_transform = /datum/species/human/shifter/war

/atom/movable/screen/fera_transform/feral
	name = "feral form"
	icon_state = "feral"
	screen_loc = UI_LIVING_TRANSFORM_FERAL
	left_click_transform = /datum/species/human/shifter/feral
	right_click_transform = /datum/species/human/shifter/dire

#undef UI_LIVING_TRANSFORM_HOMID
#undef UI_LIVING_TRANSFORM_WAR
#undef UI_LIVING_TRANSFORM_FERAL
#undef UI_LIVING_AUSPICE
#undef UI_LIVING_RAGE_AND_GNOSIS
