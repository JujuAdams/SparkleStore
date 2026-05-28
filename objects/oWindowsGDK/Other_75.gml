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
}
else if (async_load[? "event_type"] == "user signed out")
{
    if (SparkleGetXboxUser() == async_load[? "user"])
    {
        SparkleSetXboxUser(int64(0));
    }
}