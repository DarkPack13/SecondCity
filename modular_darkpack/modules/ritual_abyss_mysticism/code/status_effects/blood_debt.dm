/datum/status_effect/blood_debt
	id = "blood_debt"
	duration = STATUS_EFFECT_PERMANENT
	alert_type = /atom/movable/screen/alert/status_effect/blood_debt
	var/debt_amount = 0
	var/initial_bloodpool = 0

/datum/status_effect/blood_debt/on_creation(mob/living/owner, spent)
	debt_amount = spent
	initial_bloodpool = owner.bloodpool
	return ..()

/datum/status_effect/blood_debt/tick()
	. = ..()
	var/blood_gained = owner.bloodpool - initial_bloodpool

	if(owner.bloodpool < initial_bloodpool)
		initial_bloodpool = owner.bloodpool

	if(blood_gained > 0)
		var/payment = min(blood_gained, debt_amount)
		owner.adjust_blood_pool(-payment)
		debt_amount -= payment
		initial_bloodpool = owner.bloodpool

		if(debt_amount <= 0)
			qdel(src)

/atom/movable/screen/alert/status_effect/blood_debt
	name = "Blood Debt"
	desc = "You cannot gain blood points until your debt is paid."
	icon = 'modular_darkpack/modules/ritual_abyss_mysticism/icons/blood_debt_icon.dmi'
	icon_state = "bhole3"

