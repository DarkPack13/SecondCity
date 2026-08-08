/atom/movable/screen/storage/cell
	var/datum/storage_interface/owner_interface

/atom/movable/screen/storage/cell/Destroy()
	. = ..()
	owner_interface = null

/atom/movable/screen/storage/cell/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

/atom/movable/screen/storage/cell/MouseExited(location, control, params)
	. = ..()
	var/datum/storage_interface/ui = owner_interface
	if(!istype(ui) || !ui.parent_storage.grid)
		return
	if(usr.client)
		usr.client.screen -= ui.hovering
		ui.hovering.users -= usr.client

/atom/movable/screen/storage/cell/MouseMove(location, control, params)
	. = ..()
	var/datum/storage_interface/ui = owner_interface
	if(!istype(ui) || !ui.parent_storage.grid)
		return
	ui.update_hover(usr, params)

/atom/movable/screen/storage_hover
	icon = 'icons/hud/storage.dmi'
	icon_state = "white"
	plane = ABOVE_HUD_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 96
	var/list/users = list()

/atom/movable/screen/storage_hover/Destroy()
	. = ..()
	for(var/client/client in users)
		client.screen -= src
		users -= client
