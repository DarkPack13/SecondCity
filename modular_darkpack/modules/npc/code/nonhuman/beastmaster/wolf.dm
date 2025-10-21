/mob/living/basic/pet/dog/darkpack
	name = "dog"
	desc = "Woof-woof."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"
	basic_mob_flags = DEL_ON_DEATH // Use this instead of del_on_death
	mob_biotypes = MOB_ORGANIC
	speed = 0.35 // This controls movement speed
	maxHealth = 80
	health = 80 // Don't set health higher than maxHealth
	melee_damage_lower = 10 // These exist in /mob/living/basic - but might need to check parent
	melee_damage_upper = 25
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
