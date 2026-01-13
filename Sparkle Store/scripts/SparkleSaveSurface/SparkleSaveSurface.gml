// Feather disable all

/// Starts an asynchronous save operation for a surface. This function is a wrapper around
/// `SparkleSave()`. Please see documentation for that function for more information.
/// 
/// N.B. This function saves using a custom format and is not a PNG file. You can load a surface
///      saved by this function with either `SparkleLoadSurface()` or `...LoadSprite()`.
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
/// @param surface
/// @param [callback]
/// @param [priority=normal]

function SparkleSaveSurface(_filename, _surface, _callback = undefined, _priority = SPARKLE_PRIORITY_NORMAL)
{
    var _buffer = buffer_create(2*8 + 4*surface_get_width(_surface)*surface_get_height(_surface), buffer_fixed, 1);
    buffer_write(_buffer, buffer_u64, surface_get_width(_surface));
    buffer_write(_buffer, buffer_u64, surface_get_height(_surface));
    buffer_get_surface(_buffer, _surface, buffer_tell(_buffer));
    
    var _compressedBuffer = buffer_compress(_buffer, 0, buffer_get_size(_buffer));
    buffer_delete(_buffer);
    
    var _newCallback = method({
        __callback: _callback,
    },
    function(_status, _buffer)
    {
        buffer_delete(_buffer);
        
        if (is_callable(__callback))
        {
            __callback(_status, undefined);
        }
    });
    
    return SparkleSave(_filename, _compressedBuffer, _newCallback, undefined, undefined, _priority);
}