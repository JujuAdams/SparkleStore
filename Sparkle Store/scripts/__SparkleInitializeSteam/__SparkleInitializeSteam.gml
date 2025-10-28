// Feather disable all

function __SparkleInitializeSteam()
{
    with(__SparkleSystem())
    {
        __usingSteam      = false;
        __usingSteamworks = false;
        __cloudEnabled    = false;
        
        var _steamEnviron = environment_get_variable("SteamEnv");
        if ((_steamEnviron != "") && (_steamEnviron == "1"))
        {
            __usingSteam = true;
        }
        
        try
        {
            //Using Steamworks extension
            __usingSteamworks = steam_input_init(true);
            __onSteamDeck     = steam_utils_is_steam_running_on_steam_deck();
        }
        catch(_error)
        {
            __SparkleTrace("Steamworks extension unavailable");
        }
        
        if (__usingSteamworks)
        {
            if (steam_is_cloud_enabled_for_app())
            {
                __SparkleTrace("Steam Cloud enabled for app");
                
                if (steam_is_cloud_enabled_for_account())
                {
                    __SparkleTrace("Steam Cloud enabled for account, using cloud saves");
                    __cloudEnabled = true;
                }
                else
                {
                    __SparkleTrace("Steam Cloud disabled for account");
                }
            }
            else
            {
                __SparkleTrace("Steam Cloud disabled for app");
            }
        }
    }
}