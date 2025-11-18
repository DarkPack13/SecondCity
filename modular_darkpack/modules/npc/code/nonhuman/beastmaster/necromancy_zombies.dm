/mob/living/basic/beastmaster/giovanni_zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk on Earth."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	mob_biotypes = MOB_UNDEAD
	speak_chance = 0
	maxHealth = 35
	health = 35
	speed = 1
	harm_intent_damage = 5
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	status_flags = CANPUSH
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	faction = list(CLAN_GIOVANNI)
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	// Atmospheric requirements (undead don't need air)
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500

/mob/living/basic/beastmaster/giovanni_zombie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	var/datum/component/obeys_commands/old = GetComponent(/datum/component/obeys_commands)
	if(old)
		qdel(old)

/mob/living/basic/beastmaster/giovanni_zombie/level1 // Low health, low damage distraction unit
	name = "drone"
	desc = "A mindless, tormented wraith."
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost"
	icon_living = "ghost"
	mob_biotypes = MOB_UNDEAD
	speak_chance = 1
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	speed = 2
	maxHealth = 60
	health = 60
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	death_message = "wails, disintegrating into a pile of ectoplasm!"
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 2
	// Ghost-specific emotes
	speak_emote = list("weeps")

/mob/living/basic/beastmaster/giovanni_zombie/level1/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, /obj/item/ectoplasm)

/mob/living/basic/beastmaster/giovanni_zombie/level2 // Fragile, low-damage harass, rat equivalent
	name = "parassita"
	desc = "A skittering something of a myriad digits and small, sharp teeth."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "ratzombie"
	icon_living = "ratzombie"
	speak_chance = 1
	response_help_continuous = "shoos away"
	response_help_simple = "shoo away"
	response_disarm_continuous = "knocks aside"
	response_disarm_simple = "knock aside"
	response_harm_continuous = "stamps"
	response_harm_simple = "stamp"
	can_be_held = TRUE
	density = FALSE
	speed = 0
	maxHealth = 20
	health = 20
	harm_intent_damage = 10
	melee_damage_lower = 8
	melee_damage_upper = 14
	attack_verb_continuous = "nibbles"
	attack_verb_simple = "nibble"
	attack_sound = 'code/modules/wod13/sounds/rat.ogg'
	speak_emote = list("squeaks")
	death_message = "rapidly shrivels up!"

/mob/living/basic/beastmaster/giovanni_zombie/level2/Initialize(mapload)
	. = ..()
	pixel_w = rand(-8, 8)
	pixel_z = rand(-8, 8)

/mob/living/basic/beastmaster/giovanni_zombie/level3 // Middling dog-level threat
	name = "compagno"
	desc = "Four legs and a menacing set of jaws is all this shambling thing shares with a canine."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "dogzombie"
	icon_living = "dogzombie"
	speak_chance = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "drags aside"
	response_disarm_simple = "drag aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speed = 0
	maxHealth = 80
	health = 80
	harm_intent_damage = 15
	melee_damage_lower = 20
	melee_damage_upper = 30
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'code/modules/wod13/sounds/dog.ogg'
	speak_emote = list("borks")
	death_message = "falls apart in a pile of fur and bones!"

/mob/living/basic/beastmaster/giovanni_zombie/level4 // Tanky, but slowed bruiser
	name = "verme"
	desc = "Husk of a man, puppeteered by some sadistic force."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "manzombie"
	icon_living = "manzombie"
	speak_chance = 1
	response_help_continuous = "shakes hands with"
	response_help_simple = "shake hands with"
	response_disarm_continuous = "pushes away"
	response_disarm_simple = "push away"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	speed = 1.5
	maxHealth = 120
	health = 120
	harm_intent_damage = 15
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_verb_continuous = "batters"
	attack_verb_simple = "batter"
	attack_sound = 'code/modules/wod13/sounds/zombuzi.ogg'
	speak_emote = list("rasps")
	death_message = "decays away into fine paste!"

/mob/living/basic/beastmaster/giovanni_zombie/level5 // Chonkmaster, only really Tzimisce mobs can provide material
	name = "patrigno"
	desc = "A nauseating mountain of putrid flesh. On its face - a jolly smirk immortalized with rigor mortis."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "fatzombie"
	icon_living = "fatzombie"
	speak_chance = 1
	response_help_continuous = "pats down"
	response_help_simple = "pat down"
	response_disarm_continuous = "tries to push"
	response_disarm_simple = "try to push"
	response_harm_continuous = "slaps"
	response_harm_simple = "slap"
	speed = 3
	maxHealth = 300
	health = 300
	harm_intent_damage = 5
	melee_damage_lower = 40
	melee_damage_upper = 50
	attack_verb_continuous = "slams into"
	attack_verb_simple = "slam into"
	attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	speak_emote = list("gurgles")
	death_message = "collapses down into a rancid puddle!"

// Player possession proc - commented out as noted in original
/*
/mob/living/basic/beastmaster/giovanni_zombie/level1/Initialize(mapload)
	. = ..()
	give_player()

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
