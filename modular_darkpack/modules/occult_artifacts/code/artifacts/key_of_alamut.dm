/obj/item/vtm_artifact/key_of_alamut
	true_name = "Key of Alamut"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut"
	research_value = 30

/obj/item/vtm_artifact/key_of_alamut/bind(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+20

/obj/item/vtm_artifact/key_of_alamut/unbind(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-20
