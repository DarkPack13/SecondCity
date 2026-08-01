/obj/structure/billboard/darkpack
	name = "billboard"
	desc = "A billboard, displaying a large advertisement."
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_blank"

/obj/structure/billboard/darkpack/transam
	icon_state = "billboard_1"
	desc = "A billboard advertising TransAmerica Corporation, a holding company that manages various life insurance and investment firms."

/obj/structure/billboard/darkpack/endron
	icon_state = "billboard_2"
	desc = "A billboard advertising Endron, an oil and gas company founded in 1916. Endron, for a greener tomorrow."

/obj/structure/billboard/darkpack/endronvandal
	icon_state = "billboard_3"
	desc = "A billboard advertising Endron, an oil and gas company founded in 1916. This one seems to have been vandalised, spelling out 'end times'."

/obj/structure/billboard/darkpack/king
	icon_state = "billboard_4"
	desc = "A billboard advertising King's breweries' two flagship products, Blue Stripe and King's Lager."

/obj/structure/billboard/darkpack/kingvandal
	icon_state = "billboard_5"
	desc = "A billboard advertising King's breweries' two flagship products, Blue Stripe and King's Lager. This one seems to have been vandalised, with the word 'poison' scrawled over the ad."

/obj/structure/billboard/darkpack/bubway
	icon_state = "billboard_6"
	desc = "A billboard advertising the Bubway 'Classic Bub' sandwich for 10 dollars."

/obj/structure/billboard/darkpack/starkist
	icon_state = "billboard_7"
	desc = "A billboard advertising Starkist, the orange soda people crave. It has electrolytes!"

/obj/structure/billboard/darkpack/starkistvandal
	icon_state = "billboard_8"
	desc = "A billboard advertising Starkist, the orange soda people crave. This one seems to have been vandalised, how crude!"

/obj/structure/billboard/darkpack/redbat
	icon_state = "billboard_9"
	desc = "A billboard advertising Redbat, the premier in sporty energy drinks. Supposedly, it gives you wings."

/obj/structure/billboard/darkpack/magadon
	icon_state = "billboard_10"
	desc = "A billboard advertising Magadon Incorporated, a leading pharmaceutical company and supplier for hospitals. Magadon, building a better you."

/obj/structure/billboard/darkpack/rednews
	icon_state = "billboard_11"
	desc = "A billboard advertising Red Network, a news broadcasting company dedicated to keeping the public informed and enthralled."

/obj/effect/spawner/random/structure/billboard/darkpack
	icon = 'modular_darkpack/modules/billboard/icons/billboards.dmi'
	icon_state = "billboard_random"
	loot = list(
		/obj/structure/billboard/darkpack/transam = 50,
		/obj/structure/billboard/darkpack/endron = 50,
		/obj/structure/billboard/darkpack/endronvandal = 20,
		/obj/structure/billboard/darkpack/king = 50,
		/obj/structure/billboard/darkpack/kingvandal = 20,
		/obj/structure/billboard/darkpack/bubway = 50,
		/obj/structure/billboard/darkpack/starkist = 50,
		/obj/structure/billboard/darkpack/starkistvandal = 20,
		/obj/structure/billboard/darkpack/redbat = 50,
		/obj/structure/billboard/darkpack/magadon = 50,
		/obj/structure/billboard/darkpack/rednews = 50,
	)
