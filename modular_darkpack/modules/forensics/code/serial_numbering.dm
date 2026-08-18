/proc/generate_single_gun_number()
	return pick(1,2,3,4,5,6,7,8,9,0)

/proc/generate_gun_serial(digit_numbers)
	var/generated_code = ""
	while(digit_numbers)
		digit_numbers--
		generated_code += "[generate_single_gun_number()]" // cast to string
	return generated_code
