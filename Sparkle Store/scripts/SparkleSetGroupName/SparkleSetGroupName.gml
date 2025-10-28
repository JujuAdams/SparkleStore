// Feather disable all

/// Sets the current group name. This group name will be used for future save/load operations but
/// will not impact any operations that have already been started.
/// 
/// @param groupName

function SparkleSetGroupName(_groupName)
{
    static _system = __SparkleSystem();
    _system.__groupName = string(_groupName);
}