/obj/item/mystic_tome
	name = "mystic tome"
	desc = "The secrets of Abyss Mysticism..."
	icon_state = "mystic"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	var/list/rituals = list()

/obj/item/mystic_tome/Initialize(mapload)
	. = ..()
	for(var/i in subtypesof(/obj/abyssrune))
		var/obj/abyssrune/R = new i(src)
		rituals |= R

/obj/item/mystic_tome/attack_self(mob/user)
	. = ..()
	for(var/obj/abyssrune/R in rituals)
		if(R.sacrifice)
			var/obj/item/I = new R.sacrifice(src)
			to_chat(user, "[R.mystlevel] [R.name] - [R.desc] Requirements: [I].")
			qdel(I)
		else
			to_chat(user, "[R.mystlevel] [R.name] - [R.desc]")

/obj/abyssrune
	name = "Lasombra Rune"
	desc = "Learn the secrets of the Abyss, neonate..."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "rune1"
	color = rgb(0,0,0)
	anchored = TRUE
	var/word = "IDI NAH"
	var/activator_bonus = 0
	var/activated = FALSE
	var/mob/living/last_activator
	var/mystlevel = 1
	var/sacrifice

/obj/abyssrune/proc/complete()
	return

/obj/abyssrune/attack_hand(mob/user)
	if(!activated)
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_MYSTICISM_KNOWLEDGE))
			L.say("[word]")
			L.Immobilize(30)
			last_activator = user
			activator_bonus = L.thaum_damage_plus
			if(sacrifice)
				for(var/obj/item/I in get_turf(src))
					if(istype(I, sacrifice))
						qdel(I)
						complete()
			else
				complete()

/obj/abyssrune/click_alt(mob/user)
	. = ..()
	qdel(src)

/obj/abyssrune/selfgib
	name = "Self Destruction"
	desc = "Meet the Final Death."
	icon_state = "rune2"
	word = "YNT FRM MCHGN FYNV DN THS B'FO"

/obj/abyssrune/selfgib/complete()
	last_activator.death()

/obj/abyssrune/silent_heart
	name = "Silently-Beating Heart"
	desc = "Creates a shadowy abomination to protect the Lasombra and his domain."
	icon_state = "rune1"
	word = "ANI UMRA"
	mystlevel = 3

/obj/abyssrune/silent_heart/complete()
	var/mob/living/carbon/human/H = last_activator
	if(!length(H.beastmaster))
		var/datum/action/beastmaster_stay/E1 = new()
		E1.Grant(last_activator)
		var/datum/action/beastmaster_deaggro/E2 = new()
		E2.Grant(last_activator)
	var/mob/living/basic/shadow_guard/BG = new(loc)
	BG.beastmaster = last_activator
	H.beastmaster |= BG
	BG.my_creator = last_activator
	BG.melee_damage_lower = BG.melee_damage_lower+activator_bonus
	BG.melee_damage_upper = BG.melee_damage_upper+activator_bonus
	playsound(loc, 'sound/magic/voidblink.ogg', 50, FALSE)
	if(length(H.beastmaster) > 3+H.mentality)
		var/mob/living/simple_animal/hostile/beastmaster/B = pick(H.beastmaster)
		B.death()
	qdel(src)

/obj/abyssrune/identification
	name = "Occult Items Identification"
	desc = "Identificates single occult item"
	icon_state = "rune4"
	word = "WUS'ZAT"

/obj/abyssrune/identification/complete()
	for(var/obj/item/vtm_artifact/VA in loc)
		VA.identificate()
		playsound(loc, 'sound/magic/voidblink.ogg', 50, FALSE)
		qdel(src)
		return
