/obj/effect/decal/cleanable/vomit/fomori
	name = "wormy vomit"
	desc = "Vomit with worms writhing around in it. Disgusting."
	icon = 'modular_darkpack/modules/fomori/icons/worm_vomit.dmi'
	icon_state = "worm_vomit1"
	random_icon_states = list("worm_vomit1", "worm_vomit2", "worm_vomit3")

/datum/action/cooldown/power/fomori_power/worms // Freak Legion pg. 47
	name = "Worms"
	desc = "Expel the worms that writhe in your flesh, tearing you apart from the inside."
	button_icon_state = "worm_puke"
	rank = 1
	cooldown_time = 5 SCENES // 15 minutes

/datum/action/cooldown/power/fomori_power/worms/Grant(mob/granted_to)
	. = ..()
	ADD_TRAIT(owner, TRAIT_FOMORI_WORMS, "fomor_worms")

/datum/action/cooldown/power/fomori_power/worms/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/fomor = owner
	fomor.Shake(2, 2, 1 SECONDS)
	fomor.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/fomori, distance = rand(0,3))
	REMOVE_TRAIT(owner, TRAIT_FOMORI_WORMS, "fomor_worms")
	addtimer(CALLBACK(src, PROC_REF(the_worms_are_back)), 1 SCENES)
	StartCooldown()

/datum/action/cooldown/power/fomori_power/worms/proc/the_worms_are_back()
	ADD_TRAIT(owner, TRAIT_FOMORI_WORMS, "fomor_worms")
	to_chat(owner, span_boldwarning("The worms are back."))
	SEND_SOUND(owner, 'sound/items/handling/reagent_containers/plastic_bottle/plastic_bottle_liquid_slosh2.ogg')
