// Feather disable all

/// Starts an asynchronous save operation for one image of a sprite. This function is a wrapper
/// around `SparkleSave()`. Please see documentation for that function for more information.
/// 
/// N.B. This function saves using a custom format and is not a PNG file. You can load a sprite
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
/// @param sprite
/// @param image
/// @param [callback]
/// @param [priority=normal]

function SparkleSaveSprite(_filename, _sprite, _image, _callback = undefined, _priority = SPARKLE_PRIORITY_NORMAL)
{
    var _surface = surface_create(sprite_get_width(_sprite), sprite_get_height(_sprite));
    
    surface_set_target(_surface);
    gpu_set_blendmode_ext(bm_one, bm_zero);
    draw_sprite(_sprite, _image, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    
    var _result = SparkleSaveSurface(_filename, _surface, _callback, _priority);
    
    surface_free(_surface);
    
    return _result;
}