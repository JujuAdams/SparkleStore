// Feather disable all

/// Returns if Steam Cloud is enabled. The requires all of the following to be true:
/// - The game is running on Windows, MacOS, or Linux
/// - `SPARKLE_ALLOW_STEAM_CLOUD` has been set to `true`
/// - `SoarkleSetTrySteamCloud()` has been set to `true` (which it is by default)
/// - The game is using YoYoGames' Steamworks extension
/// - Steam is open and running
/// - The application is set up to use Steam Cloud
/// - The user has enabled Steam Cloud for their account

function SparkleGetSteamCloud()
{
    static _system = __SparkleSystem();
    
    return (__SparkleGetSteamCloudInternal() && _system.__trySteamCloud);
}