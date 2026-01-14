// Feather disable all

/// Starts an asynchronous save operation for a string. This function is a wrapper around
/// `SparkleSave()`. Please see documentation for that function for more information.
/// 
/// The callback for this function will be executed with two parameters:
/// 
/// argument0: The "status" of the save operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// argument1: This parameter is always `undefined`. Normally, this is the buffer used to save
///            the file but Sparkle Store handles this for you.
/// 
/// @param filename
/// @param string
/// @param [callback]
/// @param [callbackMetadata]
/// @param [priority=normal]

function SparkleSaveString(_filename, _string, _callback = undefined, _callbackMetadata = undefined, _priority = SPARKLE_PRIORITY_NORMAL)
{
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    
    var _newCallback = method({
        __callback: _callback,
        __callbackMetadata: _callbackMetadata,
    },
    function(_status, _buffer, _callbackMetadata)
    {
        buffer_delete(_buffer);
        
        if (is_callable(__callback))
        {
            __callback(_status, undefined, _callbackMetadata);
        }
    });
    
    return SparkleSave(_filename, _buffer, _newCallback, _callbackMetadata, undefined, undefined, _priority);
}