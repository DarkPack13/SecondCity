/mob/living/simple_animal/hostile/beastmaster/rat/flying
	icon = 'icons/wod13/mobs.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	name = "bat"
	desc = "It's a bat."
	is_flying_animal = TRUE
	maxHealth = 10
	health = 10
	speed = -0.8

/mob/living/simple_animal/hostile/beastmaster/rat/flying/UnarmedAttack(atom/A)
	. = ..()

	if (!ishuman(A))
		return

	var/mob/living/carbon/human/victim = A
	if (!victim.bloodpool)
		return
	if (!prob(10))
		return
	victim.bloodpool = max(0, victim.bloodpool - 1)
	beastmaster.bloodpool = min(beastmaster.maxbloodpool, beastmaster.bloodpool+1)
