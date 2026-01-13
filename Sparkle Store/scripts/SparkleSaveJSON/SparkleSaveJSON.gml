// Feather disable all

/// Starts an asynchronous save operation for JSON (i.e. a struct/array assembly). This function
/// is a wrapper around `SparkleSave()`. Please see documentation for that function for more
/// information.
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
/// @param json
/// @param [callback]
/// @param [pretty=false]
/// @param [priority=normal]

function SparkleSaveJSON(_filename, _json, _callback = undefined, _pretty = false, _priority = SPARKLE_PRIORITY_NORMAL)
{
    return SparkleSaveString(_filename, json_stringify(_json, _pretty), _callback, _priority);
}