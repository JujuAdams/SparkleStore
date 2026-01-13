// Feather disable all

function __SparkleGetSteamCloudInternal()
{
    static _system = __SparkleSystem();
    
    return (SPARKLE_ON_DESKTOP && SPARKLE_ALLOW_STEAM_CLOUD && _system.__steamCloudEnabled);
}