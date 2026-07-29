// V20 core rulebook pg. 233
/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk
	name = "eyes of the night hawk"
	desc = "By using this ritual with a raven or other predatory bird in the ritual circle, the user may implant their mind into that of the bird. Once the ritualist is done seeing through the bird's eyes, they must put out the eyes and kill the bird, or the ritualist goes blind."
	icon_state = "rune7"
	word = ""
	level = 2

/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk/complete()
	. = ..()
	var/mob/living/basic/corvid/target = locate(/mob/living/basic/corvid) in get_turf(src) // expand beyond corvid when more bird types are added
	if(!target)
		to_chat(last_activator, span_warning("There is no bird in the ritual circle."))
		return

	var/datum/action/return_to_body/return_to_body_action = new(last_activator)
	return_to_body_action.Grant(target)
	return_to_body_action.possessor_ckey = last_activator.ckey
	return_to_body_action.possessor_original_mob = last_activator
	return_to_body_action.possessed_bird = target
	target.PossessByPlayer(last_activator.ckey)

/datum/action/return_to_body
	name = "Return to your body"
	desc = "Break the mental link between yourself and the raven, bringing you back into your own body."
	button_icon = 'modular_darkpack/modules/powers/icons/actions.dmi'
	button_icon_state = "thaumaturgy"
	var/mob/living/possessor_original_mob
	var/possessor_ckey
	var/mob/living/possessed_bird

/datum/action/return_to_body/Trigger(mob/clicker, trigger_flags)
	. = ..()
	possessor_original_mob.PossessByPlayer(possessor_ckey)
	Remove(owner)
	to_chat(possessor_original_mob, span_cult("You feel your vision slowly becoming blurry and fading..."))
	addtimer(CALLBACK(src, PROC_REF(check_bird_dead)), 1 SCENES, TIMER_STOPPABLE)

/datum/action/return_to_body/proc/check_bird_dead()
	if(!possessed_bird || QDELETED(possessed_bird) || possessed_bird.stat == DEAD)
		return // bird is dead, all good
	possessor_original_mob.become_blind(MAGIC_TRAIT)
	to_chat(possessor_original_mob, span_warning("Your mind lingers in the raven. You find yourself blinded til the next sunrise. Maybe you should have studied that ritual a bit more closely..."))
