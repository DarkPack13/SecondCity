/obj/item/melee/vamp
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	var/quieted = FALSE


/obj/item/melee/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 75, "melee", FALSE)


/obj/item/fireaxe/vamp
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	pixel_w = -8

/obj/item/katana/vamp
	name = "katana"
	desc = "An elegant weapon, its tiny edge is capable of cutting through flesh and bone with ease."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	pixel_w = -8

/obj/item/katana/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "katana", FALSE)

/obj/item/katana/vamp/fire
	name = "burning katana"
	icon_state = "firetana"
	item_flags = DROPDEL
	obj_flags = NONE
	masquerade_violating = TRUE


//Do not sell the magically summoned katanas for infinite cash
/obj/item/katana/vamp/fire/Initialize(mapload)
	. = ..()
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		qdel(sell_component)


/obj/item/katana/vamp/fire/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(isliving(target))
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, BURN)

/obj/item/katana/vamp/blood
	name = "bloody katana"
	color = "#bb0000"
	item_flags = DROPDEL
	obj_flags = NONE
	masquerade_violating = TRUE

/obj/item/katana/vamp/blood/Initialize(mapload)
	. = ..()
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		qdel(sell_component)

/obj/item/katana/vamp/blood/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(isliving(target))
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, AGGRAVATED)

/obj/item/melee/sabre/rapier
	name = "rapier"
	desc = "A thin, elegant sword, the rapier is a weapon of the duelist, designed for thrusting."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "rapier"


/obj/item/melee/sabre/rapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 700, "rapier", FALSE)


/obj/item/claymore/machete
	name = "machete"
	desc = "A certified chopper fit for the jungles...but you don't see any vines around. Well-weighted enough to be thrown."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "machete"
	inhand_icon_state = "machete"
	pixel_w = -8
	masquerade_violating = FALSE

/obj/item/claymore/machete/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 70, "machete", FALSE)

/obj/item/melee/sabre/vamp
	name = "sabre"
	desc = "A curved sword, the sabre is a weapon of the cavalry, designed for slashing and thrusting."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "sabre"

/obj/item/melee/sabre/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 1000, "sabre", FALSE)

/obj/item/claymore/longsword
	name = "longsword"
	desc = "A classic weapon of the knight, the longsword is a versatile weapon that can be used for both cutting and thrusting."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "longsword"
	inhand_icon_state = "longsword"


/obj/item/claymore/longsword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 600, "longsword", FALSE)


/obj/item/melee/baseball_bat/vamp
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "baseball"
	inhand_icon_state = "baseball"

/obj/item/melee/baseball_bat/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "baseball", FALSE)

/obj/item/melee/baseball_bat/vamp/hand
	name = "ripped arm"
	desc = "Wow, that was someone's arm."
	icon_state = "hand"
	block_chance = 25
	masquerade_violating = TRUE
	//is_wood = FALSE

/obj/item/melee/vamp/tire
	name = "tire iron"
	desc = "Can be used as a tool or as a weapon."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "pipe"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	force = 20
	wound_bonus = 10
	throwforce = 10
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/knife/vamp
	name = "knife"
	desc = "Don't cut yourself accidentally."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

/obj/item/knife/vamp/lasombra_tentacle
	name = "shadow tentacle"
	force = 7
	armour_penetration = 100
	block_chance = 0
	icon_state = "lasombra"
	item_flags = DROPDEL
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/knife/vamp/lasombra_tentacle/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/knife/vamp/lasombra_tentacle/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(16, AGGRAVATED)
		L.apply_damage(7, BURN)

/obj/item/melee/vamp/handsickle
	name = "hand sickle"
	desc = "Reap what they have sowed."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "handsickle"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	force = 30
	wound_bonus = -5
	throwforce = 15
	attack_verb_continuous = list("slashes", "cuts", "reaps")
	attack_verb_simple = list("slash", "cut", "reap")
	hitsound = 'sound/items/weapons/slash.ogg'
	armour_penetration = 40
	block_chance = 0
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/melee/touch_attack/werewolf
	name = "\improper falling touch"
	desc = "This is kind of like when you rub your feet on a shag rug so you can zap your friends, only a lot less safe."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	//catchphrase = null
	//on_use_sound = 'sound/magic/disintegrate.ogg'
	icon_state = "falling"
	inhand_icon_state = "disintegrate"

/obj/item/melee/touch_attack/werewolf/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(isliving(target))
		var/mob/living/L = target
		L.AdjustKnockdown(4 SECONDS)
		L.adjustStaminaLoss(50)
		L.Immobilize(3 SECONDS)
		if(L.body_position != LYING_DOWN)
			L.toggle_resting()
	return ..()

/obj/item/chainsaw/vamp
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

/obj/item/shovel/vamp
	name = "shovel"
	desc = "Great weapon against mortal or immortal."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "shovel"

/obj/item/scythe/vamp
	name = "scythe"
	desc = "More instrument, than a weapon. Instrumentally cuts heads..."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "kosa"
	inhand_icon_state = "kosa"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/instrument/eguitar/vamp
	name = "electric guitar"
	desc = "You are pretty fly for a white guy..."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "rock0"
	inhand_icon_state = "rock0"

/obj/item/melee/baton/vamp
	name = "police baton"
	desc = "Blunt instrument of justice."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "baton"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/switchblade/vamp
	name = "switchblade"
	desc = "A spring-loaded knife. Perfect for stabbing sharks and jets."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

/obj/item/melee/vamp/brick
	name = "Brick"
	desc = "Killer of gods and men alike, builder of worlds vast."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "red_brick"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 0
	throwforce = 15
	attack_verb_continuous = list("bludgeons", "bashes", "beats")
	attack_verb_simple = list("bludgeon", "bash", "beat", "smacks")
	hitsound = 'sound/items/weapons/genhit3.ogg'
	force = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_NORMAL
	//grid_width = 2 GRID_BOXES
	//grid_height = 1 GRID_BOXES
	var/broken = FALSE

/obj/item/melee/vamp/brick/after_throw(datum/callback/callback)
	if(prob(75))
		broken = FALSE
	if(broken)
		force = 6
		w_class = WEIGHT_CLASS_SMALL
		throwforce = 10
		armour_penetration = 0
		icon_state = "red_brick2"
		attack_verb_continuous = list("bludgeons", "bashes", "beats")
		attack_verb_simple = list("bludgeon", "bash", "beat", "smacks", "whacks")
		hitsound = 'sound/items/weapons/genhit1.ogg'
		//grid_width = 1 GRID_BOXES
		//grid_height = 1 GRID_BOXES
