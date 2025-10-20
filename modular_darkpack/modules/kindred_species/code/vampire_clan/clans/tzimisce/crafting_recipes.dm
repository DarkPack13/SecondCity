
/datum/crafting_recipe/tzi_trench
	name = "Leather-Bone Trenchcoat (Armor)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_heart
	name = "Second Heart (Antistun)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 25, /obj/item/organ/heart = 1)
	result = /obj/item/organ/cyberimp/brain/anti_stun
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_eyes
	name = "Better Eyes (Nightvision)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 15, /obj/item/organ/eyes = 1)
	result = /obj/item/organ/eyes/night_vision
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_implant
	name = "Implanting Flesh Device"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/knife/vamp = 1, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/autosurgeon // DARKPACK TODO: Tzimisce autosurgeon
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_floor
	name = "Gut Floor"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 1, /obj/item/guts = 1)
	result = /obj/effect/decal/gut_floor
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_wall
	name = "Flesh Wall"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 2)
	result = /turf/closed/wall/mineral/iron // DARKPACK TODO: Tzimisce walls
	category = CAT_TZIMISCE

/obj/effect/decal/gut_floor
	name = "gut floor"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "tzimisce_floor"

/datum/movespeed_modifier/centipede
	multiplicative_slowdown = -0.6

/mob/living/simple_animal/hostile/bloodcrawler
	var/collected_blood = 0

/mob/living/simple_animal/hostile/bloodcrawler/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	if(V)
		if(V.lockpick_difficulty <= 10)
			forceMove(get_turf(V))
	for(var/obj/effect/decal/cleanable/blood/B in range(1, NewLoc))
		if(B.bloodiness)
			collected_blood = collected_blood+1
			to_chat(src, "You sense blood entering your mass...")
			var/turf/T = get_turf(B)
			if(T)
				T.wash(CLEAN_WASH)

/obj/effect/decal/gut_floor/Initialize(mapload)
	. = ..()
	if(isopenturf(get_turf(src)))
		var/turf/open/T = get_turf(src)
		if(T)
			T.slowdown = 1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/datum/crafting_recipe/tzi_stool
	name = "Arm Stool"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2)
	result = /obj/structure/chair/old/tzimisce

	category = CAT_TZIMISCE

/obj/structure/chair/old/tzimisce
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "tzimisce_stool"

/obj/item/guts
	name = "guts"
	desc = "Just blood and guts..."
	icon_state = "guts"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "spine"
	desc = "If only I had control..."
	icon_state = "spine"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/datum/crafting_recipe/tzi_biter
	name = "Biting Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 2, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2, /obj/item/spine = 1)
	result = /mob/living/simple_animal/hostile/biter

	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_fister
	name = "Punching Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/spine = 1, /obj/item/guts = 1)
	result = /mob/living/simple_animal/hostile/fister

	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_tanker
	name = "Fat Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/bodypart/leg/right = 1, /obj/item/bodypart/leg/left = 1, /obj/item/spine = 1, /obj/item/guts = 2)
	result = /mob/living/simple_animal/hostile/tanker

	category = CAT_TZIMISCE
