#define MAX_FLAVOR_LEN 4096		//double the maximum message length.

/// Examine Panel headshot
#define EXAMINE_DNA_HEADSHOT "headshot"
/// Examine Panel flavor text
#define EXAMINE_DNA_FLAVOR_TEXT "flavor_text"
/// Examine Panel flavor text
#define EXAMINE_DNA_NSFW_FLAVOR_TEXT "nsfw_flavor_text"
/// Examine Panel OOC notes
#define EXAMINE_DNA_CHARACTER_NOTES "character_notes"
/// Examine Panel OOC notes
#define EXAMINE_DNA_OOC_NOTES "ooc_notes"

/// How many characters will be displayed in the flavor text preview before we cut it off?
#define FLAVOR_PREVIEW_LIMIT 110
/// The default value that will go in any new player's exploitables.
#define EXPLOITABLE_DEFAULT_TEXT "Used by antagonists. This is where you put flaws that can be exploited in any way. This will be viewable by antagonists if you modify this string, but only if there's anything at all in this box."
/// The length of records at which they will not show up, to prevent empty records from appearing.
#define RECORDS_INVISIBLE_THRESHOLD 0
/// The message displayed when someone received the View Crew Exploitables verb.
#define VIEW_CREW_EXPLOITABLES_GAIN_TEXT "You now have access to the View Crew Exploitables verb, which shows all citizens who currently have exploitable info and a link to view it!"

/// How many characters will be displayed in the temporary flavor text preview before we cut it off?
#define TEMPORARY_FLAVOR_PREVIEW_LIMIT 110
