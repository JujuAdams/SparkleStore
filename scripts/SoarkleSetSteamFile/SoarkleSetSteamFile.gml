// Feather disable all

/// Sets whether SparkleStore will try to use `steam_file_*()` functions when saving and loading
/// files on desktop platforms. This function will do nothing if `SPARKLE_ALLOW_STEAM_FILE` has
/// been set `false` (which it is by default).
///
/// If you disallow `steam_file_*` functions, SparkleStore will always save data to local storage
/// regardless of whether Steam Cloud has been enabled. This is useful to save particular files to
/// local storage rather than into the cloud (e.g. for local settings files).
/// 
/// This setting will be used for future save/load operations but will not impact any operations
/// that have already been started.
/// 
/// @param state

function SoarkleSetSteamFile(_state)
{
    static _system = __SparkleSystem();
    
    if (_state && (not SPARKLE_ALLOW_STEAM_FILE))
    {
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace("Warning! Cannot use `steam_file_*()` functions, `SPARKLE_ALLOW_STEAM_FILE` is set to `false`");
        }
        
        return;
    }
    
    _system.__steamFile = _state;
}