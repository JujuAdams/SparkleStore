// Feather disable all

/// Starts an asynchronous load operation for JSON (i.e. a struct/array assembly). This function
/// is a wrapper around `SparkleLoad()`. Please see documentation for that function for more
/// information.
/// 
/// The callback for this function will be executed with two parameters:
/// 
/// argument0: The "status" of the load operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// argument1: The JSON (struct/array assembly) that was found in the file. If there was a problem
///            or the file was empty then this parameter will be set to `undefined`.
/// 
/// @param filename
/// @param callback
/// @param [priority=normal]

function SparkleLoadJSON(_filename, _callback, _priority = SPARKLE_PRIORITY_NORMAL)
{
    static _system = __SparkleSystem();
    
    _system.__anyRequestMade = true;
    
    if (not is_callable(_callback))
    {
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Warning! Callback is not callable (typeof={typeof(_callback)}). Aborting load of \"{_filename}\"");
        }
        
        return;
    }
    
    var _newCallback = method({
        __callback: _callback,
    },
    function(_status, _string)
    {
        var _json = undefined;
        
        if (_status == SPARKLE_STATUS_SUCCESS)
        {
            try
            {
                _json = json_parse(_string);
            }
            catch(_error)
            {
                __SparkleTrace(_error);
                __SparkleTrace("Warning! Failed to parse JSON");
                
                _status = SPARKLE_STATUS_CANCELLED;
            }
        }
        
        __callback(_status, _json);
    });
    
    return SparkleLoadString(_filename, _newCallback, _priority);
}