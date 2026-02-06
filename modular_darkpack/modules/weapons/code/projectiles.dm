/obj/projectile/bullet/darkpack
	abstract_type = /obj/projectile/bullet/darkpack

// 9x19mm Parabellum
/obj/projectile/bullet/darkpack/vamp9mm
	name = "9mm bullet"
	damage = 18
	exposed_wound_bonus = 10

/obj/projectile/bullet/darkpack/vamp9mm/plus
	name = "9mm HV bullet"
	damage = 22
	armour_penetration = 10

/obj/projectile/bullet/darkpack/vamp9mm/silver
	name = "9mm silver bullet"

/*
/obj/projectile/bullet/darkpack/vamp9mm/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(10, AGGRAVATED)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)
*/
// .45 ACP
/obj/projectile/bullet/darkpack/vamp45acp
	name = ".45 ACP bullet"
	damage = 20
	armour_penetration = 2

/obj/projectile/bullet/darkpack/vamp45acp/HP
	name = ".45 ACP hollow point bullet"
	damage = 25
	armour_penetration = 0
	wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp45acp/silver
	name = ".45 ACP silver bullet"

/*
/obj/projectile/bullet/darkpack/vamp45acp/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(15, AGGRAVATED)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)
*/
// .44 Magnum
/obj/projectile/bullet/darkpack/vamp44
	name = ".44 bullet"
	damage = 35
	armour_penetration = 15
	exposed_wound_bonus = -5
	wound_bonus = 10

/obj/projectile/bullet/darkpack/vamp44/silver
	name = ".44 silver bullet"
	//icon_state = "s44"

/*
/obj/projectile/bullet/darkpack/vamp44/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(20, AGGRAVATED)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)
*/
// .50 BMG/AE
/obj/projectile/bullet/darkpack/vamp50
	name = ".50 BMG bullet"
	damage = 70
	armour_penetration = 20
	exposed_wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp50ae
	name = ".50 AE bullet"
	damage = 70
	armour_penetration = 20
	exposed_wound_bonus = 5
	wound_bonus = 5

// 5.56mm NATO
/obj/projectile/bullet/darkpack/vamp556mm
	name = "5.56mm bullet"
	damage = 45
	armour_penetration = 25
	exposed_wound_bonus = -5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp556mm/incendiary
	armour_penetration = 0
	damage = 30
	var/fire_stacks = 4

/obj/projectile/bullet/darkpack/vamp556mm/incendiary/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.ignite_mob()

/obj/projectile/bullet/darkpack/vamp556mm/silver
	name = "5.56mm silver bullet"
	armour_penetration = 20

/*
/obj/projectile/bullet/darkpack/vamp556mm/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(20, AGGRAVATED)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)
*/
// 5.45x39mm
/obj/projectile/bullet/darkpack/vamp545mm
	name = "5.45mm bullet"
	damage = 40
	armour_penetration = 30
	exposed_wound_bonus = 5
	wound_bonus = -5

// 4.6mm HK
/obj/projectile/bullet/darkpack/vamp46mm
	name = "4.6mm bullet"
	damage = 19
	armour_penetration = 30
	exposed_wound_bonus = 0
	wound_bonus = 0

// 12 Gauge
/obj/projectile/bullet/shotgun_slug/vamp
	name = "12g shotgun slug"
	damage = 70
	armour_penetration = 15
	exposed_wound_bonus = 10
	wound_bonus = 5

/obj/projectile/bullet/darkpack/rubber
	name = "12g shotgun rubber shot"
	damage = 5
	stamina = 50

/obj/projectile/bullet/darkpack/incap
	name = "12g shotgun incapacitation shot"
	damage = 15
	stamina = 80

/obj/projectile/bullet/shotgun_slug/vamp/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/hit_person = target
		if(SSroll.storyteller_roll(
			dice = hit_person.st_get_stat(STAT_STRENGTH) + min(hit_person.st_get_stat(STAT_DEXTERITY) + hit_person.st_get_stat(STAT_ATHLETICS)),
			difficulty = 3 + (!isnull(firer) ? rand(1,2) : 0),
			mobs_to_show_output = target
		) == ROLL_FAILURE)
			hit_person.Knockdown(20)
			to_chat(hit_person, span_danger("The force of a projectile sends you sprawling!"))

/obj/projectile/bullet/darkpack/shotpellet
	name = "12g shotgun pellet"
	damage = 9
	range = 22 //range of where you can see + one screen after
	armour_penetration = 15
	exposed_wound_bonus = 5
	wound_bonus = 0

/obj/projectile/bullet/darkpack/shotpellet/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.Stun(4)

// Crossbow Bolt
/obj/projectile/bullet/crossbow_bolt
	name = "bolt"
	damage = 45
	armour_penetration = 75
	sharpness = SHARP_POINTY

// 7.62x51mm NATO
/obj/projectile/bullet/darkpack/vamp762x51mm
	name = "7.62x51mm bullet"
	damage = 55
	armour_penetration = 25
	exposed_wound_bonus = -5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp762x51mm/incendiary
	armour_penetration = 5 //Big ass bullet
	damage = 50
	var/fire_stacks = 3 //This one comes in Semi-automatics

/obj/projectile/bullet/darkpack/vamp762x51mm/incendiary/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.ignite_mob()


/obj/projectile/bullet/darkpack/vamp762x51mm/silver
	name = "7.62x51mm silver bullet"
/*
/obj/projectile/bullet/darkpack/vamp762x51mm/silver/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		var/mob/living/carbon/M = target
		if(M.auspice.gnosis)
			if(prob(50))
				adjust_gnosis(-1, M)

		M.apply_damage(20, CLONE)
		M.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)
*/

/obj/projectile/bullet/darkpack/vamp75
	name = ".75 ball"
	damage = 100
	armour_penetration = 5
	exposed_wound_bonus = 5
	wound_bonus = 5
