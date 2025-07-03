/obj/effect/mob_spawn/human/citizen
	name = "just a civilian"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a civillian"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/civillian1
	roundstart = FALSE
	death = FALSE
	random = FALSE
	mob_species = /datum/species/human
	short_desc = "You just woke up from strange noises outside. This city is totally cursed..."
	flavour_text = "Each day you notice some weird shit going at night. Each day, new corpses, new missing people, new police-don't-give-a-fuck. This time you definitely should go and see the mysterious powers of the night... or not? You are too afraid because you are not aware of it."
	assignedrole = "Civillian"

/obj/effect/mob_spawn/human/citizen/Initialize(mapload)
	. = ..()
	if(prob(50))
		qdel(src)
		return
	var/arrpee = rand(1,4)
	switch(arrpee)
		if(2)
			outfit = /datum/outfit/civillian2
		if(3)
			outfit = /datum/outfit/civillian3
		if(4)
			outfit = /datum/outfit/civillian4

/obj/effect/mob_spawn/human/citizen/special(mob/living/new_spawn)
	var/my_name = "Tyler"
	if(new_spawn.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	new_spawn.fully_replace_character_name(null,"[my_name] [my_surname]")


/datum/outfit/civillian1
	name = "civillian"
	uniform = /obj/item/clothing/under/vampire/sport
	shoes = /obj/item/clothing/shoes/vampire/sneakers
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/npc/fix
	back = /obj/item/storage/backpack/satchel

/datum/outfit/civillian2
	name = "civillian"
	uniform = /obj/item/clothing/under/vampire/office
	shoes = /obj/item/clothing/shoes/vampire
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/npc/fix
	back = /obj/item/storage/backpack/satchel

/datum/outfit/civillian3
	name = "civillian"
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/npc/fix
	back = /obj/item/storage/backpack/satchel

/datum/outfit/civillian4
	name = "civillian"
	uniform = /obj/item/clothing/under/vampire/bandit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/npc/fix
	back = /obj/item/storage/backpack/satchel
