/// Uses the left operator when compiling, uses the right operator when not compiling.
// Currently uses the CBT macro, but if http://www.byond.com/forum/post/2831057 is ever added,
// or if map tools ever agree on a standard, this should switch to use that.

#if defined(CBT) || defined(SHOW_INVENTORY_ICONS)
#define ONFLOOR_ICON_HELPER(_icon) onflooricon = ##_icon
#else
#define ONFLOOR_ICON_HELPER(_icon) icon = ##_icon; onflooricon = ##_icon
#endif

// Was getting weird behavoir when I had the defines in the same if define.
#if defined(CBT) || defined(SHOW_INVENTORY_ICONS)
#define ONFLOOR_ICONSTATE_HELPER(_icon_state) onflooricon_state = ##_icon_state
#else
#define ONFLOOR_ICONSTATE_HELPER(_icon_state) icon_state = ##_icon_state; onflooricon_state = ##_icon_state
#endif
