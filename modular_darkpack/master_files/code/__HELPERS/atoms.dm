/proc/generate_items_inside(list/items_list, atom/where_to)
	for(var/each_item in items_list)
		for(var/i in 1 to items_list[each_item])
			if(!where_to?.atom_storage)
				new each_item(where_to)
			else
				var/obj/item/new_item = new each_item(get_turf(where_to))
				where_to.atom_storage.attempt_insert(new_item, null)
