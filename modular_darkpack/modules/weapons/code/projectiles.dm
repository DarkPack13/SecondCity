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

/obj/projectile/bullet/darkpack/vamp9mm/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	fera_silver_damage(target, 2)

// .45 ACP
/obj/projectile/bullet/darkpack/vamp45acp
	name = ".45 ACP bullet"
	damage = 20
	armour_penetration = 5

/obj/projectile/bullet/darkpack/vamp45acp/HP
	name = ".45 ACP hollow point bullet"
	damage = 25
	armour_penetration = 0
	wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp45acp/silver
	name = ".45 ACP silver bullet"

/obj/projectile/bullet/darkpack/vamp45acp/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	fera_silver_damage(target, 3)

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

/obj/projectile/bullet/darkpack/vamp44/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	fera_silver_damage(target, 4)

// .50 BMG/AE
/obj/projectile/bullet/darkpack/vamp50
	name = ".50 BMG bullet"
	damage = 70
	armour_penetration = 20
	exposed_wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp50ae
	name = ".50 AE bullet"
	damage = 40
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
		M.apply_damage(1 TTRPG_DAMAGE, BURN)
		M.adjust_fire_stacks(fire_stacks)
		M.ignite_mob()

/obj/projectile/bullet/darkpack/vamp556mm/silver
	name = "5.56mm silver bullet"
	armour_penetration = 20

/obj/projectile/bullet/darkpack/vamp556mm/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	fera_silver_damage(target, 2)

// 5.45x39mm
/obj/projectile/bullet/darkpack/vamp545mm
	name = "5.45mm bullet"
	damage = 40
	armour_penetration = 30
	exposed_wound_bonus = -5
	wound_bonus = 5

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
	exposed_wound_bonus = 5
	wound_bonus = 10

/obj/projectile/bullet/shotgun_slug/vamp/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/hit_person = target
		var/datum/storyteller_roll/knockdown_roll = new()
		knockdown_roll.applicable_stats = list(STAT_STRENGTH, STAT_DEXTERITY, STAT_ATHLETICS)
		knockdown_roll.difficulty = 3 + (!isnull(firer) ? rand(1,2) : 0)
		if(knockdown_roll.st_roll(target, firer ? firer : src) == ROLL_FAILURE)
			hit_person.Knockdown(20)
			to_chat(hit_person, span_danger("The force of a projectile sends you sprawling!"))

/obj/projectile/bullet/shotgun_slug/vamp/silver
	name = "12g silver shotgun slug"
	armour_penetration = 10

/obj/projectile/bullet/shotgun_slug/vamp/silver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	fera_silver_damage(target, 3)

/obj/projectile/bullet/darkpack/rubber
	name = "12g shotgun rubber shot"
	damage = 5
	stamina = 50
	exposed_wound_bonus = 5
	wound_bonus = -5

/obj/projectile/bullet/darkpack/incap
	name = "12g shotgun incapacitation shot"
	damage = 15
	stamina = 80

/obj/projectile/bullet/darkpack/shotpellet
	name = "12g shotgun pellet"
	damage = 9
	range = 22 //range of where you can see + one screen after
	armour_penetration = 10
	exposed_wound_bonus = 10
	wound_bonus = -5

/obj/projectile/bullet/darkpack/shotpellet/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.Stun(4)

/obj/projectile/bullet/darkpack/dragonsbreath
	name = "12g shotgun incendiary pellet"
	damage = 6
	damage_type = BURN
	range = 22 //range of where you can see + one screen after
	armour_penetration = 0
	exposed_wound_bonus = 0
	wound_bonus = 0
	var/fire_stacks = 1 // 1 stack per pellet but we have 9 pellets so it adds up

/obj/projectile/bullet/darkpack/dragonsbreath/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	do_sparks(2, TRUE, src)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.ignite_mob()

// Crossbow Bolt
/obj/projectile/bullet/crossbow_bolt
	name = "bolt"
	damage = 45
	armour_penetration = 75
	exposed_wound_bonus = 30
	wound_bonus = 30 //We're gonna make this hurt as much as possible.
	sharpness = SHARP_POINTY
	embed_type = /datum/embedding/crossbolt //YEEEEOUCH!!!!

/datum/embedding/crossbolt
	embed_chance = 90
	fall_chance = 2
	jostle_chance = 2
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.5
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 3 SECONDS

// 7.62x51mm NATO
/obj/projectile/bullet/darkpack/vamp762x51mm
	name = "7.62x51mm bullet"
	damage = 55
	armour_penetration = 25
	exposed_wound_bonus = -5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp762x51mm/incendiary
	armour_penetration = 5 //Big ass bullet
	damage = 40
	var/fire_stacks = 3 //This one comes in Semi-automatics

