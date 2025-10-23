/datum/action/vampireinfo
	name = "About Me"
	desc = "Check assigned role, clan, generation, humanity, masquerade, known disciplines, known contacts etc."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/mob/living/carbon/human/host

/datum/action/vampireinfo/Trigger(trigger_flags)
	if(host)
		var/dat = {"
			<style type="text/css">

			body {
				padding: 5px;
				background-color: #090909; color: white;
			}

			</style>
			"}
		dat += "<p><center><h2>Memories</h2></center></p>"
		dat += "<p>[icon2html(getFlatIcon(host), host)]I am "
		if(host.real_name)
			dat += "[host.real_name],"
		if(!host.real_name)
			dat += "Unknown,"
		if(host.clan)
			dat += " the [host.clan.name]"
		if(!host.clan)
			dat += " the caitiff"

		if(host.mind)

			if(host.mind.assigned_role)
				if(host.mind.special_role)
					dat += ", carrying the [host.mind.assigned_role] (<font color=red>[host.mind.special_role]</font>) role."
				else
					dat += ", carrying the [host.mind.assigned_role] role."
			if(!host.mind.assigned_role)
				dat += "."
			dat += "</p>"
			if(host.mind.enslaved_to)
				dat += "<p>My Regnant is [host.mind.enslaved_to], I should obey their wants.</p>"
		var/datum/bank_account/account = host.account_id ? SSeconomy.bank_accounts_by_id["[host.account_id]"] : null
		if(account)
			dat += "<b>My bank pin is: [account.bank_pin]</b><BR>"
		var/obj/keypad/armory/armory = find_keypad(/obj/keypad/armory)
		if(armory && (host.mind.assigned_role == "Prince" || host.mind.assigned_role == "Sheriff" || host.mind.assigned_role == "Seneschal"))
			dat += "<p>The pincode for the armory keypad is<b>: [armory.pincode]</b></p>"
		var/obj/keypad/panic_room/panic = find_keypad(/obj/keypad/panic_room)
		if(panic && (host.mind.assigned_role == "Prince" || host.mind.assigned_role == "Sheriff" || host.mind.assigned_role == "Seneschal"))
			dat += "<p>The pincode for the panic room keypad is<b>: [panic.pincode]</b></p>"
		var/obj/structure/vaultdoor/pincode/bank/bankdoor = find_door_pin(/obj/structure/vaultdoor/pincode/bank)
		if(bankdoor && (host.mind.assigned_role == "Capo"))
			dat += "<p>The pincode for the bank vault is <b>: [bankdoor.pincode]</b></p>"
		if(bankdoor && (host.mind.assigned_role == "La Squadra"))
			if(prob(50))
				dat += "<p>The pincode for the bank vault is: [bankdoor.pincode]</b></p>"
			else
				dat += "<p>Unfortunately you don't know the vault code.</b></p>"
		if(host.generation)
			dat += "</p>I'm from the [host.generation] generation.</p>"
		if(host.mind.special_role)
			for(var/datum/antagonist/A in host.mind.antag_datums)
				if(A.objectives)
					dat += "<p>[printobjectives(A.objectives)]</p>"
		var/masquerade_level = " followed the Masquerade Tradition perfectly."
		switch(host.masquerade)
			if(4)
				masquerade_level = " broke the Masquerade rule once."
			if(3)
				masquerade_level = " made a couple of Masquerade breaches."
			if(2)
				masquerade_level = " provoked a moderate Masquerade breach."
			if(1)
				masquerade_level = " almost ruined the Masquerade."
			if(0)
				masquerade_level = "'m danger to the Masquerade and my own kind."
		dat += "<p>Camarilla thinks I[masquerade_level]</p>"
		var/humanity = "I'm out of my mind."
		var/enlight = FALSE
		if(host.client?.prefs?.enlightenment)
			enlight = TRUE

		if(!enlight)
			switch(host.humanity)
				if(8 to 10)
					humanity = "I'm saintly."
				if(7)
					humanity = "I feel as human as when I lived."
				if(5 to 6)
					humanity = "I'm feeling distant from my humanity."
				if(4)
					humanity = "I don't feel any compassion for the Kine anymore."
				if(2 to 3)
					humanity = "I feel hunger for <b>BLOOD</b>. My humanity is slipping away."
				if(1)
					humanity = "Blood. Feed. Hunger. It gnaws. Must <b>FEED!</b>"

		else
			switch(host.humanity)
				if(8 to 10)
					humanity = "I'm <b>ENLIGHTENED</b>, my <b>BEAST</b> and I are in complete harmony."
				if(7)
					humanity = "I've made great strides in co-existing with my beast."
				if(5 to 6)
					humanity = "I'm starting to learn how to share this unlife with my beast."
				if(4)
					humanity = "I'm still new to my path, but I'm learning."
				if(2 to 3)
					humanity = "I'm a complete novice to my path."
				if(1)
					humanity = "I'm losing control over my beast!"

		dat += "<p>[humanity]</p>"

		if(host.clan.name == "Brujah")
			if(GLOB.brujahname != "")
				if(host.real_name != GLOB.brujahname)
					dat += "<p> My primogen is:  [GLOB.brujahname].</p>"
		if(host.clan.name == "Malkavian")
			if(GLOB.malkavianname != "")
				if(host.real_name != GLOB.malkavianname)
					dat += "<p> My primogen is:  [GLOB.malkavianname].</p>"
		if(host.clan.name == "Nosferatu")
			if(GLOB.nosferatuname != "")
				if(host.real_name != GLOB.nosferatuname)
					dat += "<p> My primogen is:  [GLOB.nosferatuname].</p>"
		if(host.clan.name == "Toreador")
			if(GLOB.toreadorname != "")
				if(host.real_name != GLOB.toreadorname)
					dat += "<p> My primogen is:  [GLOB.toreadorname].</p>"
		if(host.clan.name == "Ventrue")
			if(GLOB.ventruename != "")
				if(host.real_name != GLOB.ventruename)
					dat += "<p> My primogen is:  [GLOB.ventruename].</p>"

		if(host.hud_used)
			dat += "<p><b>Known disciplines:</b><BR>"
			for(var/datum/action/discipline/D in host.actions)
				if(D.discipline)
					dat += "[D.discipline.name] [D.discipline.level] - [D.discipline.desc]<BR>"
			dat += "</p>"
		if(host.Myself)
			if(host.Myself.Friend)
				if(host.Myself.Friend.owner)
					dat += "<p><b>My friend's name is [host.Myself.Friend.owner.true_real_name].</b><BR>"
					if(host.Myself.Friend.phone_number)
						dat += "Their number is [host.Myself.Friend.phone_number].<BR>"
					if(host.Myself.Friend.friend_text)
						dat += "[host.Myself.Friend.friend_text]</p>"
			if(host.Myself.Enemy)
				if(host.Myself.Enemy.owner)
					dat += "<p><b>My nemesis is [host.Myself.Enemy.owner.true_real_name]!</b><BR>"
					if(host.Myself.Enemy.enemy_text)
						dat += "[host.Myself.Enemy.enemy_text]</p>"
			if(host.Myself.Lover)
				if(host.Myself.Lover.owner)
					dat += "<p><b>I'm in love with [host.Myself.Lover.owner.true_real_name].</b><BR>"
					if(host.Myself.Lover.phone_number)
						dat += "Their number is [host.Myself.Lover.phone_number].<BR>"
					if(host.Myself.Lover.lover_text)
						dat += "[host.Myself.Lover.lover_text]</p>"

		if(length(host.knowscontacts) > 0)
			dat += "<p><b>I know some other of my kind in this city. Need to check my phone, there definetely should be:</b><BR>"
			for(var/i in host.knowscontacts)
				dat += "-[i] contact<BR>"
			dat += "</p>"
		host << browse(HTML_SKELETON(dat), "window=vampire;size=400x450;border=1;can_resize=1;can_minimize=0")
		onclose(host, "vampire", src)
