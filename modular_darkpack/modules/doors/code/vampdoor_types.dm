/obj/structure/vampdoor/old // Blue utility door with a vent. // TODO: Atmos passthrough var for when/if atmos is implemented
	name = "old door"
	icon_state = "old-1"
	base_icon_state = "old-1"


/obj/structure/vampdoor/reinf // Blue three-paneled door
	name = "reinforced door"
	icon_state = "reinf-1"
	base_icon_state = "reinf-1"


/obj/structure/vampdoor/prison // Metal bar door, such as for prison or sewers
	name = "security door"
	icon_state = "prison-1"
	base_icon_state = "prison-1"


/obj/structure/vampdoor/wood // Six paneled plain wooden door
	name = "wooden door"
	icon_state = "wood-1"
	base_icon_state = "wood-1"
	burnable = TRUE
	open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'


/obj/structure/vampdoor/oldwood // Six paneled wooden door with peeling green paint
	name = "old wooden door"
	icon_state = "oldwood-1"
	base_icon_state = "oldwood-1"
	burnable = TRUE
	open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'


/obj/structure/vampdoor/simple // Green metal door
	name = "simple door"
	icon_state = "cam-1"
	base_icon_state = "cam-1"


// TODO: [Rebase] - Make vaults a subtype of vampdoor? Some of the 'force this door open' snowflake code could be used for normal doors.
/*/obj/structure/vampdoor/vault // Huge metal behemoth of a door with a large crank instead of a handle
	name = "Vault Door"
	desc = "A heavy duty door that looks like it could withstand a lot of punishment."
	icon = 'modular_darkpack/modules/deprecated/icons/doors.dmi'
	icon_state = "vault-1"
	base_icon_state = "vault"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF*/