/obj/projectile/bullet/darkpack/vamp762x51mm/incendiary/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.apply_damage(2 TTRPG_DAMAGE, BURN)
		M.adjust_fire_stacks(fire_stacks)
		M.ignite_mob()

/obj/projectile/bullet/darkpack/vamp762x51mm/silver
	name = "7.62x51mm silver bullet"
	armour_penetration = 20

/obj/projectile/bullet/darkpack/vamp762x51mm/silver/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	fera_silver_damage(target, 4)

/obj/projectile/bullet/darkpack/vamp75
	name = ".75 ball"
	damage = 100
	armour_penetration = 5
	exposed_wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp75/silver
	name = ".75 silver ball"
	armour_penetration = 0

/obj/projectile/bullet/darkpack/vamp75/silver/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	fera_silver_damage(target, 5) //Same as silver longsword; it's a solid silver ball. As the founding fathers intended.

/obj/projectile/bullet/darkpack/c40mm
	name = "40mm grenade"
	damage = 5
	stamina = 50
	armour_penetration = 0
	exposed_wound_bonus = 5
	wound_bonus = 5
	range = 10			//Avoids issue where a grenade travels across the map
	can_hit_turfs = TRUE

	//Variable for devistation range, this can gib corpses and destroy floor plating/walls. Very strong, avoid increasing unless needed.
	var/explosive_devastation_range = 0
	//Heavy explosion range, this should be used for epicenter. More severly injures mobs than a light explosion.
	var/explosive_heavy_range = 0
	//Standard explosion range, this damages and throws mobs around. Can damage stuff but won't do what devistation does.
	var/explosive_light_range = 0
	//Flash range, self explanitory. It's for flashbang rounds.
	var/explosive_flash_range = 0
	//Fire range, self explanitory. It's for the fireball the incindary round makes.
	var/explosive_fire_range = 0
	//For if the explosive creates a smoke plume or not.
	var/smoke_effect = FALSE
	//For if the explosive is silent or not. (Ex - smoke grenade, flashbang, etc. They are 'explosive' but not like a bomb.)
	var/explosive_sound = FALSE

/obj/projectile/bullet/darkpack/c40mm/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	if(explosive_light_range || explosive_fire_range || explosive_flash_range)
		explosion(target, devastation_range = explosive_devastation_range, heavy_impact_range = explosive_heavy_range, light_impact_range = explosive_light_range, flame_range = explosive_fire_range, flash_range = explosive_flash_range, silent = explosive_sound, smoke = smoke_effect, adminlog = TRUE, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/darkpack/c40mm/explosive
	name = "40mm explosive"
	//explosive_heavy_range = 2		- Don't use this for now, it causes flooring to get destroyed.
	explosive_light_range = 4
	explosive_flash_range = 2
	explosive_fire_range = 2
	smoke_effect = TRUE
	explosive_sound = TRUE

/obj/projectile/bullet/darkpack/c40mm/incendiary
	name = "40mm incendiary"
	explosive_light_range = 2
	explosive_flash_range = 3
	explosive_fire_range = 4
	smoke_effect = TRUE
	explosive_sound = TRUE

/obj/projectile/bullet/darkpack/c40mm/incendiary/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/victim = target
		victim.adjust_fire_stacks(7)
		victim.ignite_mob()

/obj/projectile/bullet/darkpack/c40mm/teargas
	name = "40mm teargas"

/obj/projectile/bullet/darkpack/c40mm/teargas/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/projectile_drop, /obj/item/grenade/chem_grenade/teargas/instant)

/obj/projectile/bullet/darkpack/c40mm/smoke
	name = "40mm smoke"

/obj/projectile/bullet/darkpack/c40mm/smoke/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/projectile_drop, /obj/item/grenade/smokebomb/instant)

/obj/item/grenade/smokebomb/instant/Initialize(mapload)
	. = ..()
	if(detonate())
		return INITIALIZE_HINT_QDEL

/obj/projectile/bullet/darkpack/c40mm/flashbang
	name = "40mm flashbang"
	explosive_flash_range = 2
	explosive_light_range = 1
	smoke_effect = TRUE

// Only projectile of the family with no explosive element or effect
/obj/projectile/bullet/darkpack/c40mm/baton
	name = "40mm baton"
	damage = 15		//LTL, not non-lethal
	stamina = 120	//YOUCH!!!
	armour_penetration = 0
	exposed_wound_bonus = 5
	wound_bonus = 5
	range = 18	//longer range since no impact
	can_hit_turfs = FALSE	//So it can travel past the screens edge; doesn't do anything to floors anyway.
