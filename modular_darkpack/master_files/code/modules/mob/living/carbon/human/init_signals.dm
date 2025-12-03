/mob/living/carbon/human/register_init_signals()
	. = ..()

	RegisterSignal(src, COMSIG_MOB_CTRL_SHIFT_CLICKED, PROC_REF(attempt_guestbook_add))
