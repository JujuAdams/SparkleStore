// Feather disable all

/// @param filename

function __SparkleFileCacheKey(_filename)
{
    static _system = __SparkleSystem();
    
    if (SPARKLE_ON_PS_ANY)
    {
        return $"{psn_user_for_pad(_system.__psGamepadIndex)}\\{_system.__psSlotTitle}\\{_system.__groupName}\\{_filename}";
    }
    else if (SPARKLE_ON_GDK)
    {
        return $"{_system.__xboxUser}\\{_system.__groupName}\\{_filename}";
    }
    else
    {
        return $"{game_save_id}\\{_system.__groupName}\\{_filename}";
    }
}