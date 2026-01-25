/obj/item/vtm_artifact/pickup(mob/user)
	. = ..()
	if(identified)
		owner = user
		START_PROCESSING(SSobj, src)
		get_powers()

/obj/item/vtm_artifact/dropped(mob/user)
	. = ..()
	if(identified)
		if(isturf(loc))
			STOP_PROCESSING(SSobj, src)
			if(owner)
				remove_powers()
				owner = null

/obj/item/vtm_artifact/process(delta_time)
	if(owner != loc && owner != loc.loc)
		forceMove(get_turf(src))
		STOP_PROCESSING(SSobj, src)
		if(owner)
			remove_powers()
			owner = null

/obj/item/vtm_artifact
	name = "unidentified occult fetish"
	desc = "Who knows what secrets it could contain..."
	icon_state = "arcane"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/occult_artifacts/icons/artifacts_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	var/mob/living/owner
	var/true_name = "artifact"
	var/true_desc = "Debug"
	var/identified = FALSE
	var/gained_boosts = FALSE
	var/research_value = 0
	var/can_be_identified_without_ritual = TRUE

/obj/item/vtm_artifact/proc/identify()
	if(!identified)
		name = true_name
		desc = true_desc
		identified = TRUE

/obj/item/vtm_artifact/proc/get_powers()
	if(!identified)
		return

/obj/item/vtm_artifact/proc/remove_powers()
	if(!identified)
		return

/obj/item/vtm_artifact/attack_self(mob/user, modifiers)
	. = ..()
	if(!isliving(user))
		return

	if(identified)
		to_chat(user, span_notice("This artifact is already identified."))
		return

	var/mob/living/artifact_identifier = user
	if(artifact_identifier.st_get_stat(STAT_OCCULT) < 4)
		to_chat(artifact_identifier, span_warning("What is this thing? Some kind of yard sale item?"))
		return

	if(can_be_identified_without_ritual == FALSE)
		to_chat(artifact_identifier, span_warning("You've seen countless occult artifacts, trinkets, and powerful relics, but this, you've either never seen it before, or it's power can only be awakened by few..."))
		return

	to_chat(artifact_identifier, span_cult("You've seen this before in an occult text. You start identifying it..."))
	if(do_after(artifact_identifier, 10 SECONDS, src))
		identify()
		to_chat(artifact_identifier, span_cult("You successfully identify [src]!"))
	else
		to_chat(artifact_identifier, span_warning("You stop examining [src]."))

/obj/effect/spawner/random/occult
	name = "occult spawner"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	icon_state = "art_rand"

/obj/effect/spawner/random/occult/artifact
	name = "random occult fetish"
	spawn_loot_chance = 50
	loot_subtype_path = /obj/item/vtm_artifact
