// Feather disable all

if (async_load[? "event_type"] == "user sign in failed")
{
    show_debug_message($"Windows GDK: User sign in failed with error 0x{string_delete(string(ptr(async_load[? "error"])), 1, 8)}");
    
    //As per https://learn.microsoft.com/en-us/gaming/gdk/docs/reference/errorcodes?view=gdk-2510
    if (async_load[? "error"] == 0xFFFFFFFF_89240103)
    {
        show_debug_message($"Windows GDK: Application was probably not foregrounded, show account picker again");
        xboxone_show_account_picker(0, 0);
    }
    else if (WINDOWS_GDK_SIMPLIFIED_USER_MODEL)
    {
        show_debug_message($"Windows GDK: Account picker closed. Quitting game because we're using the simplified user model");
        game_end();
    }
}
else if (async_load[? "event_type"] == "user signed in")
{
    SparkleSetXboxUser(async_load[? "user"]);
    
    SparkleLoadString("settings.ini", function(_status, _string, _metadata)
    {
        if (_status == SPARKLE_STATUS_SUCCESS)
        {
            show_debug_message($"settings.ini = {_string}");
        }
        else
        {
            show_debug_message("Failed to load .ini");
        }
    });
    
    SparkleLoadString("sparkleCloudTest.txt", function(_status, _string, _metadata)
    {
        if (_status == SPARKLE_STATUS_SUCCESS)
        {
            show_debug_message($"sparkleCloudTest.txt = {_string}");
        }
        else
        {
            show_debug_message("Failed to load sparkleCloudTest.txt");
        }
    });
    
    SparkleSaveString("sparkleCloudTest.txt", date_datetime_string(date_current_datetime()));
}
else if (async_load[? "event_type"] == "user signed out")
{
    if (SparkleGetXboxUser() == async_load[? "user"])
    {
        SparkleSetXboxUser(int64(0));
    }
}