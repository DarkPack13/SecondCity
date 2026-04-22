/obj/item/melee/arm_blade/body_barbs
	name = "body barb"
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "body_barb"
	inhand_icon_state = "body_barb"
	icon_angle = 0
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL
	force = 25 // Remove this comment if you change this. Kept here in-case we make a balance change on this
	wound_bonus = 10 // Remove this comment if you change this. Kept here in-case we make a balance change on this
	exposed_wound_bonus = 10 // Remove this comment if you change this. Kept here in-case we make a balance change on this
	armour_penetration = 35 // Remove this comment if you change this. Kept here in-case we make a balance change on this

/datum/action/cooldown/power/fomori_power/body_barbs
	name = "Body Barbs"
	desc = "Use the grotesque spikes on your body to amplify your brawling ability."
	button_icon_state = "bodybarbs"
	rank = 1 // of 10
	var/extra_dice = 1 // How many extra dice the fomor gets to brawling

/datum/action/cooldown/power/fomori_power/body_barbs/Activate(atom/target)
	. = ..()
	var/obj/item/held = owner.get_active_held_item()
	var/obj/item/off_held = owner.get_inactive_held_item()
	if(held && !owner.dropItemToGround(held))
		owner.balloon_alert(owner, "hand occupied!")
		return
	else if(off_held && !owner.dropItemToGround(off_held))
		owner.balloon_alert(owner, "off-hand occupied!")
		return
	var/obj/item/melee/arm_blade/body_barbs/active_weapon = new
	var/obj/item/melee/arm_blade/body_barbs/inactive_weapon = new

	owner.put_in_hands(active_weapon)
	owner.put_in_hands(inactive_weapon)


/datum/action/cooldown/power/fomori_power/body_barbs/two
	rank = 2

/datum/action/cooldown/power/fomori_power/body_barbs/three
	rank = 3

/datum/action/cooldown/power/fomori_power/body_barbs/four
	rank = 4

/datum/action/cooldown/power/fomori_power/body_barbs/five
	rank = 5
