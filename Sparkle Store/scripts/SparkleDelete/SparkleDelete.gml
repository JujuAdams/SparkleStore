// Feather disable all

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