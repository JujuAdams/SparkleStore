# Getters

&nbsp;

## …GetRecentActivity

`SparkleGetRecentActivity([milliseconds=1200])`

**Returns:** Number

|Name          |Datatype|Purpose                                                                      |
|--------------|--------|-----------------------------------------------------------------------------|
|`milliseconds`|number  |Time window for recent activity. Defaults to 1,200 milliseconds (1.2 seconds)|

Returns whether there was save/load activity recently within the given timespan. This is useful for setting up a save/load indicator in your game's UI.

&nbsp;

## …GetSteamCloud

`SparkleGetSteamCloud()`

**Returns:** Boolean

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns if Steam Cloud is enabled. The requires all of the following to be true:

- The game is running on Windows, MacOS, or Linux
- The game is using YoYoGames' Steamworks extension
- Steam is open and running
- The application is owed by the player
- The application has been installed
- The application is set up to use Steam Cloud
- The user has enabled Steam Cloud for their account

Please note that `SPARKLE_ALLOW_STEAM_FILE` and `SoarkleSetSteamFile()` can alter where and how files are saved/loaded. If either is `false`, files will be saved to local storage and won't necesarily be backed up using Steam Cloud.

&nbsp;

## …GetTotalPending

`SparkleGetTotalPending()`

**Returns:** Number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the total number of pending operations.

&nbsp;

## …GetSavePending

`SparkleGetSavePending()`

**Returns:** Number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the number of pending save operations.

&nbsp;

## …GetLoadPending

`SparkleGetLoadPending()`

**Returns:** Number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the number of pending load operations.

&nbsp;

## …GetSaveRecent

`SparkleGetSaveRecent()`

**Returns:** Number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the number of save operations completed in the last minute.

&nbsp;

## …GetLoadRecent

`SparkleGetLoadRecent()`

**Returns:** Number

|Name|Datatype|Purpose|
|----|--------|-------|
|N/A |        |       |

Returns the number of load operations completed in the last minute.