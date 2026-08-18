/obj/ritual_rune/necromancy/death
	name = "death"
	desc = "Instantly transport yourself to the Shadowlands."
	icon_state = "rune2"
	word = "Y'HO 'LLOH"

/obj/ritual_rune/necromancy/death/complete()
	last_activator.death()
	qdel(src)
