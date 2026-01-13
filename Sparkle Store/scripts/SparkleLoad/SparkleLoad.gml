// Feather disable all

/// Starts an asynchronous load operation for a buffer (or part of a buffer). If the load operation
/// is successful, the contents of the file will be placed into a buffer that Sparkle Store creates
/// for you. This buffer is then returned via the callback (see below). You can also specify a
/// priority using one of the `SPARKLE_PRIORITY_*` constants. Please see `__SparkleConstants` for
/// more information.
/// 
/// N.B. For compatibility with `SparkleDelete()` on consoles, very small empty files will be
///      treated as though they don't exist and load operations will return as failed.
/// 
/// N.B. The filename you provide must be a simple filename and not a path that includes directory
///      changes. If you would like to load from a particular directory within the file system
///      sandbox, please use `SparkleSetGroupName()`. Loading outside the sandbox is not supported.
/// 
/// The callback for this function will be executed with two parameters:
/// 
/// argument0: The "status" of the load operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// argument1: A buffer that, hopefully, contains data loaded from the file. The buffer can be
///            empty but the status can be `true` in some edge cases on console. Be sure to check
///            if it has content before using it. However, a buffer is always returned and you are
///            responsible for destroying this buffer if when you don't need it.
/// 
/// This function returns a struct that contains private information that Sparkle Store needs to
/// track file saving. The struct has no public variables. However, it has the following public
/// methods:
/// 
/// `.GetOperation()`
///     Returns `SPARKLE_OP_LOAD`.
/// 
/// `.Cancel()`
///     Cancels the operation immediately. This will execute the callback with the
///     `SPARKLE_STATUS_CANCELLED` status.
/// 
/// `.GetStatus()`
///     Returns the status of the operation. This will be one of the `SPARKLE_STATUS_*` constants.
///     Please see `__SparkleConstants` for more information.
/// 
/// @param filename
/// @param callback
/// @param [priority=normal]

function SparkleLoad(_filename, _callback, _priority = SPARKLE_PRIORITY_NORMAL)
{
    static _system = __SparkleSystem();
    static _queuedArray = _system.__queuedArray;
    
    _system.__anyRequestMade = true;
    
    if (not is_callable(_callback))
    {
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Warning! Callback is not callable (typeof={typeof(_callback)}). Aborting load of \"{_filename}\"");
        }
        
        return;
    }
    
    if ((SPARKLE_ON_XBOX || SparkleGetWindowsUseGDK()) && (_system.__xboxUser == 0))
    {
        __SparkleError($"Xbox user is invalid {_system.__xboxUser}");
    }
    
    if (SPARKLE_ON_PS_ANY && (__psGamepadIndex < 0))
    {
        __SparkleError($"Gamepad index is invalid {__psGamepadIndex}");
    }
    
    var _struct = new __SparkleClassLoad(_filename, _callback);
    
    if (_priority == SPARKLE_PRIORITY_HIGH)
    {
        array_insert(_queuedArray, _struct, 0);
    }
    else if (_priority == SPARKLE_PRIORITY_IMMEDIATE)
    {
        _struct.__Dispatch();
    }
    else
    {
        array_push(_queuedArray, _struct);
    }
    
    return _struct;
}