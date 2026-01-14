// Feather disable all

/// Sets the current PlayStation slot title for future save/load operations. This value will not
/// impact any operations that have already been started. Please note that the slot title must not
/// contain spaces for compatibility cross-platform.
/// 
/// @param slotTitle

function SparkleSetPSSlotTitle(_slotTitle)
{
    static _system = __SparkleSystem();
    
    if (string_pos(" ", _slotTitle) > 0)
    {
        if (SPARKLE_RUNNING_FROM_IDE)
        {
            __SparkleError("Slot title must not contain spaces");
        }
        else
        {
            __SparkleTrace("Warning! Slot title must not contain spaces");
            _slotTitle = string_replace_all(_slotTitle, " ", "");
        }
    }
    
    _system.__psSlotTitle = string(_slotTitle);
}