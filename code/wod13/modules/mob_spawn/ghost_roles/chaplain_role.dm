/obj/effect/mob_spawn/human/achaplain
	name = "a chaplain"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a chaplain"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/achaplain
	roundstart = FALSE
	death = FALSE
	random = FALSE
	mob_species = /datum/species/human
	short_desc = "You were guarding the Church, but then..."
	flavour_text = "You are a man of true Faith, but people in this city are not. You should protect the House of God..."
	assignedrole = "Chaplain"

/obj/effect/mob_spawn/human/achaplain/special(mob/living/new_spawn)
	var/my_name = "Tyler"
	if(new_spawn.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	new_spawn.fully_replace_character_name(null,"[my_name] [my_surname]")
	new_spawn.mind.holy_role = HOLY_ROLE_PRIEST

/datum/outfit/achaplain
	name = "chaplain"
	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/hunter
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/church
	r_hand = /obj/item/gun/ballistic/shotgun/vampire
	back = /obj/item/storage/backpack/satchel
