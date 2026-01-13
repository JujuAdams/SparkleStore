// Feather disable all

/// Returns whether Sparkle Store will try to use Steam Cloud when saving and loading files on
/// desktop platforms, as set by `SoarkleSetTrySteamCloud()`. This function will always return
/// `false` if `SPARKLE_ALLOW_STEAM_CLOUD` is set to `false`.
/// 
/// Please see documentation for `SparkleGetSteamCloud()` for more information.

function SoarkleGetTrySteamCloud()
{
    static _system = __SparkleSystem();
    
    return (SPARKLE_ALLOW_STEAM_CLOUD && _system.__trySteamCloud);
}