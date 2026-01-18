# Save Functions

Functions on this page relate to saving data to storage. There are a few variants but all work fundamentally the same way. Please read the documentation for `SparkleSave()` before other functions.

&nbsp;

## …Save

`SparkleSave(filename, buffer, [callback], [callbackMetadata], [offset=0], [size], [priority=normal])`

**Returns:** struct

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to save. This should be the filename itself and should not contain a directory|
|`buffer`            |buffer  |Buffer to save                                                                                 |
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[offset]`          |number  |Position in the buffer to start saving from. Default to `0`, the start of the buffer           |
|`[size]`            |number  |Number of bytes to save. Defaults to the entire contents of the buffer                         |
|`[priority]`        |number  |How soon to save. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous save operation for a buffer (or part of a buffer). You may optionally specify an offset and size for the data you want to save. If not defined, the entire buffer will be saved. You can also specify a priority using one of the `SPARKLE_PRIORITY_*` constants. Please see `__SparkleConstants` for more information.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to save into a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                                      |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the save operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information       |
|1              |The buffer used to save the file. You must destroy this buffer with `buffer_delete()` if you have no other use for it otherwise you will have a memory leak|
|2              |The callback metadata specified when calling `SparkleSave()`                                                                                               |

!> If you do not specify a callback and you have no other use for the buffer, you must destroy the buffer otherwise you will have a memory leak.

This function returns a struct that contains private information that SparkleStore needs to track file saving. The struct has no public variables. However, it has the following public methods:

|Method Name             |Usage                                                                                                                                                                                                                 |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.GetOperation()`       |Returns `SPARKLE_OP_SAVE`                                                                                                                                                                                             |
|`.GetFilename()`        |Returns the filename that the operation is targeting                                                                                                                                                                  |
|`.GetCallbackMetadata()`|Returns the callback metadaata set when calling `SparkleSave()`                                                                                                                                                       |
|`.Cancel()`             |Cancels the operation immediately. This will execute the callback with the `SPARKLE_STATUS_CANCELLED` status. If the operation is cancelled afer the OS has started saving data then a file may still be saved to disk|
|`.GetStatus()`          |Returns the status of the operation. This will be one of the `SPARKLE_STATUS_*` constants. Please see `__SparkleConstants` for more information                                                                       |

&nbsp;

## …SaveString

`SparkleSaveString(filename, string, [callback], [callbackMetadata], [priority=normal])`

**Returns:** struct

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to save. This should be the filename itself and should not contain a directory|
|`string`            |string  |String to save                                                                                 |
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|number  |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to save. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous save operation for a string. This function is a wrapper around `SparkleSave()`. Please see documentation for that function for more information.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to save into a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the save operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |This parameter is always `undefined`                                                                                                                |
|2              |The callback metadata specified when calling `SparkleSaveString()`                                                                                  |

This function returns a struct that contains private information that SparkleStore needs to track file saving. The struct has no public variables. However, it has several public method that are identical to `SparkleSave()`, please see above for more information.

&nbsp;

## …SaveJSON

`SparkleSaveJSON(filename, json, [callback], [callbackMetadata], [pretty=false], [priority=normal])`

**Returns:** struct

|Name                |Datatype    |Purpose                                                                                           |
|--------------------|------------|--------------------------------------------------------------------------------------------------|
|`filename`          |string      |Name of the file to save. This should be the filename itself and should not contain a directory   |
|`json`              |struct/array|JSON (struct/array assembly) to save                                                              |
|`[callback]`        |method      |Callback method to execute when the operation completes, see below                                |
|`[callbackMetadata]`|number      |Metadata to pass to the callback                                                                  |
|`[pretty]`          |boolean     |Whether to make the output more human-readable by adding spacing and newlines. Defaults to `false`|
|`[priority]`        |number      |How soon to save. Defaults to "normal" i.e. after every other queued operation                    |

Starts an asynchronous save operation for JSON (i.e. a struct/array assembly). This function is a wrapper around `SparkleSave()`. Please see documentation for that function for more information.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to save into a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the save operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |This parameter is always `undefined`                                                                                                                |
|2              |The callback metadata specified when calling `SparkleSaveJSON()`                                                                                    |

This function returns a struct that contains private information that SparkleStore needs to track file saving. The struct has no public variables. However, it has several public method that are identical to `SparkleSave()`, please see above for more information.

&nbsp;

## …SaveSprite

`SparkleSaveSprite(filename, sprite, image, [callback], [callbackMetadata], [priority=normal])`

**Returns:** struct

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to save. This should be the filename itself and should not contain a directory|
|`sprite`            |sprite  |Sprite to save                                                                                 |
|`image`             |number  |Image of the sprite to save                                                                    |
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to save. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous save operation for one image of a sprite. This function is a wrapper around `SparkleSave()`. Please see documentation for that function for more information. This function saves using a custom format and is not a PNG file. You can load a sprite saved by this function with either `SparkleLoadSurface()` or `SparkleLoadSprite()`.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to save into a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the save operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |This parameter is always `undefined`                                                                                                                |
|2              |The callback metadata specified when calling `SparkleSaveSprite()`                                                                                  |

This function returns a struct that contains private information that SparkleStore needs to track file saving. The struct has no public variables. However, it has several public method that are identical to `SparkleSave()`, please see above for more information.

&nbsp;

## …SaveSurface

`SparkleSaveSurface(filename, surface, [callback], [callbackMetadata], [priority=normal])`

**Returns:** struct

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to save. This should be the filename itself and should not contain a directory|
|`surface`           |surface |Surface to save                                                                                |
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to save. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous save operation for a surface. This function is a wrapper around `SparkleSave()`. Please see documentation for that function for more information. This function saves using a custom format and is not a PNG file. You can load a sprite saved by this function with either `SparkleLoadSurface()` or `SparkleLoadSprite()`.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to save into a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the save operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |This parameter is always `undefined`                                                                                                                |
|2              |The callback metadata specified when calling `SparkleSaveSurface()`                                                                                 |

This function returns a struct that contains private information that SparkleStore needs to track file saving. The struct has no public variables. However, it has several public method that are identical to `SparkleSave()`, please see above for more information.