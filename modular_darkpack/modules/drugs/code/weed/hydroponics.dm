/obj/structure/weedshit
	name = "hydroponics"
	desc = "Definitely not for the weed."
	icon = 'modular_darkpack/modules/drugs/icons/weed.dmi'
	icon_state = "soil_dry0"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/wet = FALSE
	var/growth_stage = 0
	var/health = 3

/obj/structure/weedshit/buyable
	anchored = FALSE

/obj/structure/weedshit/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [anchored ? "un" : ""]secure [src] [anchored ? "from" : "to"] the ground.")
	if(!wet)
		. += span_warning("[src] is dry!")
	if(growth_stage == 5)
		. += span_warning("The crop is dead!")
	else
		if(health <= 2)
			. += span_warning("The crop is looking unhealthy.")

/obj/structure/weedshit/attack_hand(mob/user, params)
	. = ..()
	if(growth_stage == 5)
		growth_stage = 0
		health = 3
		to_chat(user, span_notice("You rip the rotten weed out of [src]."))
	if(growth_stage == 4)
		growth_stage = 1
		to_chat(user, span_notice("You pull the grown weed out of [src]."))
		var/mob/living/carbon/human/H = user
		var/amount = clamp(SSroll.storyteller_roll(H.st_get_stat(STAT_INTELLIGENCE), 6, TRUE) - 1, 1, 4)
		for(var/i = 1 to amount)
			new /obj/item/food/vampire/weed(get_turf(user))
	update_weed_icon()

/obj/structure/weedshit/click_alt(mob/user)
	if(!user.Adjacent(src))
		return
	to_chat(user, span_notice("You start [anchored ? "unsecuring" : "securing"] [src] [anchored ? "from" : "to"] the ground."))
	if(do_after(user, 15))
		if(anchored)
			to_chat(user, span_notice("You unsecure [src] from the ground."))
			anchored = FALSE
			return
		else
			to_chat(user, span_notice("You secure [src] to the ground."))
			anchored = TRUE
			return

/obj/structure/weedshit/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/reagent_containers/cup/watering_can/metal))
		var/obj/item/reagent_containers/cup/watering_can/metal/B = W
		if(B.amount_of_water)
			B.amount_of_water = max(0, B.amount_of_water-1)
			wet = TRUE
			to_chat(user, span_notice("You fill [src] with water."))
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
		else
			to_chat(user, span_warning("[W] is empty!"))
	if(istype(W, /obj/item/seeds/cannabis))
		if(growth_stage == 0)
			health = 3
			growth_stage = 1
			qdel(W)
	update_weed_icon()
	return

/obj/structure/weedshit/Initialize(mapload)
	. = ..()
	GLOB.weed_list += src

/obj/structure/weedshit/Destroy()
	. = ..()
	GLOB.weed_list -= src

/obj/structure/weedshit/proc/update_weed_icon()
	icon_state = "soil[wet ? "" : "_dry"][growth_stage]"
