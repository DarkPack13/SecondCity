/// From /mob/living/adjust_humanity(): (/mob/living/source, humanity_change)
#define COMSIG_LIVING_CHANGING_HUMANITY "living_changing_humanity"
	/// Prevents Humanity from being changed
	#define BLOCK_HUMANITY_CHANGE (1<<0)
/// From /mob/living/adjust_humanity(): (/mob/living/source, humanity_change)
#define COMSIG_LIVING_CHANGED_HUMANITY "living_changed_humanity"

/// From /mob/living/proc/can_feed_on_blood(): (/mob/living/source)
#define COMSIG_LIVING_FEEDING_ON_BLOOD "living_feeding_on_blood"
	/// Stops the mob from gaining blood points by feeding
	#define BLOCK_BLOOD_FEEDING (1<<0)
