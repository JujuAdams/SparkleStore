// Feather disable all

// Group name to forcibly use. Setting this macro to anything other than `undefined` wil cause the
// macro value to override the normal group name logic. This is useful for testing but you should
// re-set this macro to `undefined` for production builds!
#macro SPARKLE_FORCE_GROUP_NAME  undefined

// Group name to use on non-console . This is the case when running in debug or
// offline modes on different platforms. Set to `undefined` to instead throw an error when the user
// cannot be determined.
#macro SPARKLE_DEFAULT_GROUP_NAME  "savedata"

// Default values for console-specific operations. You can change these values at runtime using the
// relevant Sparkle Store functions. Please note that the slot title should not contain spaces.
#macro SPARKLE_CONSOLE_SLOT_TITLE  "Game"
#macro SPARKLE_CONSOLE_SUBTITLE    "Game savedata"

// Whether to log Sparkle Store operations. This is helpful when debugging your game but ordinarily
// can be left turned off.
#macro SPARKLE_VERBOSE  false

// Maximum number of save/load operations that can be completed in a minute. These numbers are
// used to calculate the delays between operations.
#macro SPARKLE_MAX_SAVE_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)
#macro SPARKLE_MAX_LOAD_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)

// Maximum number of operations allowed at the same time. This logic does not differentiate between
// saves and loads. A value of `1` is the safest as it ensures that prior operations complete fully
// before starting another.
#macro SPARKLE_MAX_SIMULTANEOUS_OPERATIONS  1