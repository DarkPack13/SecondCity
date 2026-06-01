// Generic stuff to populate ruins and other places
/obj/effect/spawner/random/loot
	abstract_type = /obj/effect/spawner/random/loot


/obj/effect/spawner/random/loot/money



/obj/effect/spawner/random/loot/weapon
	icon_state = "shotgun"
	abstract_type = /obj/effect/spawner/random/loot/weapon


/obj/effect/spawner/random/loot/weapon/small_melee
	loot = list(
		/obj/item/melee/vamp/tire = 10,
		/obj/item/knife/vamp = 10,
		/obj/item/switchblade/vamp = 10,
		/obj/item/melee/vamp/brick = 10,
		/obj/item/vampire_stake = 10,
	)

/obj/effect/spawner/random/loot/weapon/weak_large_melee
	loot = list(
		/obj/item/shovel/vamp = 10,
		/obj/item/melee/baseball_bat/vamp = 10,
		/obj/item/claymore/machete = 10,
	)

/obj/effect/spawner/random/loot/weapon/good_large_melee
	loot = list(
		/obj/item/fireaxe/vamp = 10,
		/obj/item/katana/vamp = 10,
		/obj/item/chainsaw/vamp = 10,
		/obj/item/scythe/vamp = 10,
		/obj/item/melee/sabre/vamp = 10,
		/obj/item/melee/sabre/rapier = 10,
		/obj/item/claymore/longsword = 10,
		/obj/item/darkpack/spear = 10,
	)
