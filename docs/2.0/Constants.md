# Library Constants

On this page are various constants (implemented as macros) that this library relies on. You may use these values in your code but you shouldn't change the value of these macros.

&nbsp;

## Miscellaneous

|Name                      |Usage                                                                               |
|--------------------------|------------------------------------------------------------------------------------|
|`SPARKLE_VERSION`         |Current verison of the library                                                      |
|`SPARKLE_DATE`            |Date the current version was published                                              |
|`SPARKLE_RUNNING_FROM_IDE`|Whether the game is running from the IDE. This will be `false` for production builds|

&nbsp;

## Operation Status

|Name                      |Usage                                                      |
|--------------------------|-----------------------------------------------------------|
|`SPARKLE_STATUS_CANCELLED`|Operation was cancelled                                    |
|`SPARKLE_STATUS_FAILED`   |Operation was reported to have failed by GameMaker         |
|`SPARKLE_STATUS_QUEUED`   |Operation has been queued and has not yet started          |
|`SPARKLE_STATUS_PENDING`  |Operation has started and we are waiting for it to complete|
|`SPARKLE_STATUS_SUCCESS`  |Operation completed successfully                           |

&nbsp;

## Priorities

|Name                        |Usage                                                                                                                                                                                                     |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`SPARKLE_PRIORITY_NORMAL`   |Operation will be added to the back of the queue and will be dispatched when prior operations have completed.                                                                                             |
|`SPARKLE_PRIORITY_HIGH`     |Operation will be added to the front of the queue and will be dispatched at the nearest opportunity ahead of enqueued operations. The operation will typically be dispatched at the start of the next step|
|`SPARKLE_PRIORITY_IMMEDIATE`|Operation will be dispatched immediately, ignoring any save/load rate limits or ordering                                                                                                                  |

!> Use of `SPARKLE_PRIORITY_IMMEDIATE` priority is potentially dangerous when running on consoles as it can corrupt savedata, especially on PlayStation. Make sure you thoroughly test your code if you use this priority.

&nbsp;

## Operation Types

|Name               |Usage                                          |
|-------------------|-----------------------------------------------|
|`SPARKLE_OP_SAVE`  |Save operation as begun by `SparkleSave()` etc.|
|`SPARKLE_OP_LOAD`  |Save operation as begun by `SparkleLoad()` etc.|
|`SPARKLE_OP_DELETE`|Save operation as begun by `SparkleDelete()`   |

&nbsp;

## Platforms

|Name                |Usage                                                     |
|--------------------|----------------------------------------------------------|
|`SPARKLE_ON_WINDOWS`|Game is running on Windows                                |
|`SPARKLE_ON_MAC`    |Game is running on MacOS                                  |
|`SPARKLE_ON_LINUX`  |Game is running on a Linux distro, including Steam OS     |
|`SPARKLE_ON_SWITCH` |Game is running on a Nintendo Switch                      |
|`SPARKLE_ON_PS4`    |Game is running on a PlayStation 4                        |
|`SPARKLE_ON_PS5`    |Game is running on a PlayStation 5                        |
|`SPARKLE_ON_XBOX`   |Game is running on an Xbox Series X or Series S           |
|`SPARKLE_ON_ANDROID`|Game is running on Android                                |
|`SPARKLE_ON_IOS`    |Game is running on iOS                                    |
|`SPARKLE_ON_PS_ANY` |Game is running on either a PlayStation 4 or PlayStation 5|
|`SPARKLE_ON_CONSOLE`|Game is running on a Switch, PlayStation, or Xbox         |
|`SPARKLE_ON_MOBILE` |Game is running on iOS or Android                         |
|`SPARKLE_ON_DESKTOP`|Game is running on Window, MacOS, or Linux                |