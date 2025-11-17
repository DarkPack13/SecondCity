/mob/living/basic/bat
	name = "bat"
	desc = "It's a bat."

	basic_mob_flags = DEL_ON_DEATH

	attack_sound = 'modular_darkpack/modules/npc/sound/rat.ogg'

	maxHealth = 10
	health = 10
	speed = -0.5

/mob/living/basic/bat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clickbox, icon_state = "sphere", max_scale = 2)
