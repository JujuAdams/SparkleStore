// Feather disable all

gdk_init("SCID goes here");
__activatingUser = xboxone_get_activating_user();

show_debug_message($"Windows GDK: Activating user is {__activatingUser}");