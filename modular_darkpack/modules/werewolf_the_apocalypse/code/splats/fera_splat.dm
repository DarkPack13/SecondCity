// Represents the system not that they are a werewolf/fera
/datum/splat/werewolf
	abstract_type = /datum/splat/werewolf

	// var/start_rage = 1
	var/rage = 1
	// var/start_gnosis = 1
	var/gnosis = 1

/datum/splat/werewolf/kinfolk
	name = "Kinfolk"
	splat_traits = list(
		TRAIT_FRENETIC_AURA
	)
	id = SPLAT_KINFOLK

/datum/splat/werewolf/shifter
	abstract_type = /datum/splat/werewolf/shifter
	splat_traits = list(
		TRAIT_WTA_GAROU_BREED,
		TRAIT_WTA_GAROU_AUSPICE,
		TRAIT_WTA_GAROU_TRIBE,
		TRAIT_FRENETIC_AURA
	)
	id = SPLAT_FERA
	var/datum/action/cooldown/fera_transform/fera_transformation
	var/list/transformation_list = list()

/datum/splat/werewolf/shifter/on_gain()
	. = ..()
	owner.set_species(/datum/species/human/shifter/homid)
	fera_transformation = new(owner, transformations = transformation_list)
	fera_transformation.Grant(owner)

/datum/splat/werewolf/shifter/on_lose_or_destroy()
	. = ..()
	if(!QDELETED(owner))
		owner.set_species(/datum/species/human)
	fera_transformation.Remove(owner)
	QDEL_NULL(fera_transformation)

/datum/splat/werewolf/shifter/garou
	name = "Garou"
	id = SPLAT_GAROU
	transformation_list = list(
		/datum/species/human/shifter/homid,
		/datum/species/human/shifter/bestial,
		/datum/species/human/shifter/war,
		/datum/species/human/shifter/dire,
		/datum/species/human/shifter/feral
	)

// /datum/splat/werewolf/shifter/corax // DARKPACK TODO - CORAX

#warn move
/datum/action/cooldown/fera_transform
	var/list/possible_shapes = list()

/datum/action/cooldown/fera_transform/New(Target, original = TRUE, list/transformations)
	. = ..()
	if(transformations)
		possible_shapes = transformations

/datum/action/cooldown/fera_transform/Trigger(mob/clicker, trigger_flags, atom/Target)
	. = ..()
	if(!.)
		return

	owner.set_species(pick(possible_shapes))
