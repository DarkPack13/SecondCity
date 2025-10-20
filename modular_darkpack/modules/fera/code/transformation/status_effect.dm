/datum/status_effect/shapechange_mob/from_spell/fera
	alert_type = null

/datum/status_effect/shapechange_mob/from_spell/fera/on_shape_death(datum/source, gibbed)
	var/datum/action/cooldown/spell/shapeshift/transformation/source_spell = source_weakref.resolve()
	// If our spell dictates our wizard dies when our shape dies, we won't restore by default
	if(QDELETED(source_spell))
		return ..()
	var/mob/living/carbon/human/human_mob = caster_mob
	var/fera_breed = GLOB.fera_breeds[human_mob.dna.features[FEATURE_FERA_BREED]]
	if(!fera_breed)
		return ..()
	if(source_spell.shapeshift_type.type == fera_breed)
		return ..()
	else
		shift_spell.shapeshift_type = fera_breed
		INVOKE_ASYNC(shift_spell, TYPE_PROC_REF(/datum/action/cooldown/spell/shapeshift/transformation, cast), human_mob)
		return TRUE
