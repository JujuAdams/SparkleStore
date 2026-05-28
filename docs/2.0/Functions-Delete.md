# SparkleDelete

`SparkleDelete(filename, callback, callbackMetadata, [priority=normal])`

**Returns:** struct

|Name              |Datatype|Purpose                                                                                          |
|------------------|--------|-------------------------------------------------------------------------------------------------|
|`filename`        |string  |Name of the file to delete. This should be the filename itself and should not contain a directory|
|`callback`        |method  |Callback method to execute when the operation completes, see below                               |
|`callbackMetadata`|any     |Metadata to pass to the callback                                                                 |
|`[priority]`      |number  |How soon to delete. Defaults to "normal" i.e. after every other queued operation                 |

Deletes a file. This is considered to be a "save" operation internally and this function will increment `SparkleGetSavePending()` and `SparkleGetSaveRecent()` in particular.

?> On console platforms, GameMaker does not allow you to directly delete a file. Instead, SparkleStore will save a very small empty file. SparkleStore's load functions will then treat this empty file as missing entirely.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to delete a file from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Deleting files outside the sandbox is not supported

The callback for this function will be executed with two parameters:

|Parameter Index|Usage                                                                                                                                                 |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |The "status" of the delete operation. This is one of the `SPARKLE_STATUS_*` constants. Please see the `__SparkleConstants` script for more information|
|1              |The callback metadata specified when calling `SparkleDelete()`                                                                                        |

This function returns a struct that contains private information that SparkleStore needs to track file deleting. The struct has no public variables. However, it has the following public methods:

|Method Name             |Usage                                                                                                                                          |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
|`.GetOperation()`       |Returns `SPARKLE_OP_DELETE`                                                                                                                    |
|`.GetFilename()`        |Returns the filename that the operation is targeting                                                                                           |
|`.GetCallbackMetadata()`|Returns the callback metadaata set when calling `SparkleDelete()`                                                                              |
|`.Cancel()`             |Cancels the operation immediately. This will execute the callback with the `SPARKLE_STATUS_CANCELLED` status                                   |
|`.GetStatus()`          |Returns the status of the operation. This will be one of the `SPARKLE_STATUS_*` constants. Please see `__SparkleConstants` for more information|