# Configuration Macros

&nbsp;

## `SPARKLE_VERBOSE`

*Typical value:* `false`

Whether to log SparkleStore operations. This is helpful when debugging your game but ordinarily can be left turned off.

&nbsp;

## `SPARKLE_DEFAULT_GROUP_NAME`

*Typical value:* `"savedata"`

Group name to initialize to when SparkleStore boots up. This can be overriden later by calling `SparkleSetGroupName()`. The group name determines the save directory that a file gets placed into on most (but not all!) platforms. Please refer to savefile documentation for consoles for further information.

&nbsp;

## `SPARKLE_IDE_GROUP_NAME`

*Typical value:* `undefined`

Group name to initialize to when running from the IDE. Setting this macro to anything other than `undefined` wil cause SparkleStore to initialize the group name to the macro value, overriding `SPARKLE_DEFAULT_GROUP_NAME` above. This is sometimes helpful when testing.

&nbsp;

## `SPARKLE_PLAYSTATION_SLOT_TITLE`

*Typical value:* `"GameWithName"`

Default slot title for PlayStation savedata. You can change this value at runtime using the relevant SparkleStore function. Please note that the slot title must not contain spaces.

&nbsp;

## `SPARKLE_PLAYSTATION_SUBTITLE`

*Typical value:* `"Game savedata"`

Default slot subtitle for PlayStation savedata. You can change this value at runtime using the relevant SparkleStore function.

&nbsp;

## `SPARKLE_ALLOW_STEAM_FILE`

*Typical value:* `false`

Whether SparkleStore is allowed to use `steam_file_*` functions to save and load data. This macro only applies if you have enabled Steam Cloud for your game and the player has enabled Steam Cloud for their account. In the event that either has been disabled, SparkleStore will save to local storage in the file system sandbox regardless of the value of this macro.

If you set this macro to `true` then SparkleStore will default to trying to save files to Steam's own storage, avoiding saving the file to the sandbox area entirely. You don't need to configure anything for Steam Cloud to work beyond the maximum space and file count.

If you want to use Steam Auto-Cloud system - where files found into a particular directory are backed up automatically - then set this macro to `false` and configure Steam Cloud to point to the file system sandbox location (given by `game_save_id`).

If this macro is set to `true`, you can further toggle the use of `steam_file_*` functions by using `SparkleSetSteamFile()` which is useful to save particular kinds of files to local storage rather than into the cloud (e.g. for local settings files).

&nbsp;

## `SPARKLE_MAX_SAVE_FREQUENCY`

*Typical value:* `(SPARKLE_ON_SWITCH? 25 : infinity)`

Maximum number of saves that can be completed in a minute. This value is used to calculate the delays between operations. The default value for Nintendo Switch is conservative and offers extra wiggle room without violating guidelines.

&nbsp;

## `SPARKLE_MAX_LOAD_FREQUENCY`

*Typical value:* `(SPARKLE_ON_SWITCH? 25 : infinity)`

Maximum number of loads that can be completed in a minute. This value is used to calculate the delays between operations. The default value for Nintendo Switch is conservative and offers extra wiggle room without violating guidelines.