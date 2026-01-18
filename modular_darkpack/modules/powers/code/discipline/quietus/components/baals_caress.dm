//The venom applied to a weapon from Quietus 4.
//It is described as changing the damage from a weapon to aggravated damage for each bloodpoint of vitae applied to the weapon as venom.alist
//It allows for a weapon to deal aggravated damage for each swing until charges = 0.
//We've added functionality for only the Banu Haqim whose poisoned the weapon to use it to prevent buffing entire armory's worth of weapons.

/datum/component/baals_caress
	var/datum/weakref/owner_ref
	var/original_ap
	var/original_damtype
	var/original_color
	var/charges

/datum/component/baals_caress/Initialize(mob/owner, charges)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/weapon = parent

	if(!weapon.sharpness)
		return COMPONENT_INCOMPATIBLE
	owner_ref = WEAKREF(owner)
	src.charges = charges
	original_ap = weapon.armour_penetration
	original_damtype = weapon.damtype
	original_color = weapon.color
	weapon.armour_penetration = min(100, weapon.armour_penetration + 30)
	weapon.damtype = AGGRAVATED
	weapon.color = "#72b27c"

	return ..()

/datum/component/baals_caress/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_hit_living))
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))

/datum/component/baals_caress/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_ATTACK, COMSIG_ITEM_PICKUP))

	var/obj/item/weapon = parent
	weapon.armour_penetration = original_ap
	weapon.damtype = original_damtype
	weapon.color = original_color

/datum/component/baals_caress/proc/on_hit_living()
	SIGNAL_HANDLER
	charges--
	if(charges < 0)
		qdel(src)


/datum/component/baals_caress/proc/on_pickup(obj/item/source, mob/living/user)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/blade_owner = owner_ref?.resolve()
	// hey banu haqim hound, poison all our blades before we go into battle! ARGHRGH MY HAND!!!
	if(user != blade_owner)
		to_chat(user, span_userdanger("The acidic ichor sears your hand!"))
		user.apply_damage(20, BURN)
		user.Paralyze(1 SECONDS)
