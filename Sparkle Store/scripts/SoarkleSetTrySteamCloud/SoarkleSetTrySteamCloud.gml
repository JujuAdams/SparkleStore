// Feather disable all

/// Sets whether Sparkle Store will try to use Steam Cloud when saving and loading files on desktop
/// platforms. This setting will be used for future save/load operations but will not impact any
/// operations that have already been started.
/// 
/// Please see documentation for `SparkleGetSteamCloud()` for more information.
/// 
/// @param state

function SoarkleSetTrySteamCloud(_state)
{
    static _system = __SparkleSystem();
    
    if (_state && SPARKLE_ALLOW_STEAM_CLOUD)
    {
        __SparkleTrace("Cannot use Steam Cloud, `SPARKLE_ALLOW_STEAM_CLOUD` is set to `false`");
        return;
    }
    
    _system.__trySteamCloud = _state;
}