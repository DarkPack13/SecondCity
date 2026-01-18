
/datum/unit_test/unallocated_transfer_points

/datum/unit_test/unallocated_transfer_points/Run()
	for(var/obj/transfer_point_vamp/point in GLOB.unallocted_transfer_points)
		if(point.unit_test_exempt)
			continue
		TEST_FAIL("Transfer point: [point] with an id of: [point.id] at [AREACOORD(point)] failed to find a sister to link to.")
