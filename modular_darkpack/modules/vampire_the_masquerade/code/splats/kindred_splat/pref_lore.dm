/datum/splat/vampire/kindred/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#333333", update = FALSE)
	human.set_hairstyle("Undercut Left", update = TRUE)
	human.set_eye_color("#ff0000")
	human.undershirt = "T-Shirt (Red)"
	human.update_body()
	human.equipOutfit(/datum/outfit/job/vampire/prince, TRUE)
