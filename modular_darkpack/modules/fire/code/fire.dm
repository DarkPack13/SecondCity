/*
/obj/effect/abstract/turf_fire
	name = "fire"
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "fire"
	layer = FLY_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/stage = 1
	plane = ABOVE_LIGHTING_PLANE
	layer = ABOVE_LIGHTING_LAYER

/obj/structure
	var/pepeled = FALSE

/obj/structure/proc/pepel()
	if(!pepeled)
		pepeled = TRUE
		color = "#808080"

/obj/effect/abstract/turf_fire/proc/handle_automated_spread()
	playsound(get_turf(src), 'modular_darkpack/modules/deprecated/sounds/fire.ogg', 80, TRUE)
	var/area/AR = get_area(src)
	if(AR.fire_controled)
		AR.fire_extinguishment()
	for(var/obj/effect/decal/cleanable/gasoline/G in loc)
		qdel(G)
	for(var/mob/living/L in loc)
		L.fire_stacks += 5
		L.IgniteMob()
		L.apply_damage(10*stage, BURN, BODY_ZONE_CHEST)
	for(var/obj/machinery/light/M in loc)
		if(M.status != LIGHT_BROKEN && M.status != LIGHT_EMPTY)
			M.break_light_tube()
	for(var/obj/S in loc)
		var/breakable = TRUE
		if(S.resistance_flags & INDESTRUCTIBLE)
			breakable = FALSE
		if(breakable)
			S.fire_act(1000)
		if(istype(S, /obj/structure/flora/tree/vamp))
			var/obj/structure/flora/tree/vamp/T = S
			T.burnshit()
//			if(!isitem(S))
//				S.take_damage(10*stage, BURN, MELEE, 1)
	for(var/obj/effect/decal/cleanable/blood/B in loc)
		B.dry()
	for(var/obj/structure/vampdoor/V in loc)
		if(V.burnable)
			V.break_door()
			V.color = "#808080"
	var/total_burn = 0
	if(istype(get_turf(src), /turf/open/floor))
		var/turf/open/floor/A = get_turf(src)
		A.burn_material = max(0, A.burn_material-(1*stage))
		total_burn += A.burn_material
		if(prob(A.spread_chance))
			change_stage(min(3, stage+1))
		if(A.burn_material == 0)
			new /obj/effect/decal/cleanable/fire_ash(A)
			A.spread_chance = initial(A.spread_chance)
	if(total_burn)
		for(var/turf/open/floor/A in range(1, src))
			var/obj/structure/vampdoor/V = locate() in A
			var/allowed_to_spread = FALSE

			if(!V)
				allowed_to_spread = TRUE
			else
				if(!V.opacity)
					allowed_to_spread = TRUE
				if(V.burnable)
					allowed_to_spread = TRUE

			if(allowed_to_spread)
				if(A != loc && A.burn_material)
					var/obj/effect/abstract/turf_fire/F = locate() in A
					if(!F && prob(A.spread_chance))
						playsound(get_turf(A), 'modular_darkpack/modules/deprecated/sounds/spread.ogg', 80, TRUE)
						var/obj/effect/abstract/turf_fire/R = new(A)
						R.color = color
	else
		qdel(src)

/obj/effect/abstract/turf_fire/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(isliving(AM))
		var/mob/living/L = AM
		L.fire_stacks += 5
		L.IgniteMob()

/obj/effect/abstract/turf_fire/Initialize(mapload)
	. = ..()

	set_light(3, 2, "#ffa800")
	GLOB.fires_list += src

/obj/effect/abstract/turf_fire/Destroy()
	. = ..()

	set_light(0)
	GLOB.fires_list -= src

/obj/effect/abstract/turf_fire/proc/change_stage(stag)
	switch(stag)
		if(0)
			qdel(src)
		if(1)
			stage = 1
			icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
		if(2)
			stage = 2
			icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
		if(3)
			stage = 3
			icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'

/turf/open/floor/Initialize(mapload)
	. = ..()
	if(istype(get_area(src), /area/vtm))
		var/area/vtm/V = get_area(src)
		if(!V.outdoors)
			spread_chance += 10
*/

#define TURF_FIRE_REQUIRED_TEMP (T0C+10)
#define TURF_FIRE_TEMP_BASE (T0C+100)
#define TURF_FIRE_POWER_LOSS_ON_LOW_TEMP 7
#define TURF_FIRE_TEMP_INCREMENT_PER_POWER 3
#define TURF_FIRE_VOLUME 150
#define TURF_FIRE_MAX_POWER 50

#define TURF_FIRE_ENERGY_PER_BURNED_OXY_MOL 30000
#define TURF_FIRE_BURN_RATE_BASE 0.12
#define TURF_FIRE_BURN_RATE_PER_POWER 0.02
#define TURF_FIRE_BURN_CARBON_DIOXIDE_MULTIPLIER 0.75
#define TURF_FIRE_BURN_MINIMUM_OXYGEN_REQUIRED 0.5
#define TURF_FIRE_BURN_PLAY_SOUND_EFFECT_CHANCE 6

