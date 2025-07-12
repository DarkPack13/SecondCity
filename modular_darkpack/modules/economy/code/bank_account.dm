/proc/create_bank_pin()
	var/bank_code = ""
	for(var/i = 1 to 4)
		bank_code += "[rand(0, 9)]"
	return bank_code

/datum/bank_account
	var/bank_pin
