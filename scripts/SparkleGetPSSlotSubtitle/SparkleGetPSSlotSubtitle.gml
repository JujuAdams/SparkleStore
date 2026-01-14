// Feather disable all

/// Returns the current PlayStation slot subtitle for save/load operations.

function SparkleGetPSSlotSubtitle()
{
    static _system = __SparkleSystem();
    return _system.__psSlotSubtitle;
}