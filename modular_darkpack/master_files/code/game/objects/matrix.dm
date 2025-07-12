/obj/matrix
	name = "matrix"
	desc = "Suicide is no exit..."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "matrix"
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/matrixing = FALSE

/obj/matrix/attack_hand(mob/user)
	if(user.client)
		if(!matrixing)
			matrixing = TRUE
			if(do_after(user, 100, src))
				cryoMob(user, src)
				matrixing = FALSE
			else
				matrixing = FALSE
	return TRUE

// TODO: [Rebase] - Refactor to line up with new cyro pod code
/proc/cryoMob(mob/living/mob_occupant, obj/pod)
	if(isnpc(mob_occupant))
		return
	if(iscarbon(mob_occupant))
		var/mob/living/carbon/C = mob_occupant
		if(C.transformator)
			qdel(C.transformator)
	var/list/crew_member = list()
	crew_member["name"] = mob_occupant.real_name

	if(mob_occupant.mind)
		// Handle job slot/tater cleanup.
		var/job = mob_occupant.mind.assigned_role
		crew_member["job"] = job
		SSjob.FreeRole(job, mob_occupant)
//		if(LAZYLEN(mob_occupant.mind.objectives))
//			mob_occupant.mind.objectives.Cut()
		mob_occupant.mind.special_role = null
	else
		crew_member["job"] = "N/A"

	if (pod)
		pod.visible_message("\The [pod] hums and hisses as it teleports [mob_occupant.real_name].")

	var/list/gear = list()
	if(ishuman(mob_occupant))		// sorry simp-le-mobs deserve no mercy
		var/mob/living/carbon/human/C = mob_occupant
		if(C.bloodhunted)
			SSbloodhunt.hunted -= C
			C.bloodhunted = FALSE
			SSbloodhunt.update_shit()
		if(C.dna)
			GLOB.fucking_joined -= C.dna.real_name
		gear = C.get_all_gear()
		for(var/obj/item/item_content as anything in gear)
			qdel(item_content)
		for(var/mob/living/L in mob_occupant.GetAllContents() - mob_occupant)
			L.forceMove(pod.loc)
		if(mob_occupant.client)
			mob_occupant.client.screen.Cut()
//			mob_occupant.client.screen += mob_ocupant.client.void
			var/mob/dead/new_player/M = new /mob/dead/new_player()
			M.key = mob_occupant.key
	QDEL_NULL(mob_occupant)
