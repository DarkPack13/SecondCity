/obj/ritual_rune/thaumaturgy/blood_trap
	name = "ward"
	desc = "Creates the Blood Trap to protect tremere or his domain. Putting the blood of others before the completion of the ritual lets them in addition to the caster to pass without setting the trap off."
	icon_state = "rune2"
	word = "DUH'K-A'U"
	var/charges
	var/list/whitelisted = list()

/obj/ritual_rune/thaumaturgy/blood_trap/complete()
	. = ..()
	if(!activated)
		for(var/obj/item/reagent_containers/C in loc)
			for(var/datum/reagent/blood/B in C.reagents.reagent_list)
				var/datum/weakref/donor_ref = B.data["donor"]
				if(!donor_ref)
					continue
				var/mob/living/carbon/human/blood_owner = donor_ref.resolve()
				if (blood_owner)
					whitelisted |= blood_owner
		activated = TRUE
		alpha = 28
		charges = last_sucess_amount
		AddElement(/datum/element/connect_loc, list(COMSIG_ATOM_ENTERED = PROC_REF(on_crossed)))
		to_chat(last_activator, span_notice("[src] will work as a trap for [charges] times!"))

/obj/ritual_rune/thaumaturgy/blood_trap/proc/on_crossed(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(isliving(arrived) && activated && arrived != last_activator)
		if (arrived in whitelisted)
			return
		var/mob/living/L = arrived
		L.adjust_fire_loss(50 + activator_bonus)
		log_combat(last_activator, arrived, "'s ward rune was triggered by")
		playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
		charges -= 1
		if (charges <= 0)
			qdel(src)

/obj/ritual_rune/thaumaturgy/blood_trap/Destroy()
	if(loc)
		UnregisterSignal(loc, COMSIG_ATOM_ENTERED)
	return ..()
