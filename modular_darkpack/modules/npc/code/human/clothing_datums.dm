/datum/outfit/npc
	name = "NPC Default"
	uniform = /obj/item/clothing/under/vampire/gangrel
	shoes = /obj/item/clothing/shoes/vampire

/datum/outfit/npc/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	back = pick(
		/obj/item/storage/backpack,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/duffelbag,
		/obj/item/storage/backpack/satchel/leather,
		/obj/item/storage/backpack/messenger,
		null,
		)

/datum/outfit/npc/bandit
	name = "NPC Bandit"

/datum/outfit/npc/bandit/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	shoes = pick(
		/obj/item/clothing/shoes/vampire/sneakers,
		/obj/item/clothing/shoes/vampire/sneakers/red,
		/obj/item/clothing/shoes/vampire/jackboots,
		)
	uniform = pick(
		/obj/item/clothing/under/vampire/larry,
		/obj/item/clothing/under/vampire/bandit,
		/obj/item/clothing/under/vampire/biker,
		)
	head = pick(
		/obj/item/clothing/head/vampire/bandana,
		/obj/item/clothing/head/vampire/bandana/red,
		/obj/item/clothing/head/vampire/bandana/black,
		/obj/item/clothing/head/vampire/beanie,
		/obj/item/clothing/head/vampire/beanie/black,
		null,
		)
	l_pocket = pick(
		/obj/item/stack/dollar/rand,
		/obj/item/vamp/keys/hack,
		null,
		)
	r_pocket = pick(
		/obj/item/stack/dollar/rand,
		/obj/item/vamp/keys/hack,
		null,
		)
	r_hand = pick(
		/obj/item/knife/vamp,
		/obj/item/melee/baseball_bat/vamp,
		/obj/item/crowbar,
		null,
	)

/datum/outfit/npc/rich
	name = "NPC Rich"

/datum/outfit/npc/rich/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	uniform = pick(
		/obj/item/clothing/under/vampire/rich,
		/obj/item/clothing/under/vampire/business,
		)
	shoes = pick(
		/obj/item/clothing/shoes/vampire,
		/obj/item/clothing/shoes/vampire/white,
		/obj/item/clothing/shoes/vampire/heels,
		/obj/item/clothing/shoes/vampire/heels/red,
		)
	r_hand = pick(
		/obj/item/storage/briefcase,
		null,
		)
	l_pocket = pick(
		/obj/item/stack/dollar/hundred,
		/obj/item/stack/dollar/fifty,
		/obj/item/vamp/keys/npc,
		null,
		)
	r_pocket = pick(
		/obj/item/stack/dollar/hundred,
		/obj/item/stack/dollar/fifty,
		/obj/item/vamp/keys/npc,
		null,
		)

/datum/outfit/npc/average
	name = "NPC Average"

/datum/outfit/npc/average/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	uniform = pick(
		/obj/item/clothing/under/vampire/mechanic,
		/obj/item/clothing/under/vampire/sport,
		/obj/item/clothing/under/vampire/office,
		/obj/item/clothing/under/vampire/sexy,
		/obj/item/clothing/under/vampire/slickback,
		/obj/item/clothing/under/vampire/emo,
		/obj/item/clothing/under/vampire/black,
		/obj/item/clothing/under/vampire/red,
		/obj/item/clothing/under/vampire/gothic,
		)
	shoes = pick(
		/obj/item/clothing/shoes/vampire/sneakers,
		/obj/item/clothing/shoes/vampire/heels,
		/obj/item/clothing/shoes/vampire,
		/obj/item/clothing/shoes/vampire/brown,
		)
	l_pocket = pick(
		/obj/item/vamp/keys/npc,
		/obj/item/stack/dollar/rand,
		null,
		)
	r_pocket = pick(
		/obj/item/vamp/keys/npc,
		/obj/item/stack/dollar/rand,
		null,
		)

/datum/outfit/npc/poor
	name = "NPC Poor"

/datum/outfit/npc/poor/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	uniform = pick(
		/obj/item/clothing/under/vampire/homeless,
		/obj/item/clothing/under/vampire/homeless/female,
		)
	shoes = pick(
		/obj/item/clothing/shoes/vampire/jackboots/work,
		/obj/item/clothing/shoes/vampire/brown,
		)
	suit = pick(
		/obj/item/clothing/suit/vampire/coat,
		/obj/item/clothing/suit/vampire/coat/alt,
		)
	head = pick(
		/obj/item/clothing/head/vampire/beanie/black,
		/obj/item/clothing/head/vampire/beanie/homeless,
		)
	neck = pick(
		/obj/item/clothing/neck/vampire/scarf/red,
		/obj/item/clothing/neck/vampire/scarf,
		/obj/item/clothing/neck/vampire/scarf/blue,
		/obj/item/clothing/neck/vampire/scarf/green,
		/obj/item/clothing/neck/vampire/scarf/white,
		)

/datum/outfit/npc/shop
	name = "NPC Shopkeeper"
	uniform = /obj/item/clothing/under/vampire/mechanic

/datum/outfit/npc/shop/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	shoes = pick(
		/obj/item/clothing/shoes/vampire/sneakers,
		/obj/item/clothing/shoes/vampire,
		/obj/item/clothing/shoes/vampire/brown,
	)
	l_pocket = pick(
		/obj/item/stack/dollar/rand,
		/obj/item/vamp/keys/npc,
		null,
		)

/datum/outfit/npc/police
	name = "NPC Police Officer"
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police
	head = /obj/item/clothing/head/vampire/police
	gloves = /obj/item/clothing/gloves/color/black
	l_pocket = /obj/item/stack/dollar/rand

/datum/outfit/npc/police/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	r_hand = pick(
		/obj/item/melee/baton,
		/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19,
		null,
	)

/datum/outfit/npc/endron
	name = "NPC Endron Guard"
	uniform = /obj/item/clothing/under/vampire/pentex_janitor
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	head = /obj/item/clothing/head/beret/black
	gloves = /obj/item/clothing/gloves/vampire/latex
	glasses = /obj/item/clothing/glasses/vampire/sun
	mask = /obj/item/clothing/mask/gas/explorer
	l_pocket = /obj/item/stack/dollar/rand

/datum/outfit/npc/endron/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	r_hand = pick(
		/obj/item/melee/baton,
		/obj/item/gun/ballistic/automatic/darkpack/mp5,
		null,
	)
