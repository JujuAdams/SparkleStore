// Feather disable all

/// Starts an asynchronous save operation for a buffer (or part of a buffer). You may optionally
/// specify an offset and size for the data you want to save. If not defined, the entire buffer
/// will be saved. You can also specify a priority using one of the `SPARKLE_PRIORITY_*` constants.
/// Please see `__SparkleConstants` for more information.
/// 
/// N.B. The filename you provide must be a simple filename and not a path that includes directory
///      changes. If you would like to save into a particular directory within the file system
///      sandbox, please use `SparkleSetGroupName()`. Saving outside the sandbox is not supported.
/// 
/// The callback for this function will be executed with two parameters:
/// 
/// argument0: The "status" of the save operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// argument1: The buffer used to save the file. You must destroy this buffer with `buffer_delete()`
///            if you have no other use for it otherwise you will have a memory leak.
/// 
/// This function returns a struct that contains private information that Sparkle Store needs to
/// track file saving. The struct has no public variables. However, it has the following public
/// methods:
/// 
/// `.GetOperation()`
///     Returns `SPARKLE_OP_SAVE`.
/// 
/// `.Cancel()`
///     Cancels the operation immediately. This will execute the callback with the
///     `SPARKLE_STATUS_CANCELLED` status. If the operation is cancelled afer the OS has started
///     saving data then a file may still be saved to disk.
/// 
/// `.GetStatus()`
///     Returns the status of the operation. This will be one of the `SPARKLE_STATUS_*` constants.
///     Please see `__SparkleConstants` for more information.
/// 
/// @param filename
/// @param buffer
/// @param [callback]
/// @param [offset=0]
/// @param [size]
/// @param [priority=normal]

function SparkleSave(_filename, _buffer, _callback = undefined, _offset = 0, _size = infinity, _priority = SPARKLE_PRIORITY_NORMAL)
{
    static _system = __SparkleSystem();
    static _queuedArray = _system.__queuedArray;
    
    _system.__anyRequestMade = true;
    
    if ((SPARKLE_ON_XBOX || SparkleGetWindowsUseGDK()) && (_system.__xboxUser == 0))
    {
        __SparkleError($"Xbox user is invalid {_system.__xboxUser}");
    }
    
    if (SPARKLE_ON_PS_ANY && (__psGamepadIndex < 0))
    {
        __SparkleError($"Gamepad index is invalid {__psGamepadIndex}");
    }
    
    _offset = max(0, min(_offset, buffer_get_size(_buffer)-1));
    _size = max(0, min(_size, buffer_get_size(_buffer) - _offset));
    
    var _struct = new __SparkleClassSave(_filename, _buffer, _offset, _size, _callback);
    
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