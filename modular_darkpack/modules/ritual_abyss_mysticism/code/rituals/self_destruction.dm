/obj/abyssrune/selfgib
	name = "Self Destruction"
	desc = "Meet the Final Death."
	icon_state = "rune2"
	word = "YNT FRM MCHGN FYNV DN THS B'FO" //'youre not from michigan if youve never done this before'
	cost = 1

/obj/abyssrune/selfgib/complete()
	last_activator.death()
