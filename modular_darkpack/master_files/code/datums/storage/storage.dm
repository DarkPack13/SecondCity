/datum/storage
	/// RE4-style free-placement grid inventory instead of row/column slots.
	var/grid = FALSE
	var/grid_box_size
	var/static/list/mutable_appearance/underlay_appearances_by_size = list()
	/// coordinate string ("x,y") -> list of items occupying that cell
	VAR_PRIVATE/list/grid_coordinates_to_item
	/// item -> list of every coordinate string it occupies
	VAR_PRIVATE/list/item_to_grid_coordinates
	/// item -> its anchor (top-left) coordinate, as list(x, y)
	VAR_PRIVATE/list/first_coordinates_item