/// Minimum fire power required to spread to other turfs
#define TURF_FIRE_MIN_POWER_TO_SPREAD 20
/// Multiplier for the probability of spreading to adjacent tiles and how much power the new fires have
#define TURF_FIRE_SPREAD_RATE 0.3

#define TURF_FIRE_STATE_SMALL 1
#define TURF_FIRE_STATE_MEDIUM 2
#define TURF_FIRE_STATE_LARGE 3

/obj/effect/abstract/turf_fire
	icon = 'modular_darkpack/modules/fire/icons/turf_fire.dmi'
	base_icon_state = "red"
	icon_state = "red_small"
	layer = BELOW_OPEN_DOOR_LAYER
	anchored = TRUE
	move_resist = INFINITY
	light_range = 1.5
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE
	mouse_opacity = FALSE
	/// How much power have we got. This is treated like fuel, be it flamethrower liquid or any random thing you could come up with
	var/fire_power = 20
	/// If false, it does not interact with atmos.
	var/interact_with_atmos = TRUE

	/// If false, it will not lose power by itself. Mainly for adminbus events or mapping.
	var/passive_loss = TRUE

	/// Visual state of the fire. Kept track to not do too many updates.
	var/current_fire_state

	/// the list of allowed colors, if fire_color doesn't match, we store the color in hex_color instead and we color the fire based on hex instead
	var/list/allowed_colors = list("red", "blue", "green", "white")

	/// If we are using a custom hex color, which color are we using?
	var/hex_color

///All the subtypes are for adminbussery and or mapping
/obj/effect/abstract/turf_fire/magical
	interact_with_atmos = FALSE
	passive_loss = FALSE

/obj/effect/abstract/turf_fire/small
	fire_power = 10

/obj/effect/abstract/turf_fire/small/magical
	interact_with_atmos = FALSE
	passive_loss = FALSE

/obj/effect/abstract/turf_fire/inferno
	fire_power = 30

/obj/effect/abstract/turf_fire/inferno/magical
	interact_with_atmos = FALSE
	passive_loss = FALSE

/obj/effect/abstract/turf_fire/Initialize(mapload, power, fire_color)
	. = ..()
	var/turf/open/open_turf = loc
	if(open_turf.turf_fire)
		return INITIALIZE_HINT_QDEL

	/*
	var/datum/gas_mixture/environment = open_turf.air
	var/oxy = environment.get_moles(GAS_O2)
	if (oxy < TURF_FIRE_BURN_MINIMUM_OXYGEN_REQUIRED)
		return INITIALIZE_HINT_QDEL
	*/

	particles = new /particles/smoke/turf_fire

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	if(!fire_color)
		base_icon_state = "red"
	else if(fire_color in allowed_colors)
		base_icon_state = fire_color
	else
		hex_color = fire_color
		color = fire_color
		base_icon_state = "greyscale"

	switch(base_icon_state) //switches light color depdning on the flame color
		if("greyscale")
			light_color = hex_color
		if("red")
			light_color = LIGHT_COLOR_FIRE
		if("blue")
			light_color = LIGHT_COLOR_CYAN
		if("green")
			light_color = LIGHT_COLOR_GREEN
		else
			light_color = COLOR_VERY_LIGHT_GRAY

	open_turf.turf_fire = src
	START_PROCESSING(SSturf_fire, src)
	if(power)
		fire_power = min(TURF_FIRE_MAX_POWER, power)
	UpdateFireState()

/obj/effect/abstract/turf_fire/Destroy()
	var/turf/open/open_turf = loc
	open_turf.turf_fire = null
	STOP_PROCESSING(SSturf_fire, src)
	return ..()

/obj/effect/abstract/turf_fire/proc/process_waste()
	var/turf/open/open_turf = loc
	if(open_turf.planetary_atmos)
		return TRUE

	/*
	var/datum/gas_mixture/cached_air = open_turf.air

	var/oxy = cached_air.get_moles(GAS_O2)
	if (oxy < TURF_FIRE_BURN_MINIMUM_OXYGEN_REQUIRED)
		return FALSE

	var/temperature = cached_air.return_temperature()
	var/old_heat_capacity = cached_air.heat_capacity()

	var/burn_rate = TURF_FIRE_BURN_RATE_BASE + fire_power * TURF_FIRE_BURN_RATE_PER_POWER
	burn_rate = max(oxy, burn_rate)

	cached_air.adjust_moles(GAS_O2, -burn_rate)

	cached_air.adjust_moles(GAS_CO2, burn_rate * TURF_FIRE_BURN_CARBON_DIOXIDE_MULTIPLIER)

	var/new_heat_capacity = cached_air.heat_capacity()
	var/energy_released = burn_rate * TURF_FIRE_ENERGY_PER_BURNED_OXY_MOL
	cached_air.adjust_heat((temperature * old_heat_capacity + energy_released) / new_heat_capacity)

	open_turf.air_update_turf()
	*/
	return TRUE

