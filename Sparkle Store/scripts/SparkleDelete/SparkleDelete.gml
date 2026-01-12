// Feather disable all

/// Deletes a file. This is considered to be a "save" operation.
/// 
/// N.B. On console platforms, GameMaker does not allow you to directly delete a file. Instead,
///      Sparkle Store will save a small empty file.
/// 
/// The callback for this function will be dispatched with one parameter:
/// 
/// argument0: The "status" of the delete operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// This function returns a struct that contains private information that Sparkle Store needs to
/// track file saving. The struct has no public variables. However, it has the following public
/// methods:
/// 
/// `.GetOperation()`
///     Returns `SPARKLE_OP_DELETE`.
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

function SparkleDelete(_filename, _callback, _priority = SPARKLE_PRIORITY_NORMAL)
{
    static _system = __SparkleSystem();
    static _queuedArray = _system.__queuedArray;
    
    _system.__anyRequestMade = true;
    
    if ((SPARKLE_ON_XBOX || SparkleGetWindowsUseGDK()) && ((__xboxUser == 0) || (__xboxUser == pointer_null)))
    {
        __SparkleError($"Xbox user is invalid {__xboxUser}");
    }
    
    if (SPARKLE_ON_PS_ANY && (__psGamepadIndex < 0))
    {
        __SparkleError($"Gamepad index is invalid {__psGamepadIndex}");
    }
    
    var _struct = new __SparkleClassDelete(_filename, _callback);
    
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