// Feather disable all

/// Starts an asynchronous load operation for one image of a sprite. This function is a wrapper
/// around `SparkleLoad()`. Please see documentation for that function for more information.
/// 
/// N.B. This function expects the file to be saved by `SparkleSaveSurface()` or
///      `SparkleSaveSprite()` and cannot read PNG, JPEG, GIF files etc.
/// 
/// The callback for this function will be executed with two parameters:
/// 
/// argument0: The "status" of the load operation. This is one of the `SPARKLE_STATUS_*`
///            constants. Please see the `__SparkleConstants` script for more information.
/// 
/// argument1: The sprite (struct/array assembly) that was found in the file. If there was a
///            problem or the file was empty then this parameter will be set to `-1`.
/// 
/// @param filename
/// @param callback
/// @param [priority=normal]

function SparkleLoadSprite(_filename, _callback, _priority = SPARKLE_PRIORITY_NORMAL)
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
    function(_status, _surface)
    {
        var _sprite = -1;
        
        if (_status == SPARKLE_STATUS_SUCCESS)
        {
            if (surface_exists(_surface))
            {
                _sprite = sprite_create_from_surface(_surface, 0, 0, surface_get_width(_surface), surface_get_height(_surface), false, false, 0, 0);
            }
            
            if (not sprite_exists(_sprite))
            {
                _status = SPARKLE_STATUS_FAILED;
            }
        }
        
        if (surface_exists(_surface))
        {
            surface_free(_surface);
        }
        
        __callback(_status, _sprite);
    });
    
    return SparkleLoad(_filename, _newCallback, _priority);
}