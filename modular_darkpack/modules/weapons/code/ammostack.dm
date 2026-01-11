/obj/projectile/bullet/darkpack

/obj/projectile/bullet/darkpack/vamp9mm
	name = "9mm bullet"
	damage = 18
	exposed_wound_bonus = 10

/obj/projectile/bullet/darkpack/vamp9mm/plus
	name = "9mm HV bullet"
	damage = 22
	armour_penetration = 10

/obj/projectile/bullet/darkpack/vamp45acp
	name = ".45 ACP bullet"
	damage = 20
	armour_penetration = 2

/obj/projectile/bullet/darkpack/vamp45acp/HP
	name = "45acp hollow point bullet"
	damage = 25
	armour_penetration = 0
	wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp44
	name = ".44 bullet"
	damage = 35
	armour_penetration = 15
	exposed_wound_bonus = -5
	wound_bonus = 10

/obj/projectile/bullet/darkpack/vamp50
	name = ".50 bullet"
	damage = 70
	armour_penetration = 20
	exposed_wound_bonus = 5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp556mm
	name = "5.56mm bullet"
	damage = 45
	armour_penetration = 25
	exposed_wound_bonus = -5
	wound_bonus = 5

/obj/projectile/bullet/darkpack/vamp545mm
	name = "5.45mm bullet"
	damage = 40
	armour_penetration = 30
	exposed_wound_bonus = 5
	wound_bonus = -5

/obj/projectile/bullet/darkpack/vamp46mm
	name = "4.6mm bullet"
	damage = 19
	armour_penetration = 30
	exposed_wound_bonus = 0
	wound_bonus = 0

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

/obj/projectile/bullet/crossbow_bolt
	name = "bolt"
	damage = 45
	armour_penetration = 75
	sharpness = SHARP_POINTY

/obj/item/ammo_casing/vampire
	icon_state = "9"
	base_icon_state = "9"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')

/obj/item/ammo_casing/vampire/c9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm
	icon_state = "9"
	base_icon_state = "9"

/obj/item/ammo_casing/vampire/c9mm/plus
	name = "9mm HV bullet casing"
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm/plus
	caliber = CALIBER_9MM

/obj/item/ammo_casing/vampire/c45acp
	name = ".45 ACP bullet casing"
	desc = "A .45 ACP bullet casing."
	caliber = CALIBER_45
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp
	icon_state = "45"
	base_icon_state = "45"

/obj/item/ammo_casing/vampire/c45acp/HP
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp/HP

/obj/item/ammo_casing/vampire/c44
	name = ".44 bullet casing"
	desc = "A .44 bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/projectile/bullet/darkpack/vamp44
	icon_state = "44"
	base_icon_state = "44"

/obj/item/ammo_casing/vampire/c50
	name = ".50 bullet casing"
	desc = "A .50 bullet casing."
	caliber = CALIBER_50
	projectile_type = /obj/projectile/bullet/darkpack/vamp50
	icon_state = "50"
	base_icon_state = "50"

/obj/item/ammo_casing/vampire/c556mm
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = CALIBER_556
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm
	icon_state = "556"
	base_icon_state = "556"

/obj/item/ammo_casing/vampire/c545mm
	name = "5.45mm bullet casing"
	desc = "A 5.45mm bullet casing."
	caliber = CALIBER_545
	projectile_type = /obj/projectile/bullet/darkpack/vamp545mm
	icon_state = "545"
	base_icon_state = "545"

/obj/item/ammo_casing/vampire/c46pdw
	name = "4.6mm bullet casing"
	desc = "A 4.6mm bullet casing."
	caliber = CALIBER_46
	projectile_type = /obj/projectile/bullet/darkpack/vamp46mm
	icon_state = "556" //placeholder sprite
	base_icon_state = "556"//placeholder sprite

/obj/item/ammo_casing/vampire/c556mm/incendiary
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm/incendiary

/obj/item/ammo_casing/vampire/c12g
	name = "12g shell casing"
	desc = "A 12g shell casing."
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/projectile/bullet/shotgun_slug/vamp
	icon_state = "12"
	base_icon_state = "12"

/obj/item/ammo_casing/vampire/c12g/buck
	desc = "A 12g shell casing (00 buck)."
	projectile_type = /obj/projectile/bullet/darkpack/shotpellet
	pellets = 8
	variance = 25

/obj/item/ammo_casing/vampire/c12g/rubber
	desc = "A 12g shell casing."
	projectile_type = /obj/projectile/bullet/darkpack/rubber
	icon_state = "12r"
	base_icon_state = "12r"

/obj/item/ammo_casing/vampire/c12g/incap
	desc = "A 12g shell casing."
	projectile_type = /obj/projectile/bullet/darkpack/incap
	icon_state = "12i"
	base_icon_state = "12i"

/obj/item/ammo_casing/caseless/bolt
	name = "bolt"
	desc = "Welcome to the Middle Ages!"
	projectile_type = /obj/projectile/bullet/crossbow_bolt
	caliber = CALIBER_FOAM
	icon_state = "arrow"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	harmful = TRUE

/*
/obj/item/storage/ammostack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	var/base_caliber = "tut base_icon_state"
	var/max_patroni = 5

/obj/item/storage/ammostack/update_icon()
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		patroni = max(0, patroni+1)
	if(patroni)
		if(patroni > 1)
			icon_state = "[base_caliber]-[patroni]"
		else
			icon_state = "[base_caliber]-live"

/obj/item/storage/ammostack/attackby(obj/item/I, mob/user, params)
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		patroni = max(0, patroni+1)
	if(istype(I, /obj/item/ammo_casing/vampire))
		var/obj/item/ammo_casing/vampire/V = I
		if(patroni < max_patroni && V.base_icon_state = base_caliber)
			I.forceMove(src)
			update_icon()

/obj/item/storage/ammostack/Initialize(mapload)
	. = ..()
*/

