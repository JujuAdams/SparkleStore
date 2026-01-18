# Load Functions

Functions on this page relate to loading data that has previously been saved by SparkleStore. There are a few variants but all work fundamentally the same way. Please read the documentation for `SparkleLoad()` before other functions.

&nbsp;

## …Load

`SparkleLoad(filename, [callback], [callbackMetadata], [priority=normal])`

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to load. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to load. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous load operation for a buffer (or part of a buffer). If the load operation is successful, the contents of the file will be placed into a buffer that SparkleStore creates for you. This buffer is then returned via the callback (see below). You can also specify a priority using one of the `SPARKLE_PRIORITY_*` constants. Please see `__SparkleConstants` for more information.

?> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist and load operations will return as failed.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to load from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                                      |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the load operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information       |
|1              |A buffer that, hopefully, contains data loaded from the file. The buffer can be empty but the status can be `true` in some edge cases on console. Be sure to check if it has content before using it. Regardless, a buffer is always returned and you are responsible for destroying this buffer if you don't need it|
|2              |The callback metadata specified when calling `SparkleLoad()`                                                                                               |

!> If you do not specify a callback and you have no other use for the buffer, you must destroy the buffer otherwise you will have a memory leak.

This function returns a struct that contains private information that SparkleStore needs to track file loading. The struct has no public variables. However, it has the following public methods:

|Method Name             |Usage                                                                                                                                          |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
|`.GetOperation()`       |Returns `SPARKLE_OP_LOAD`                                                                                                                      |
|`.GetFilename()`        |Returns the filename that the operation is targeting                                                                                           |
|`.GetCallbackMetadata()`|Returns the callback metadaata set when calling `SparkleLoad()`                                                                                |
|`.Cancel()`             |Cancels the operation immediately. This will execute the callback with the `SPARKLE_STATUS_CANCELLED` status                                   |
|`.GetStatus()`          |Returns the status of the operation. This will be one of the `SPARKLE_STATUS_*` constants. Please see `__SparkleConstants` for more information|

&nbsp;

## …LoadString

`SparkleLoadString(filename, [callback], [callbackMetadata], [priority=normal])`

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to load. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to load. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous load operation for a string. This function is a wrapper around `SparkleLoad()`. Please see documentation for that function for more information.

?> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist and load operations will return as failed.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to load from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the load operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |The string that was found in the file. If there was a problem then this parameter will be set to an empty string                                    |
|2              |The callback metadata specified when calling `SparkleLoadString()`                                                                                  |

This function returns a struct that contains private information that SparkleStore needs to track file loading. The struct has no public variables. However, it has several public method that are identical to `SparkleLoad()`, please see above for more information.

&nbsp;

## …LoadJSON

`SparkleLoadJSON(filename, [callback], [callbackMetadata], [priority=normal])`

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to load. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to load. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous load operation for a string. This function is a wrapper around `SparkleLoad()`. Please see documentation for that function for more information.

?> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist and load operations will return as failed.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to load from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                                   |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the load operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information    |
|1              |The JSON (struct/array assembly) that was found in the file. If there was a problem or the file was empty then this parameter will be set to `undefined`|
|2              |The callback metadata specified when calling `SparkleLoadJSON()`                                                                                        |

This function returns a struct that contains private information that SparkleStore needs to track file loading. The struct has no public variables. However, it has several public method that are identical to `SparkleLoad()`, please see above for more information.

&nbsp;

## …LoadSprite

`SparkleLoadSprite(filename, [callback], [callbackMetadata], [priority=normal])`

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to load. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to load. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous load operation for one image of a sprite. This function is a wrapper around `SparkleLoad()`. Please see documentation for that function for more information.

!> This function expects the file to be saved by `SparkleSaveSurface()` or `SparkleSaveSprite()` and cannot read PNG, JPEG, GIF files etc.

?> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist and load operations will return as failed.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to load from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the load operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |The sprite that was found in the file. If there was a problem or the file was empty then this parameter will be set to `-1`                         |
|2              |The callback metadata specified when calling `SparkleLoadJSON()`                                                                                    |

This function returns a struct that contains private information that SparkleStore needs to track file loading. The struct has no public variables. However, it has several public method that are identical to `SparkleLoad()`, please see above for more information.

&nbsp;

## …LoadSurface

`SparkleLoadSurface(filename, [callback], [callbackMetadata], [priority=normal])`

**Returns:** N/A (`undefined`)

|Name                |Datatype|Purpose                                                                                        |
|--------------------|--------|-----------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to load. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                             |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                               |
|`[priority]`        |number  |How soon to load. Defaults to "normal" i.e. after every other queued operation                 |

Starts an asynchronous load operation for surface. This function is a wrapper around `SparkleLoad()`. Please see documentation for that function for more information.

!> This function expects the file to be saved by `SparkleSaveSurface()` or `SparkleSaveSprite()` and cannot read PNG, JPEG, GIF files etc.

?> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist and load operations will return as failed.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to load from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.

The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the load operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |he surface that was found in the file. If there was a problem or the file was empty then this parameter will be set to `-1``                        |
|2              |The callback metadata specified when calling `SparkleLoadJSON()`                                                                                    |

This function returns a struct that contains private information that SparkleStore needs to track file loading. The struct has no public variables. However, it has several public method that are identical to `SparkleLoad()`, please see above for more information.