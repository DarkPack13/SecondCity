/obj/effect/mob_spawn/human/chunkguard
	name = "Millenium Tower Security Guard"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a Millenium Tower Security Guard"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/chunk
	roundstart = FALSE
	death = FALSE
	random = FALSE
	mob_species = /datum/species/human
	short_desc = "You are working the night shift on Millenium Towers, just like any other night...."
	flavour_text = "You are up late protecting Millenium Towers on behalf of your pasty-faced, but filthy rich, boss. Come to think of it, you only ever see him at night..."
	assignedrole = "Millenium Tower Secuity Guard"

/obj/effect/mob_spawn/human/chunkguard/special(mob/living/new_spawn)
	var/my_name = "Tyler"
	if(new_spawn.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	new_spawn.fully_replace_character_name(null,"[my_name] [my_surname]")

/datum/outfit/chunk
	name = "Security Guard Chunk"
	uniform = /obj/item/clothing/under/vampire/guard
	shoes = /obj/item/clothing/shoes/vampire
	belt = /obj/item/gun/ballistic/automatic/vampire/m1911
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/camarilla
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/flashlight=1, /obj/item/card/credit=1,/obj/item/food/vampire/donut=5,/obj/item/card/id/chunk=1)

/obj/item/card/id/chunk
	name = "Millenium Tower Security ID"
	id_type_name = "Security ID"
	desc = "An ID showing propensity for donuts"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id2"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id2"

/obj/item/card/id/chunk/AltClick(mob/user)
	return
