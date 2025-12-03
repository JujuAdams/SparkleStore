// Feather disable all

/// Returns the current PlayStation gamepad index for save/load operations.

function SparkleGetPSGamepadIndex()
{
    static _system = __SparkleSystem();
    return _system.__psGamepadIndex;
}