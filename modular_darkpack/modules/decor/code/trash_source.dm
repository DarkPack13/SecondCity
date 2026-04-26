#define COMSIG_OBJ_NPC_WALKBY "obj_npc_walkby"
#define DISPOSED_TRASH_TRAIT "disposed_trash"

/datum/component/trash_source
	COOLDOWN_DECLARE(trash_spawn_cd)
	var/datum/proximity_monitor/npc_walkby_detector/prox_monitor

/datum/component/trash_source/Initialize()
	. = ..()

	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/trash_source/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_OBJ_NPC_WALKBY, PROC_REF(guy_walked_by))
	prox_monitor = new(parent, 1)

/datum/component/trash_source/UnregisterFromParent()
	. = ..()

	UnregisterSignal(parent, COMSIG_OBJ_NPC_WALKBY)
	QDEL_NULL(prox_monitor)


/datum/component/trash_source/proc/guy_walked_by(obj/source, mob/living/carbon/human/npc/walker)
	if(walker.hostile || walker.aggressive)
		return // We are busy beating the shit out of someone.

	if(HAS_TRAIT(walker, DISPOSED_TRASH_TRAIT)) // Prevents making a conveyor of npcs to farm trash or accidential trash vortexes from stuck npcs.
		return

	if(COOLDOWN_FINISHED(src, trash_spawn_cd))
		new /obj/effect/spawner/random/maintenance(get_turf(source))

		ADD_TRAIT(walker, DISPOSED_TRASH_TRAIT, TRAIT_GENERIC)

		COOLDOWN_START(src, trash_spawn_cd, rand(1 MINUTES, 5 MINUTES))


/datum/proximity_monitor/npc_walkby_detector

/datum/proximity_monitor/npc_walkby_detector/on_entered(atom/source, atom/movable/arrived, turf/old_loc)
	. = ..()
	if(isnpc(arrived))
		SEND_SIGNAL(host, COMSIG_OBJ_NPC_WALKBY, arrived)

#undef DISPOSED_TRASH_TRAIT
#undef COMSIG_OBJ_NPC_WALKBY
