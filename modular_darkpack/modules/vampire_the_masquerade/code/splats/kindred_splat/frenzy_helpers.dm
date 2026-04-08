/datum/splat/vampire/kindred/proc/get_blood_frenzy_targets(range = world.view)
	var/list/blood = list()

	for(var/obj/effect/decal/cleanable/blood/blood_spot in view(range, owner))
		blood += blood_spot
	for(var/mob/living/carbon/human/possible_blood_bag in view(range, owner))
		if(possible_blood_bag.is_bloodied())
			blood += possible_blood_bag

	return blood

/atom/proc/is_bloodied()
	return GET_ATOM_BLOOD_DECAL_LENGTH(src)

/mob/living/carbon/is_bloodied()
	if(GET_ATOM_BLOOD_DECAL_LENGTH(src) && num_hands) // Blood decals only actually show up if we have hands as its seperate from blood soles..
		return TRUE

	for(var/obj/item/visible_item in get_visible_items())
		if(visible_item.is_bloodied())
			return TRUE

/datum/splat/vampire/kindred/proc/get_fire_frenzy_targets(range = world.view)
	var/list/fire = list()

	for(var/obj/effect/abstract/turf_fire/flames in view(range, owner))
		fire += flames

	for(var/mob/living/carbon/human/guy in view(range, owner))
		if(guy.on_fire)
			fire += guy

	return fire