/obj/item/ammo_box/darkpack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	w_class = WEIGHT_CLASS_NORMAL

///9mm/////////////

/obj/item/ammo_box/darkpack/c9mm
	name = "ammo box (9mm)"
	icon_state = "9box"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	max_ammo = 100
	custom_price = 300

/obj/item/ammo_box/darkpack/c9mm/plus
	name = "ammo box (9mm, +P)"
	desc = "a box of High Velocity (HV) ammo."
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/plus

/obj/item/ammo_box/darkpack/c9mm/moonclip
	name = "ammo clip (9mm)"
	desc = "a 3 round clip to hold 9mm rounds. For once, calling it a clip is accurate."
	icon_state = "9moonclip"
	max_ammo = 3
	w_class = WEIGHT_CLASS_TINY
	multiple_sprites = AMMO_BOX_PER_BULLET

//////////////////
/obj/item/ammo_box/darkpack/c45acp
	name = "ammo box (.45 ACP)"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	max_ammo = 100

/obj/item/ammo_box/darkpack/c45acp/HP
	name = "ammo box (.45 ACP HP)"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp/HP
	max_ammo = 100

/obj/item/ammo_box/darkpack/c44
	name = "ammo box (.44)"
	icon_state = "44box"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	max_ammo = 60

/obj/item/ammo_box/darkpack/c50
	name = "ammo box (.50)"
	icon_state = "50box"
	ammo_type = /obj/item/ammo_casing/vampire/c50
	max_ammo = 20

/obj/item/ammo_box/darkpack/c556
	name = "ammo box (5.56)"
	icon_state = "556box"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	max_ammo = 60
	custom_price = 2000

/obj/item/ammo_box/darkpack/c545
	name = "ammo box (5.45)"
	icon_state = "545box"
	ammo_type = /obj/item/ammo_casing/vampire/c545mm
	max_ammo = 60

/obj/item/ammo_box/darkpack/c556/incendiary
	name = "incendiary ammo box (5.56)"
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/incendiary

/obj/item/ammo_box/darkpack/c12g
	name = "ammo box (12g)"
	icon_state = "12box"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	max_ammo = 30

/obj/item/ammo_box/darkpack/c12g/buck
	name = "ammo box (12g, 00 buck)"
	icon_state = "12box_buck"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck
	custom_price = 400

/obj/item/ammo_box/darkpack/c12g/rubber
	name = "ammo box (12g, rubber shot)"
	icon_state = "12box_rubber"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/rubber

/obj/item/ammo_box/darkpack/c12g/incap
	name = "ammo box (12g, High Impact Incapacitation Round)"
	icon_state = "12box_incap"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/incap

/obj/item/ammo_box/darkpack/arrows
	name = "ammo box (arrows)"
	icon_state = "arrows"
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	max_ammo = 30

// DARKPACK TODO - GAROU
/*
//obj/item/ammo_casing/vampire/c12g/buck/silver
//	name = "silver 12g shell casing"
//	desc = "A silver filled 12g shell casing."
//	icon_state = "s12"

//obj/item/ammo_casing/vampire/c12g/buck/silver/on_hit(atom/target, blocked = 0, pierce_hit)
//	. = ..()
//	if(iswerewolf(target) || isgarou(target))
//		var/mob/living/carbon/M = target
//		if(M.auspice.gnosis)
//			if(prob(40))
//				adjust_gnosis(-1, M)
//		else
//			M.Stun(10)
//			M.adjust_brute_loss(50, TRUE)
*/

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

/obj/item/ammo_casing/vampire/c9mm/silver
	name = "9mm silver bullet casing"
	desc = "A 9mm silver bullet casing."
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm/silver
	icon_state = "s9"
	base_icon_state = "s9"

/obj/item/ammo_casing/vampire/c45acp/silver
	name = ".45 ACP silver bullet casing"
	desc = "A .45 ACP silver bullet casing."
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp/silver

/obj/item/ammo_casing/vampire/c44/silver
	name = ".44 silver bullet casing"
	desc = "A .44 silver bullet casing."
	projectile_type = /obj/projectile/bullet/darkpack/vamp44/silver
	icon_state = "s44"
	base_icon_state = "s44"

/obj/item/ammo_casing/vampire/c556mm/silver
	name = "5.56mm silver bullet casing"
	desc = "A 5.56mm silver bullet casing."
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm/silver
	icon_state = "s556"
	base_icon_state = "s556"

/obj/item/ammo_box/darkpack/c9mm/silver
	name = "ammo box (9mm silver)"
	icon_state = "9box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/silver
	max_ammo = 100

/obj/item/ammo_box/darkpack/c45acp/silver
	name = "ammo box (.45 ACP silver)"
	icon_state = "45box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp/silver
	max_ammo = 100

/obj/item/ammo_box/darkpack/c44/silver
	name = "ammo box (.44 silver)"
	icon_state = "44box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c44/silver
	max_ammo = 60

/obj/item/ammo_box/darkpack/c556/silver
	name = "ammo box (5.56 silver)"
	icon_state = "556box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/silver
	max_ammo = 60

//obj/item/ammo_box/darkpack/c12g/buck/silver
//	name = "ammo box (12g, 00 buck silver)"
//	icon_state = "s12box_buck"
//	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck/silver
