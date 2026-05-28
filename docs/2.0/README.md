<img src="https://raw.githubusercontent.com/JujuAdams/SparkleStore/master/LOGO.png" width="50%" style="display: block; margin: auto;" />
<h1 align="center">SparkleStore 1.3</h1>
<p align="center">Cross-platform savedata save/load system for GameMaker 2024.14</p>

<p align="center"><a href="https://github.com/JujuAdams/SparkleStore/releases/" target="_blank">Download the .yymps</a></p>

---

SparkleStore is a set of helper functions that wrap around GameMaker's native buffer functions and makes saving and loading savedata more convenient and more robust. The file access flow is handled so that every platform behaves in similar and predictable ways without you needing to figure out the correct steps yourself. The goal is that you can build your game with SparkleStore on one platform and then deploy that game onto other platforms with the minimum amount of work.

All file access - save, load, delete - is done using asynchronous functions. These are the only functions that are guaranteed in GameMaker to work in all situations cross-platform. SparkleStore's API uses function callbacks rather than you having to built inside of the clumsy GameMaker async event system. Callbacks are far easier to use and lend themselves to better organisation of code.

SparkleStore can save and load binary buffers as you'd expect but it can also save strings, JSON, sprites, and surfaces. These are built safely such that corrupted or unexpected data is handled gracefully with a fail state instead of crashing your game.

&nbsp;

## Desktop (without Steam), Android, iOS

SparkleStore will save into the file system sandbox on these platforms. You may configre what sandbox directory files are saved to by calling `SparkleSetGroupName()` or setting `SPARKLE_DEFAULT_GROUP_NAME`. You may set an optional group name (and therefore directory) when running from the IDE by setting `SPARKLE_IDE_GROUP_NAME`.

?> Saving outside of the sandbox is not supported.

&nbsp;

## Steam

By default, SparkleStore will behave the same as on desktop platforms by saving and loading files from local storage (see above). For your game to store files with Steam Cloud, you will need to set up Steam Auto-Cloud by pointing it to the local file system sandbox (given by `game_save_id`).

However, you can skip setting up Auto-Cloud by setting the SparkleStore config macro `SPARKLE_ALLOW_STEAM_FILE` to `true`. With this macro enabled, and provided 1) Steam Cloud is enabled for your game 2) the player has enabled Steam Cloud for their account 3) Steam is running,  SparkleStore will attempt to use `steam_file_*()` functions to save files to Steam Cloud without accessing local storage at all. You can further toggle whether a specific file should be accessed using `steam_file_*()` functions by calling `SparkleSetSteamFile()` which is helpful for saving local settings that shouldn't be shared across devices.

Using `steam_file_*()` by setting `SPARKLE_ALLOW_STEAM_FILE` to `true` means that if you run the game without Steam being open (e.g. during development) you will save files to local storage in the sandbox area. This can be confusing because different files will be accessed depending on whether you have Steam open or not. No data will be *lost* however, just stored in a different location, and this will never happen for players because Steam must be open for the game to run anyway.

&nbsp;

## Nintendo Switch

`switch_save_data_commit()` is called automatically for each file that is saved successfully. File save and load rate limits are automatically enforced by SparkleStore. You can adjust the rate limiting by editing `SPARKLE_MAX_SAVE_FREQUENCY` and `SPARKLE_MAX_LOAD_FREQUENCY`.

?> Files are saved and loaded for the user that opened the game (which is GameMaker's default behaviour). You will most likely want to use the `Required` option in the `Console account selection at startup` section of your game's .nmeta file. If you would like to save and load files for another user, you will need to call the mount and unmount functions yourself.

?> I do not have access to a Switch 2 for testing. My understanding is that little in the API has changed. Please get in touch if adjustments need to be made for Switch 2.

&nbsp;

## PlayStation

You must call `SparkleSetPSGamepadIndex()` to set the player whose savedata you're going to access. You may also choose to call `SparkleSetPSShowDialog()` to control whether the save/load OS dialog is shown. On this platform, you will also want to set `SPARKLE_PLAYSTATION_SLOT_TITLE` and `SPARKLE_PLAYSTATION_SUBTITLE` so that the correct information is shown in the OS. You can adjust the current slot title and slot subtitle at runtime using the associated functions. SparkleStore will automatically use the backup system on PlayStation 4.

!> SparkleStore only supports SDK 12.00 and above.

&nbsp;

## Xbox GDK

You must call `SparkleSetXboxUser()` to set the player whose savedata you're going to access. When running on Windows and are using the GDK, you must call `SparkleSetWindowsUseGDK()` immediately when the game boots to ensure that the correct savedata functions are called. GDK file access will not work unless `gdk_init()` and `gdk_update()` are being used correctly so bear that in mind during testing.

?> SparkleStore does not support the legacy XDK API.

&nbsp;

## Other Platforms (Opera GX etc.)

These platforms have not been tested and are not officially supported by SparkleStore. However, the underlying code that is used by SparkleStore conforms to standard GameMaker practices. Saving and loading on unofficial platforms should work fine.
