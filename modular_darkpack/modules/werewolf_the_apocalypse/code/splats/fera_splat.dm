// Represents the system not that they are a werewolf/fera
/datum/splat/werewolf
	abstract_type = /datum/splat/werewolf

/datum/splat/werewolf/kinfolk

/datum/splat/werewolf/shifter
	abstract_type = /datum/splat/werewolf/shifter
	splat_traits = list(
		TRAIT_FRENETIC_AURA
	)
	var/datum/action/cooldown/spell/shapeshift/transformation/fera_transformation
	var/list/transformation_list = list()

/datum/splat/werewolf/shifter/on_gain()
	. = ..()
	fera_transformation = new(owner, transformation_list)
	fera_transformation.Grant(owner)

/datum/splat/werewolf/shifter/on_lose_or_destroy()
	. = ..()
	fera_transformation.Remove(owner)
	QDEL_NULL(fera_transformation)

/datum/splat/werewolf/shifter/garou
	transformation_list = list(/mob/living/carbon/human/fera/crinos, /mob/living/carbon/human/fera/lupus, /mob/living/carbon/human/fera/glabro, /mob/living/carbon/human/fera/hispo)

// /datum/splat/werewolf/shifter/corax // DARKPACK TODO - CORAX
