// **************************************************************** BLOOD TRAP *************************************************************

/obj/ritualrune/blood_trap
	name = "Blood Trap"
	desc = "Creates the Blood Trap to protect tremere or his domain."
	icon_state = "rune2"
	word = "DUH'K-A'U"

/obj/ritualrune/blood_trap/complete()
	if(!activated)
		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
		activated = TRUE
		alpha = 28

/obj/ritualrune/blood_trap/Crossed(atom/movable/AM)
	..()
	if(isliving(AM) && activated)
		var/mob/living/L = AM
		L.adjustFireLoss(50+activator_bonus)
		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
		qdel(src)
