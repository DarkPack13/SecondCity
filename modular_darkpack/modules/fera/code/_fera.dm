// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/human/fera
	rotate_on_lying = FALSE
	initial_language_holder = /datum/language_holder/primal

	var/race = /datum/species/human/fera //Used for setting the species of the subtype transformation mobs, for example crinos being a garou species.

	var/sprite_color = "black"
	var/sprite_scar = 0
	var/sprite_hair = 0
	var/sprite_hair_color = "#000000"
	var/sprite_eye_color = "#FFFFFF"
	var/sprite_apparel = 0

/mob/living/carbon/human/fera/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_JUMPSUIT, "Fera")
	update_appearance()

	RegisterSignal(src, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/mob/living/carbon/human/fera/Destroy()
	UnregisterSignal(src, COMSIG_LIVING_DEATH)
	return ..()

/mob/living/carbon/human/fera/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	return FALSE

/mob/living/carbon/human/fera/create_dna()
	dna = new /datum/dna(src)
	if (!isnull(race))
		dna.species = new race

/mob/living/carbon/human/fera/proc/on_death(datum/source)
	SIGNAL_HANDLER

	var/datum/action/cooldown/spell/shapeshift/transformation/source_spell
	for(var/datum/action/cooldown/spell/shapeshift/shift_spell in actions)
		source_spell = shift_spell
	var/fera_breed = GLOB.fera_breeds[dna.features[FEATURE_FERA_BREED]]
	if(!fera_breed)
		return
	if(source_spell.shapeshift_type.type == fera_breed)
		return
	INVOKE_ASYNC(src, PROC_REF(return_to_breed_form), fera_breed, source_spell)

/mob/living/carbon/human/fera/proc/return_to_breed_form(fera_breed, spell)
	var/datum/action/cooldown/spell/shapeshift/transformation/source_spell = spell
	source_spell.shapeshift_type = fera_breed
	source_spell.cast(src, TRUE)

