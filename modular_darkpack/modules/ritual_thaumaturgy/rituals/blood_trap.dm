/obj/ritualrune/blood_trap
	name = "Blood Trap"
	desc = "Creates the Blood Trap to protect tremere or his domain."
	icon_state = "rune2"
	word = "DUH'K-A'U"

/obj/ritualrune/blood_trap/complete()
	if(!activated)
		playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
		activated = TRUE
		alpha = 28
		AddElement(/datum/element/connect_loc, list(COMSIG_ATOM_ENTERED = PROC_REF(on_crossed)))

/obj/ritualrune/blood_trap/proc/on_crossed(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(isliving(arrived) && activated)
		var/mob/living/L = arrived
		L.adjustFireLoss(50 + activator_bonus)
		playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
		qdel(src)

/obj/ritualrune/blood_trap/Destroy()
	if(loc)
		UnregisterSignal(loc, COMSIG_ATOM_ENTERED)
	return ..()
