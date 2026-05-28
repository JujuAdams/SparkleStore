# Option Functions

SparkleStore, in addition to its configuration macros, allows you to customise behaviour at runtime by calling these functions. The PlayStation and Xbox functions are of particular note because you will need to call `SparkleSetPSGamepadIndex()` and `SparkleSetXboxUser()` for saves to work properly at all.

&nbsp;

## …SetGroupName

`SparkleSetGroupName(groupName)`

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                          |
|-----------|--------|-------------------------------------------------------------------------------------------------|
|`groupName`|string  |                                                                                                 |

Sets the current group name. This group name will be used for future save/load operations but will not impact any operations that have already been started.

If this function is never called, the group name will default to `SPARKLE_DEFAULT_GROUP_NAME` or `SPARKLE_IDE_GROUP_NAME` as appropriate.

The group name determines the save directory that a file gets placed into on most (but not all!) platforms. Please refer to savefile documentation for consoles for further information.

&nbsp;

## …GetGroupName

`SparkleGetGroupName()`

**Returns:** string

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the currently set group name for save/load operations.

&nbsp;

## …SetSteamFile

`SparkleSetSteamFile(state)`

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                                                          |
|-------|--------|-------------------------------------------------------------------------------------------------|
|`state`|boolean |                                                                                                 |

Sets whether SparkleStore will try to use `steam_file_*()` functions when saving and loading files on desktop platforms. This function will do nothing if `SPARKLE_ALLOW_STEAM_FILE` has been set `false` (which it is by default).

If you disallow `steam_file_*` functions, SparkleStore will always save data to local storage regardless of whether Steam Cloud has been enabled. This is useful to save particular files to local storage rather than into the cloud (e.g. for local settings files).

This setting will be used for future save/load operations but will not impact any operations that have already been started.

&nbsp;

## …GetSteamFile

`SparkleGetSteamFile()`

**Returns:** boolean

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns whether SparkleStore will try to use `steam_file_*()` functions when saving and loading files on desktop platforms, as set by `SparkleSetSteamFile()`. This function will always return `false` if `SPARKLE_ALLOW_STEAM_FILE` is set to `false`.

Please see documentation for `SPARKLE_ALLOW_STEAM_FILE` for more information.

&nbsp;

# PlayStation

## …SetPSGamepadIndex

`SparkleSetPSGamepadIndex(gamepadIndex)`

**Returns:** N/A (`undefined`)

|Name          |Datatype|Purpose                                                                                          |
|--------------|--------|-------------------------------------------------------------------------------------------------|
|`gamepadIndex`|number  |                                                                                                 |

Sets the current PlayStation gamepad index for future save/load operations. This value will not impact any operations that have already been started.

&nbsp;

## …GetPSGamepadIndex

`SparkleGetPSGamepadIndex()`

**Returns:** number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the current PlayStation gamepad index for save/load operations.

&nbsp;

## …SetPSSlotTitle

`SparkleSetPSSlotTitle(slotTitle)`

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                          |
|-----------|--------|-------------------------------------------------------------------------------------------------|
|`slotTitle`|string  |                                                                                                 |

Sets the current PlayStation slot title for future save/load operations. This value will not impact any operations that have already been started. Please note that the slot title must not contain spaces.

&nbsp;

## …GetPSSlotTitle

`SparkleGetPSSlotTitle()`

**Returns:** number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the current PlayStation slot title for save/load operations.

&nbsp;

## …SetPSSlotSubtitle

`SparkleSetPSSlotSubtitle(slotSubtitle)`

**Returns:** N/A (`undefined`)

|Name          |Datatype|Purpose                                                                                          |
|--------------|--------|-------------------------------------------------------------------------------------------------|
|`slotSubtitle`|string  |                                                                                                 |

Sets the current PlayStation slot subtitle for future save/load operations. This value will not impact any operations that have already been started.

&nbsp;

## …GetPSSlotSubtitle

`SparkleGetPSSlotSubtitle()`

**Returns:** number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the current PlayStation slot subtitle for save/load operations.

&nbsp;

## …SetPSShowDialog

`SparkleSetPSShowDialog(state)`

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                                                                          |
|-------|--------|-------------------------------------------------------------------------------------------------|
|`state`|boolean |                                                                                                 |

Sets whether a OS dialog should appear when saving or loading a file. This value will not impact any operations that have already been started.

&nbsp;

## …GetPSShowDialog

`SparkleGetPSShowDialog()`

**Returns:** number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

&nbsp;

# Xbox & GDK

## …SetXboxUser

`SparkleSetXboxUser(xboxUser)`

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                                                                          |
|----------|--------|-------------------------------------------------------------------------------------------------|
|`xboxUser`|int64   |                                                                                                 |

Sets the current Xbox user for future save/load operations. This value will not impact any operations that have already been started. You should still call this function even if you're using GDK on Windows.

?> To bring Xbox Series X/S into parity with PlayStation, you might want to make use of `xboxone_user_for_pad()`. For GDK on Windows, you should use the account picker in combination with `xboxone_get_activating_user()`.

&nbsp;

## …GetXboxUser

`SparkleGetXboxUser()`

**Returns:** int64

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the current Xbox user for save/load operations.

&nbsp;

## …SetWindowsUseGDK

`SparkleSetWindowsUseGDK()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Sets up GDK functions for use with saving and loading. This function should only be called once and must be called before saving/loading any data (otherwise SparkleStore will use the wrong internal functions).

!> You will still need to call `gdk_init()`, `gdk_update()` etc. in your own code.

&nbsp;

## …GetWindowsUseGDK

`SparkleGetWindowsUseGDK()`

**Returns:** int64

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns whether SparkleStore is using GDK on Windows. This function will always return `false` when not on Windows.