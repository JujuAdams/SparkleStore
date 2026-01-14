// Feather disable all

/// Sets the current PlayStation slot subtitle for future save/load operations. This value will not
/// impact any operations that have already been started.
/// 
/// @param slotSubtitle

function SparkleSetPSSlotSubtitle(_slotSubtitle)
{
    static _system = __SparkleSystem();
    _system.__psSlotSubtitle = string(_slotSubtitle);
}