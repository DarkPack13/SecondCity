/obj/item/occult_artifact/pickup(mob/user)
	. = ..()
	if(identified)
		bind(user)

/obj/item/occult_artifact/dropped(mob/user)
	. = ..()
	if(identified)
		if(isturf(loc))
			unbind(user)


/obj/item/occult_artifact/process(seconds_per_tick)
	if(owner != loc && owner != loc.loc)
		forceMove(get_turf(src))
		STOP_PROCESSING(SSobj, src)
		if(owner)
			ungrant_powers()
			owner = null

/obj/item/occult_artifact
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
	var/research_value = 0
	var/can_be_identified_without_ritual = TRUE

	var/datum/controller/subsystem/processing/subsystem_type = /datum/controller/subsystem/processing/obj

	var/datum/storyteller_roll/identify_occult/identify_roll

/obj/item/occult_artifact/proc/identify(mob/living/artifact_identifier)
	if(!identified)
		name = true_name
		desc = true_desc
		identified = TRUE
		if(src in artifact_identifier?.get_all_contents())
			bind(artifact_identifier)

/obj/item/occult_artifact/proc/bind(mob/user)
	if(!identified)
		return
	owner = user
	START_PROCESSING(subsystem_type, src)
	grant_powers()

/obj/item/occult_artifact/proc/unbind(mob/user)
	STOP_PROCESSING(subsystem_type, src)
	if(owner)
		ungrant_powers()
		owner = null

/obj/item/occult_artifact/proc/grant_powers()
	return

/obj/item/occult_artifact/proc/ungrant_powers()
	return


/obj/item/occult_artifact/attack_self(mob/user, modifiers)
	. = ..()
	if(!isliving(user))
		return

	if(identified)
		to_chat(user, span_notice("This artifact is already identified."))
		return

	var/mob/living/artifact_identifier = user
	if(artifact_identifier.st_get_stat(STAT_OCCULT) < 3)
		to_chat(artifact_identifier, span_warning("What is this thing? Some kind of yard sale item?"))
		return

	if(can_be_identified_without_ritual == FALSE)
		to_chat(artifact_identifier, span_warning("You've seen some occult artifacts, trinkets, and powerful relics, but this, you've either never seen it before, or it's power can only be awakened by few..."))
		return

	to_chat(artifact_identifier, span_cult("You might have seen this before in an occult text. You start identifying it..."))
	if(do_after(artifact_identifier, 1 TURNS, src))
		if(!identify_roll)
			identify_roll = new()
			identify_roll.difficulty = 8
		var/roll = identify_roll.st_roll(user, src)
		if(roll == ROLL_SUCCESS)
			identify(artifact_identifier)
			to_chat(artifact_identifier, span_cult("You successfully identify [src]!"))
		else
			to_chat(artifact_identifier, span_warning("You stop examining [src]."))

/obj/effect/spawner/random/occult
	name = "occult spawner"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	icon_state = "art_rand"

/obj/effect/spawner/random/occult/artifact
	name = "random occult artifact"
	loot_subtype_path = /obj/item/occult_artifact/vampire

/obj/effect/spawner/random/occult/artifact/Initialize(mapload)
	spawn_loot_chance = CONFIG_GET(number/artifact_random_probability)
	. = ..()

/obj/effect/spawner/random/occult/fetish
	name = "random garou fetish"
	loot_subtype_path = /obj/item/occult_artifact/werewolf

/obj/effect/spawner/random/occult/fetish/Initialize(mapload)
	spawn_loot_chance = CONFIG_GET(number/artifact_random_probability)
	. = ..()
