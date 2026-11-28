/obj/effect/mapping_helpers/mapper_comment //exists just to hold it's name and description to allow mappers to add comments to parts of their map in the editor.
	name = "Mapper comment (Read 'Desc' variable)"
	desc = "Edit this text to your desired description."
	icon = 'modular_darkpack/modules/mapping_helpers/icons/mapping_comment.dmi'
	icon_state = "comment"
	layer = INFINITY

/obj/effect/mapping_helpers/mapper_comment/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_QDEL
