// Feather disable all

/// Returns the current Xbox user ID for save/load operations.

function SparkleGetXboxUserID()
{
    static _system = __SparkleSystem();
    return _system.__xboxUserID;
}