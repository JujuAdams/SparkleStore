// Feather disable all

// Whether to log SparkleStore operations. This is helpful when debugging your game but ordinarily
// can be left turned off.
#macro SPARKLE_VERBOSE  false

// Group name to initialize to when SparkleStore boots up. This can be overriden later by calling
// `SparkleSetGroupName()`. The group name determines the save directory that a file gets placed
// into on most (but not all!) platforms. Please refer to savefile documentation for consoles for
// further information.
#macro SPARKLE_DEFAULT_GROUP_NAME  "savedata"

// Group name to initialize to when running from the IDE. Setting this macro to anything other than
// `undefined` wil cause SparkleStore to initialize the group name to the macro value, overriding
// `SPARKLE_DEFAULT_GROUP_NAME` above. This is sometimes helpful when testing.
#macro SPARKLE_IDE_GROUP_NAME  undefined

// Default values for PlayStation savedata options. You can change these values at runtime using
// the relevant SparkleStore functions. Please note that the slot title must not contain spaces.
#macro SPARKLE_PLAYSTATION_SLOT_TITLE  "GameWithName"
#macro SPARKLE_PLAYSTATION_SUBTITLE    "Game savedata"

// Whether SparkleStore is allowed to use `steam_file_*` functions to save and load data. This
// macro only applies if you have enabled Steam Cloud for your game and the player has enabled
// Steam Cloud for their account. In the event that either has been disabled, SparkleStore will
// save to local storage in the file system sandbox regardless of the value of this macro.
// 
// If you set this macro to `true` then SparkleStore will default to trying to save files to
// Steam's own storage, avoiding saving the file to the sandbox area entirely. You don't need to
// configure anything for Steam Cloud to work beyond the maximum space and file count.
// 
// If you want to use Steam Auto-Cloud system - where files found into a particular directory are
// backed up automatically - then set this macro to `false` and configure Steam Cloud to point to
// the file system sandbox location (given by `game_save_id`).
// 
// If this macro is set to `true`, you can further toggle the use of `steam_file_*` functions by
// using `SparkleSetSteamFile()` which is useful to save particular kinds of files to local storage
// rather than into the cloud (e.g. for local settings files).
#macro SPARKLE_ALLOW_STEAM_FILE  false

// Maximum number of save/load operations that can be completed in a minute. These numbers are
// used to calculate the delays between operations. Default values for Nintendo Switch are
// conservative and are designed to offer extra wiggle room without violating guidelines.
#macro SPARKLE_MAX_SAVE_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)
#macro SPARKLE_MAX_LOAD_FREQUENCY  (SPARKLE_ON_SWITCH? 25 : infinity)