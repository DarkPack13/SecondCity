/mob/living/basic/beastmaster/giovanni_zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk on Earth."
	icon = 'modular_darkpack/modules/graveyard/icons/zombies.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	maxHealth = 50
	health = 50
	speed = 1
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/effects/hallucinations/growl1.ogg'
	status_flags = CANPUSH
	basic_mob_flags = DEL_ON_DEATH
	faction = list(VAMPIRE_CLAN_GIOVANNI)
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon

/mob/living/basic/beastmaster/giovanni_zombie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	var/datum/component/obeys_commands/old = GetComponent(/datum/component/obeys_commands)
	if(old)
		qdel(old)

/mob/living/basic/beastmaster/giovanni_zombie/level1
	name = "ghost"
	desc = "A soul of the dead, spooky."
	icon = 'icons/mob/simple/mob.dmi'
	icon_state = "ghost"
	icon_living = "ghost"
	mob_biotypes = MOB_SPIRIT
	speed = 2
	maxHealth = 50
	health = 50
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/effects/hallucinations/growl1.ogg'
	death_message = "wails, disintegrating into a pile of ectoplasm!"
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 2
	faction = list(VAMPIRE_CLAN_GIOVANNI)

/mob/living/basic/beastmaster/giovanni_zombie/level1/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, /obj/item/ectoplasm)

/mob/living/basic/beastmaster/giovanni_zombie/level2
	maxHealth = 75
	health = 75
	melee_damage_lower = 20
	melee_damage_upper = 20

/mob/living/basic/beastmaster/giovanni_zombie/level3
	maxHealth = 100
	health = 100
	icon_state = "zombieup"
	icon_living = "zombieup"
	icon_dead = "zombieup_dead"
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/basic/beastmaster/giovanni_zombie/level4
	maxHealth = 150
	health = 150
	melee_damage_lower = 30
	melee_damage_upper = 30
	icon_state = "skeleton"
	icon_living = "skeleton"
	icon_dead = "skeleton_dead"

/mob/living/basic/beastmaster/giovanni_zombie/level5
	maxHealth = 350
	health = 350
	melee_damage_lower = 35
	melee_damage_upper = 35
	icon_state = "zombietop"
	icon_living = "zombietop"
	icon_dead = "zombietop_dead"
	speed = 4

//these were defined on each level of the giovanni_zombie.
/*
/mob/living/basic/beastmaster/giovanni_zombie/level5/Initialize(mapload)
	. = ..()
	give_player()
*/
/*
/mob/living/basic/beastmaster/giovanni_zombie/proc/give_player()
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as summoned ghost?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, span_ghostalert("Someone is summoning a ghost!"))
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		name = C.name
		key = C.key
		visible_message(span_danger("[src] rises with fresh soul!"))
		return TRUE
	visible_message(span_warning("[src] remains unsouled..."))
	return FALSE
*/

