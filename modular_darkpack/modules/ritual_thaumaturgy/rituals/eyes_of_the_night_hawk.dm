/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk
	name = "eyes of the night hawk"
	desc = "By using this ritual with a raven or other predatory bird in the ritual circle, the user may implant their mind into that of the bird. Once the ritualist is done seeing through the bird's eyes, they must put out the eyes and kill the bird, or the ritualist goes blind."
	icon_state = "rune7"
	word = ""
	level = 2
	//sacrifices = list(/mob/living/basic/corvid) // change, or expand, when more birds are added // note - sacrifices are consumed in parent type so this check is being built into complete().

/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk/complete()
	. = ..()
	var/mob/living/basic/corvid/target = locate(/mob/living/basic/corvid) in get_turf(src)
	if(!target)
		to_chat(last_activator, span_warning("There is no bird in the ritual circle."))
		return

	var/datum/action/return_to_body/return_to_body_action = new(last_activator)
	return_to_body_action.Grant(target)
	return_to_body_action.possessor_ckey = last_activator.ckey
	return_to_body_action.possessor_original_mob = last_activator
	target.PossessByPlayer(last_activator.ckey)

// for one-way posessions without another player possibly being attached. appears purpose-built for this ritual, but i can imagine it being used in the future
/datum/action/return_to_body
	name = "Return to your body"
	desc = "Break the mental link between yourself and the raven, bringing you back into your own body."
	var/mob/living/possessor_original_mob
	var/possessor_ckey

/datum/action/return_to_body/Trigger(fire)
	. = ..()
	possessor_original_mob.PossessByPlayer(possessor_ckey)
	Remove(owner)
