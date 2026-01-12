// Feather disable all

// Group name to initialize to when the library boots up. This can be overriden later by calling
// `SparkleSetGroupName()`. The group name determines the save directory that a file gets placed
// into on most (but not all!) platforms. Please refer to savefile documentation for consoles for
// further information.
#macro SPARKLE_DEFAULT_GROUP_NAME  "savedata"

// Group name to initialize to when running from the IDE. Setting this macro to anything other than
// `undefined` wil cause Sparkle Store to initialize the group name to the macro value, overriding
// `SPARKLE_DEFAULT_GROUP_NAME` above. This is sometimes helpful when testing.
#macro SPARKLE_IDE_GROUP_NAME  undefined

// Default values for console-specific operations. You can change these values at runtime using the
// relevant Sparkle Store functions. Please note that the slot title should not contain spaces for
// compatibility cross-platform.
#macro SPARKLE_CONSOLE_SLOT_TITLE  "GameWithName"
#macro SPARKLE_CONSOLE_SUBTITLE    "Game savedata"

// Whether to log Sparkle Store operations. This is helpful when debugging your game but ordinarily
// can be left turned off.
#macro SPARKLE_VERBOSE  true

// Maximum number of save/load operations that can be completed in a minute. These numbers are
// used to calculate the delays between operations. Default values for Nintendo Switch are
// conservative and are designed to offer extra wiggle room without violating guidelines.
#macro SPARKLE_MAX_SAVE_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)
#macro SPARKLE_MAX_LOAD_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)

// Maximum number of operations (saves and loads combined) allowed at the same time. A value of `1`
// is the safest as it ensures that prior operations complete fully before starting another.
// 
// N.B. This macro is internally forced to `1` on consoles to work around limitations with
//      GameMaker's native file operations.
// 
#macro SPARKLE_MAX_SIMULTANEOUS_OPERATIONS  1