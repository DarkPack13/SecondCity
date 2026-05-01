/mob/living/carbon/human/register_init_signals()
	. = ..()

	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_STAKED), PROC_REF(on_staked))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_STAKED), PROC_REF(on_unstaked))
	RegisterSignal(src, COMSIG_MOB_CTRL_SHIFT_CLICKED, PROC_REF(attempt_guestbook_add))
	RegisterSignal(src, COMSIG_MOB_REQUESTING_SCREENTIP_NAME_FROM_USER, PROC_REF(name_override))

/// Gaining [TRAIT_STAKED] forces us into torpor if we're kindred, and just murders us if we're not.
/mob/living/carbon/human/proc/on_staked(datum/source)
	SIGNAL_HANDLER

	if(get_kindred_splat(src))
		INVOKE_ASYNC(src, PROC_REF(torpor), STAKE_TRAIT, TRUE)
	else
		INVOKE_ASYNC(src, PROC_REF(death))

/// Losing [TRAIT_STAKED] forces us out of torpor if we're kindred.
/mob/living/carbon/human/proc/on_unstaked(datum/source)
	SIGNAL_HANDLER

	if(get_kindred_splat(src))
		cure_torpor(STAKE_TRAIT, TRUE)

/// For Guestbooks.
/mob/living/carbon/human/proc/name_override(datum/source, list/returned_name, obj/item/held_item, mob/living/carbon/human/hovered)
	SIGNAL_HANDLER

	if(!ishuman(hovered))
		return NONE
	if(source == hovered)
		returned_name[1] = real_name
		return SCREENTIP_NAME_SET

	var/known_name = GET_GUESTBOOK_NAME(src, hovered)
	returned_name[1] = known_name ? "[known_name]" : "[hovered.name]"
	return SCREENTIP_NAME_SET
