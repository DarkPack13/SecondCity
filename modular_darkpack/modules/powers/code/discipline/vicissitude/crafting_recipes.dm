/datum/crafting_recipe/tzi_trench
	name = "Leather-Bone Trenchcoat (Armor)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_heart
	name = "Second Heart (Antistun)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 25, /obj/item/organ/heart = 1)
	result = /obj/item/organ/cyberimp/brain/anti_stun/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_eyes
	name = "Better Eyes (Nightvision)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 15, /obj/item/organ/eyes = 1)
	result = /obj/item/organ/eyes/night_vision/tzimisce
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_implant
	name = "Implanting Flesh Device"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/knife/vamp = 1, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/autosurgeon/vicissitude
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzicreature
	name = "Wretched Creature"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/organ/brain = 1)
	result = /obj/item/toy/plush/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_floor
	name = "Gut Floor"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 1, /obj/item/guts = 1)
	result = /obj/effect/decal/gut_floor
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_ON_SOLID_GROUND|CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_wall
	name = "Flesh Wall"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 2)
	result = /obj/structure/fleshwall
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzijelly
	name = "Living Meat Node"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 20, /obj/item/guts = 1, /obj/item/toy/plush/tzi = 1)
	result = /obj/structure/tzijelly
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_stool
	name = "Arm Stool"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 5, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2)
	result = /obj/structure/chair/old/tzimisce
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_biter
	name = "Biting Abomination"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 2, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2, /obj/item/spine = 1)
	result = /mob/living/basic/szlachta
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_fister
	name = "Punching Abomination"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 5, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/spine = 1, /obj/item/guts = 1)
	result = /mob/living/basic/szlachta/fister
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_tanker
	name = "Fat Abomination"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/bodypart/leg/right = 1, /obj/item/bodypart/leg/left = 1, /obj/item/spine = 1, /obj/item/guts = 2)
	result = /mob/living/basic/szlachta/tanker
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY
