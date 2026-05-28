# Exists Functions

Functions on this page relate to checking whether data exists in storage.

&nbsp;

## …Exists

`SparkleExists(filename, [callback], [callbackMetadata], [forceLoad=false], [priority=normal])`

**Returns:** struct

|Name                |Datatype|Purpose                                                                                         |
|--------------------|--------|------------------------------------------------------------------------------------------------|
|`filename`          |string  |Name of the file to check. This should be the filename itself and should not contain a directory|
|`[callback]`        |method  |Callback method to execute when the operation completes, see below                              |
|`[callbackMetadata]`|any     |Metadata to pass to the callback                                                                |
|`[forceLoad]`       |boolean |Whether to force a load (`true`). Defaults to `false` which causes the function to use the cache|
|`[priority]`        |number  |How soon to save. Defaults to "normal" i.e. after every other queued operation                  |

Returns if a file exists, or `undefined` if the state of the file is not yet known.

!> This function will often return `undefined` due to the underlying asynchronous operation take time to complete. You must handle this case in your code or you will encounter bugs. Please continue reading for more information.

!> When calling `SparkleLoad*()` you should always handle failed operations in that callback regardless of whatever `SparkleExists()` returns.

Returning whether a file exists on desktop is easy because we have a synchronous "instant" native function call in `file_exists()`. Unfortunately, this function is not available across every platform. Instead, we have to use an asynchronous load operation to try to read the file. If the load fails then the file doesn't exist, if it succeeds then it does exist.

Regretably, using an asynchronous operation makes this process rather clumsy. To smooth things out, SparkleStore keeps an internal cache that tracks whether files do or don't exist. When you load a file using `SparkeLoad*()`, the result of that load operation is recorded. Similary, if you successfully save or delete a file, the file's cached state is updated accordingly.

If you call `SparkleExists()` on a file that has not previously been saved or loaded (which is usually the case) then the function will execute a silent load in the background and then cache the result. You can force a load to happen, i.e. refresh the cache, by setting the optional `forceLoad` parameter to `true`. You can return if a file state has been cached by calling `SparkleExistsCached()`.

Caches can easily get out of sync with reality so you should occasionally clear the cache to cause SparkleStore to re-check file presence. `SparkleExistsClearCache()` is provided to wipe the cache manually. When you should do this is up to you but, as a suggestion, clearing the when returning to the main menu from gameplay or by exiting a settings menu may be appropriate.

!> For compatibility with `SparkleDelete()` on consoles, very small empty files will be treated as though they don't exist.

!> The filename you provide must be a simple filename and not a path that includes directory changes. If you would like to delete a file from a particular directory within the file system sandbox, please use `SparkleSetGroupName()`. Deleting files outside the sandbox is not supported.

`SparkleExists()` is considered to be a "load" operation internally and this function will increment `SparkleGetLoadPending()` and `SparkleGetLoadRecent()` in particular.

You may optionally specify a callback and callback metadata. The callback, if provided, will always be executed whether or not a value exists in the cache. The callback for this function will be executed with three parameters:

|Parameter Index|Usage                                                                                                                                                                                      |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|0              |Whether the file exists, or `undefined` if SparkleStore could not execute the load operation successfully (typically because there's another operation to do the same thing already exists)|
|1              |Whether the value for `argument0` is a cached value (`true`) or a value obtained by loading the file (`false`)                                                                             |
|2              |The callback metadata specified when calling `SparkleExists()`                                                                                                                             |

&nbsp;

## …ExistsCached

`SparkleExistsCached(filename)`

**Returns:** boolean

|Name      |Datatype|Purpose                                                                                         |
|----------|--------|------------------------------------------------------------------------------------------------|
|`filename`|string  |Name of the file to check. This should be the filename itself and should not contain a directory|

Returns whether a file's presence has been cached. Please see `SparkleExists()` for more information.

&nbsp;

## …ExistsClearCache

`SparkleExistsClearCache([filename])`

**Returns:** boolean

|Name        |Datatype|Purpose                                                                                                                                                                     |
|------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[filename]`|string  |Name of the file to clear cached data for. This should be the filename itself and should not contain a directory. If not specified, the clear will be cleared for every file|

Clears the presence cache that tracks whether files do or don't exist (see `SparkleExists()` for more information). You may specify a particular file whose cache you wish to clear, or you can not provide a file in which case `SparkleExistsClearCache()` will clear the cache for every file.