/datum/action/cooldown/power/gift/sense_magic
	name = "Sense Magic"
	desc = {"The werewolf can sense the pulse and flux of mystic energies, whether the righteous Gifts of the Garou,
	the arrogant wizardry of mages, the debased powers of vampires, or even the black arts of the Wyrm's minions"}
	rank = 1


/datum/storyteller_roll/gift/sense_magic
	bumper_text = /datum/action/cooldown/power/gift/sense_magic::name
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION) // DARKPACK TODO - STAT_ENIGMA is not real yet.
	numerical = TRUE


/proc/spawn_magic_after_effect(loc, magic_strength, creating_mob, full_text)
	var/obj/effect/abstract/magic_after_effect/old_effect = locate() in loc
	if(old_effect)
		qdel(old_effect)
	var/obj/effect/abstract/magic_after_effect/new_effect = new(loc, magic_strength, creating_mob)


// the "after effect" created after using most magic. To be detected by magic sensing abilties
/obj/effect/abstract/magic_after_effect
	name = "lingering magic"
	icon_state = "purplesparkles"
	anchored = TRUE
	invisibility = INVISIBILITY_ABSTRACT

	var/creation_time
	/// Rough estimate of the power of the effect. Ballparked to powerscale to the rank of the gifts/discs/powers.
	var/magic_strength = 1
	/// IF this effect can be sourced from a mob, a weakref of them.
	var/datum/weakref/creation_mob

/obj/effect/abstract/magic_after_effect/Initialize(mapload, magic_strength = 1, creating_mob)
	. = ..()
	creation_time = world.time
	src.magic_strength = magic_strength
	if(creating_mob)
		creating_mob = WEAKREF(creating_mob)

/obj/effect/abstract/magic_after_effect/proc/get_time_alive()
	return world.time - creation_time
