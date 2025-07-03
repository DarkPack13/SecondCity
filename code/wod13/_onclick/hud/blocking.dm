/atom/movable/screen/block
	name = "block"
	icon = 'icons/wod13/ui/buttons_wide.dmi'
	icon_state = "act_block_off"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/block/Click()
	if (ishuman(usr))
		var/mob/living/carbon/human/BL = usr
		BL.SwitchBlocking()

	. = ..()
