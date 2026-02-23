
/datum/phone_message
	var/contact_name = ""
	var/number = ""
	var/message_text = ""
	var/time = ""
	var/timestamp = 0
	var/is_outgoing = FALSE

/datum/phone_message/New(contact_name, number, message_text, is_outgoing = FALSE)
	src.contact_name = contact_name
	src.number = number
	src.message_text = message_text
	src.is_outgoing = is_outgoing
	src.timestamp = station_time()
	src.time = station_time_timestamp("hh:mm")

/datum/phone_conversation
	var/contact_name = ""
	var/contact_number = ""
	var/list/messages = list()

/datum/phone_conversation/proc/add_message(message_text, is_outgoing = FALSE)
	var/datum/phone_message/new_message = new /datum/phone_message(contact_name, contact_number, message_text, is_outgoing)
	messages += new_message
	return new_message

/datum/phone_conversation/New(contact_name, contact_number)
	src.contact_name = contact_name
	src.contact_number = contact_number
