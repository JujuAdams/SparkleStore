// Feather disable all

/// Returns if a file exists, or `undefined` if the state of the file is not yet known.
/// 
/// N.B. This function will often return `undefined` due to the underlying asynchronous operation
///      take time to complete. You must handle this case in your case. Please continue reading for
///      more information.
/// 
/// N.B. When calling `SparkleLoad*()` you should always handle failed operations in that callback
///      regardless of whatever this `SparkleExist()` returns.
/// 
/// Returning whether a file exists on desktop is easy because we have a synchronous "instant"
/// native function call in `file_exists()`. Unfortunately, this function is not available across
/// every platform. Instead, we have to use an asynchronous load operation to try to read the file.
/// If the load fails then the file doesn't exist, if it succeeds then it does exist.
/// 
/// Regretably, using an asynchronous operation makes this process rather clumsy. To smooth things
/// out, SparkleStore keeps an internal cache that tracks whether files do or don't exist. When you
/// load a file using `SparkeLoad*()`, the result of that load operation is recorded. Similary, if
/// you successfully save or delete a file, the file's cached state is updated accordingly.
/// 
/// If you call `SparkleExist()` on a file that has not previously been saved or loaded (which is
/// usually the case) then the function will execute a silent load in the background and then cache
/// the result. You can force a load to happen, i.e. refresh the cache, by setting the optional
/// `forceLoad` parameter to `true`. You can return if a file state has been cached by calling
/// `SparkleExistCached()`.
/// 
/// Caches can easily get out of sync with reality so you should occasionally clear the cache to
/// cause SparkleStore to re-check file presence. `SparkleExistClearCache()` is provided to wipe
/// the cache manually. When you should do this is up to you but, as a suggestion, clearing the
/// when returning to the main menu from gameplay or by exiting a settings menu may be appropriate.
/// 
/// N.B. For compatibility with `SparkleDelete()` on consoles, very small empty files will be
///      treated as though they don't exist.
/// 
/// N.B. The filename you provide must be a simple filename and not a path that includes directory
///      changes. If you would like to delete a file from a particular directory within the file
///      system sandbox, please use `SparkleSetGroupName()`. Deleting files outside the sandbox is
///      not supported.
/// 
/// `SparkleExist()` is considered to be a "load" operation internally and this function will
/// increment `SparkleGetLoadPending()` and `SparkleGetLoadRecent()` in particular.
/// 
/// You may optionally specify a callback and callback metadata. The callback, if provided, will
/// always be executed whether or not a value exists in the cache. The callback for this function
/// will be executed with three parameters:
/// 
/// argument0: Whether the file exists, or `undefined` if SparkleStore could not execute the load
///            operation successfully (typically because the operation was cancelled). You must
///            handle the `undefined` case in your code.
/// 
/// argument1: Whether the value for `argument0` is a cached value (`true`) or a value obtained by
///            loading the file (`false`).
/// 
/// argument2: The callback metadata specified when calling `SparkleExist()`.
/// 
/// @param filename
/// @param [forceLoad=false]
/// @param [callback]
/// @param [callbackMetadata]
/// @param [priority=normal]

function SparkleExist(_filename, _forceLoad = false, _callback = undefined, _callbackMetadata = undefined, _priority = SPARKLE_PRIORITY_NORMAL)
{
    static _presenceCacheMap = __SparkleSystem().__presenceCacheMap;
    
    var _fileCacheKey = __SparkleFileCacheKey(_filename);
    var _status = _presenceCacheMap[? _fileCacheKey];
    
    if (_forceLoad || (_status == undefined))
    {
        var _operation = SparkleLoad(_filename, function(_status, _buffer, _callbackMetadata)
        {
            buffer_delete(_buffer);
            
            var _callback = _callbackMetadata.__callback;
            if (is_callable(_callback))
            {
                var _returnStatus = undefined;
                
                if (_status == SPARKLE_STATUS_FAILED)
                {
                    _returnStatus = false;
                }
                else if (_status == SPARKLE_STATUS_SUCCESS)
                {
                    _returnStatus = true;
                }
                
                _callback(_returnStatus, false, _callbackMetadata.__callbackMetadata);
            }
        },
        {
            __callback: _callback,
            __callbackMetadata: _callbackMetadata,
        },
        _priority);
        
        //Force the dialog off.
        _operation.__psShowDialog = false;
        
        return undefined;
    }
    else
    {
        if (is_callable(_callback))
        {
            call_later(1, time_source_units_frames, method({
                __status:           _status,
                __callback:         _callback,
                __callbackMetadata: _callbackMetadata,
            },
            function()
            {
                __callback(__status, true, __callbackMetadata);
            }));
        }
        
        return _presenceCacheMap[? _fileCacheKey];
    }
}