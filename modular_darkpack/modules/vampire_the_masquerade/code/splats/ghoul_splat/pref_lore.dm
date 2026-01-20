/datum/splat/vampire/ghoul/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#ac151d", update = FALSE)
	human.set_hairstyle("Long Fringe", update = TRUE)
	human.set_eye_color("#2D4118")
	human.undershirt = "Tank Top (Fire)"
	human.update_body()
