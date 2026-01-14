// Feather disable all

/// Returns the current PlayStation slot title for save/load operations.

function SparkleGetPSSlotTitle()
{
    static _system = __SparkleSystem();
    return _system.__psSlotTitle;
}