/obj/structure/sign/flag
	name = "blank flag"
	desc = "The flag of nothing. It has nothing on it. Magnificient."
	custom_materials = null
	buildable_sign = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user] grabs and folds \the [src.name]."), span_notice("You grab and fold \the [src.name]."))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)


/obj/item/sign/flag
	name = "folded blank flag"
	desc = "The folded flag of nothing. It has nothing on it. Beautiful."
	icon_state = "folded_coder"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'
	custom_materials = null
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

// Subtypes

/obj/structure/sign/flag/usa
	name = "flag of the United States"
	desc = "The flag of the United States of America. In God we trust!"
	icon_state = "flag_usa"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/california
	name = "flag of California"
	desc = "The flag of the great State of California. Eureka!"
	icon_state = "flag_california"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/california, 32)

/obj/structure/sign/flag/california/rare
	var/always = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/califorina/rare, 32)

/obj/structure/sign/flag/california/rare/Initialize(mapload)
	. = ..()
	if(prob(1) || always)
		name = "flag of New California"
		desc = "The flag of the great State of... has it always looked like that?"
		icon_state = "flag_california_rare"

/obj/structure/sign/flag/britain
	name = "flag of Great Britain"
	desc = "The flag of the United Kingdom of Great Britain and Northern Ireland. Dieu et mon droit!"
	icon_state = "flag_britain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/britain, 32)

/obj/structure/sign/flag/france
	name = "flag of France"
	desc = "The flag of the French Republic. Liberte, egalite, fraternite!"
	icon_state = "flag_france"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/france, 32)

/obj/structure/sign/flag/germany
	name = "flag of Germany"
	desc = "The flag of the Federal Republic of Germany."
	icon_state = "flag_germany"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/germany, 32)

/obj/structure/sign/flag/spain
	name = "flag of Spain"
	desc = "The flag of the Kingdom of Spain. Plus ultra!"
	icon_state = "flag_spain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/spain, 32)

/obj/structure/sign/flag/italy
	name = "flag of Italy"
	desc = "The flag of the Republic of Italy."
	icon_state = "flag_italy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/italy, 32)

/obj/structure/sign/flag/vatican
	name = "flag of the Vatican"
	desc = "The flag of Vatican City."
	icon_state = "flag_vatican"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/vatican, 32)

/obj/structure/sign/flag/russia
	name = "flag of Russia"
	desc = "The flag of the Russian Federation."
	icon_state = "flag_russia"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/russia, 32)

/obj/structure/sign/flag/soviet
	name = "flag of the Soviet Union"
	desc = "The flag of the Union of Socialist Soviet Republics. Workers of the world, unite!"
	icon_state = "flag_soviet"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/soviet, 32)

/obj/structure/sign/flag/china
	name = "flag of China"
	desc = "The flag of the People's Republic of China."
	icon_state = "flag_china"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/china, 32)

/obj/structure/sign/flag/taiwan
	name = "flag of Taiwan"
	desc = "The flag of the Republic of China."
	icon_state = "flag_taiwan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/taiwan, 32)

/obj/structure/sign/flag/japan
	name = "flag of Japan"
	desc = "The flag of the State of Japan."
	icon_state = "flag_japan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/japan, 32)

/obj/structure/sign/flag/anarchy
	name = "anarchist flag"
	desc = "The flag of the anarchist movement."
	icon_state = "flag_anarchy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/anarchy, 32)
