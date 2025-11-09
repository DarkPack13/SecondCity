#define TIME_TO_RING 10 SECONDS

#define USABLE_RADIO_FREQUENCY_FOR_PHONE_RANGE 2000

#define PHONE_IN_CALL (1<<0)
#define PHONE_RINGING (1<<1)
#define PHONE_CALLING (1<<2)
#define PHONE_NO_SIM (1<<3)
#define PHONE_OPEN (1<<4)

DEFINE_BITFIELD(phone_flags, list(
	"PHONE_IN_CALL" = PHONE_IN_CALL,
	"PHONE_RINGING" = PHONE_RINGING,
	"PHONE_CALLING" = PHONE_CALLING,
	"PHONE_NO_SIM" = PHONE_NO_SIM,
	"PHONE_OPEN" = PHONE_OPEN,
))

// Used for call history logging
#define PHONE_CALL_ACCEPTED "phone_call_accepted"
#define PHONE_CALL_DECLINED "phone_call_declined"
#define PHONE_CALL_MISSED "phone_call_missed"
#define PHONE_CALL_SENT "phone_call_sent"
