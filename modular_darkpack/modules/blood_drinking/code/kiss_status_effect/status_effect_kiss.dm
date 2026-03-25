/datum/status_effect/kissed
	id = "kissed"
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/kissed

/datum/status_effect/kissed/on_apply()
	. = ..()
	to_chat(owner, span_userlove("Sharp fangs pierce your skin, but the pain quickly fades as a numbing warmth sets in...")) //feel free to change these
	owner.add_client_colour(/datum/client_colour/brightened)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.adjust_eye_blur(15)
		H.adjust_dizzy(10)

/datum/status_effect/kissed/on_remove()
	to_chat(owner, span_userlove("As you wake, you find it hard to recall anything of the past few minutes. All you remember is a pleasant, warm feeling.")) //feel free to change these
	owner.remove_client_colour(/datum/client_colour/brightened)
	owner.SetSleeping(50)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.adjust_confusion(10)
	return ..()

/atom/movable/screen/alert/status_effect/kissed
	name = "Kissed"
	desc = "Your body is flooded with pleasure!"
	icon_state = "in_love" //would be good to give this it's own icon eventually

/datum/client_colour/brightened
	priority = CLIENT_COLOR_HELMET_PRIORITY
	color = list(1.15,0,0,0,1.15,0,0,0,1.15,0,0,0)
