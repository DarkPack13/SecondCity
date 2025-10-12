/atom/movable/screen/alert/status_effect/shapeshifted/fera
	name = "Transformed"
	desc = "You're transformed into your non-breed form!"
	clickable_glow = FALSE

/datum/status_effect/shapechange_mob/fera
	alert_type = /atom/movable/screen/alert/status_effect/shapeshifted/fera

/datum/action/cooldown/spell/shapeshift/polymorph_belt/garou
	name = "Transform"
	cooldown_time = 10 SECONDS
	possible_shapes = list(/mob/living/carbon/fera/crinos, /mob/living/carbon/fera/lupus, /mob/living/carbon/human)