/obj/effect/abstract/turf_fire/process(seconds_per_tick)
	var/turf/current_turf = loc
	if(!isopenturf(current_turf)) //This can happen, how I'm not sure
		qdel(src)
		return
	var/turf/open/open_turf = loc
	if(open_turf.active_hotspot) //If we have an active hotspot, let it do the damage instead and lets not loose power
		return
	if(interact_with_atmos)
		if(!process_waste())
			qdel(src)
			return

	if(passive_loss)
		if(open_turf.air.return_temperature() < TURF_FIRE_REQUIRED_TEMP)
			fire_power -= TURF_FIRE_POWER_LOSS_ON_LOW_TEMP
		//var/area/fire_area = get_area(src)
		//if(fire_area.active_weather?.fire_suppression)
		//	fire_power -= fire_area.active_weather.fire_suppression
		fire_power = min(fire_power + open_turf.flammability - 1, TURF_FIRE_MAX_POWER)
		if(fire_power <= 0)
			qdel(src)
			return
		for(var/turf/open/turf_to_spread in open_turf.atmos_adjacent_turfs)
			if(turf_to_spread.turf_fire)
				continue
			if(fire_power + turf_to_spread.flammability < TURF_FIRE_MIN_POWER_TO_SPREAD)
				continue
			if(!prob(turf_to_spread.flammability * fire_power * TURF_FIRE_SPREAD_RATE))
				continue
			turf_to_spread.ignite_turf(fire_power * TURF_FIRE_SPREAD_RATE)
		UpdateFireState()

	open_turf.hotspot_expose(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	for(var/atom/movable/burning_atom as anything in open_turf)
		fire_power += burning_atom.fire_act(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	if(interact_with_atmos)
		if(prob(fire_power))
			open_turf.burn_tile()
		if(prob(TURF_FIRE_BURN_PLAY_SOUND_EFFECT_CHANCE))
			playsound(open_turf, 'sound/effects/comfyfire.ogg', 40, TRUE)

/obj/effect/abstract/turf_fire/proc/on_entered(datum/source, atom/movable/atom_crossing)
	var/turf/open/open_turf = loc
	if(open_turf.active_hotspot) //If we have an active hotspot, let it do the damage instead
		return
	atom_crossing.fire_act(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	return

/obj/effect/abstract/turf_fire/extinguish()
	. = ..()
	qdel(src)

/obj/effect/abstract/turf_fire/proc/AddPower(power)
	fire_power = min(TURF_FIRE_MAX_POWER, fire_power + power)
	UpdateFireState()

/obj/effect/abstract/turf_fire/proc/UpdateFireState()
	var/new_state
	switch(fire_power)
		if(0 to 10)
			new_state = TURF_FIRE_STATE_SMALL
		if(11 to 24)
			new_state = TURF_FIRE_STATE_MEDIUM
		if(25 to INFINITY)
			new_state = TURF_FIRE_STATE_LARGE

	if(new_state == current_fire_state)
		return
	current_fire_state = new_state

	switch(current_fire_state)
		if(TURF_FIRE_STATE_SMALL)
			icon_state = "[base_icon_state]_small"
			light_range = 1.5
		if(TURF_FIRE_STATE_MEDIUM)
			icon_state = "[base_icon_state]_medium"
			light_range = 2
		if(TURF_FIRE_STATE_LARGE)
			icon_state = "[base_icon_state]_big"
			light_range = 3

	update_light()

/particles/smoke/turf_fire
	spawning = 1 // don't turn this up or forest fires cause way too much lag
	position = generator(GEN_SPHERE, 16, 24, NORMAL_RAND)

#undef TURF_FIRE_REQUIRED_TEMP
#undef TURF_FIRE_TEMP_BASE
#undef TURF_FIRE_POWER_LOSS_ON_LOW_TEMP
#undef TURF_FIRE_TEMP_INCREMENT_PER_POWER
#undef TURF_FIRE_VOLUME
#undef TURF_FIRE_MAX_POWER

#undef TURF_FIRE_MIN_POWER_TO_SPREAD
#undef TURF_FIRE_SPREAD_RATE

#undef TURF_FIRE_ENERGY_PER_BURNED_OXY_MOL
#undef TURF_FIRE_BURN_RATE_BASE
#undef TURF_FIRE_BURN_RATE_PER_POWER
#undef TURF_FIRE_BURN_CARBON_DIOXIDE_MULTIPLIER
#undef TURF_FIRE_BURN_MINIMUM_OXYGEN_REQUIRED
#undef TURF_FIRE_BURN_PLAY_SOUND_EFFECT_CHANCE

#undef TURF_FIRE_STATE_SMALL
#undef TURF_FIRE_STATE_MEDIUM
#undef TURF_FIRE_STATE_LARGE
