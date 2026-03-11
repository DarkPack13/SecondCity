/*
/obj/item/storage/ammostack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	var/base_caliber = "tut base_icon_state"
	var/max_patroni = 5

/obj/item/storage/ammostack/update_icon()
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		patroni = max(0, patroni+1)
	if(patroni)
		if(patroni > 1)
			icon_state = "[base_caliber]-[patroni]"
		else
			icon_state = "[base_caliber]-live"

/obj/item/storage/ammostack/attackby(obj/item/I, mob/user, params)
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		patroni = max(0, patroni+1)
	if(istype(I, /obj/item/ammo_casing/vampire))
		var/obj/item/ammo_casing/vampire/V = I
		if(patroni < max_patroni && V.base_icon_state = base_caliber)
			I.forceMove(src)
			update_icon()

/obj/item/storage/ammostack/Initialize(mapload)
	. = ..()
*/
