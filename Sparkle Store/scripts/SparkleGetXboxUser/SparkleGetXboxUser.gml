// Feather disable all

/// Returns the current Xbox user for save/load operations.

function SparkleGetXboxUser()
{
    static _system = __SparkleSystem();
    return _system.__xboxUser;
}