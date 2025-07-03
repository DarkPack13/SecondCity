/obj/effect/mob_spawn/human/police
	name = "a police officer"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a police officer"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/policeofficer
	roundstart = FALSE
	death = FALSE
	random = FALSE
	mob_species = /datum/species/human
	short_desc = "You worked a simple night shift, but then..."
	flavour_text = "You woke up on your regular night shift and noticed something strange happening in the city. Only man interested in finding the truth is you..."
	assignedrole = "Police Officer"

/obj/effect/mob_spawn/human/police/special(mob/living/new_spawn)
	var/my_name = "Tyler"
	if(new_spawn.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	new_spawn.fully_replace_character_name(null,"[my_name] [my_surname]")

/datum/outfit/policeofficer
	name = "police officer"
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	belt = /obj/item/melee/classic_baton
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/radio/cop
	l_hand = /obj/item/vamp/keys/police
	r_hand = /obj/item/police_radio
	back = /obj/item/storage/backpack/satchel
