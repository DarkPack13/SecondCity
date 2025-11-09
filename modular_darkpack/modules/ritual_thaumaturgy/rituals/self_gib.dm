/obj/ritualrune/selfgib
	name = "Self Destruction"
	desc = "Meet the Final Death."
	icon_state = "rune2"
	word = "CHNGE DA'WORD, GDBE"

/obj/ritualrune/selfgib/complete()
	last_activator.death()

