// Feather disable all

/// Returns the absolute path to a file. This function only works when running on a desktop
/// platform; on other platforms, this function will return `undefined`. By default, this function
/// will use the current group name to build the returned path. However, you may override the group
/// name by specifying the `groupName` parameter.
/// 
/// @param filename
/// @param [groupName]

function SparkleGetPath(_filename, _groupName = undefined)
{
    static _system = __SparkleSystem();
    
    return SPARKLE_ON_DESKTOP? $"{game_save_id}/{_groupName ?? _system.__groupName}/{_filename}" : undefined;
}