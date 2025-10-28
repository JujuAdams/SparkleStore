// Feather disable all

/// Returns the current gamepad index for future save/load operations.

function SparkleGetConsoleGamepadIndex(_gamepadIndex)
{
    static _system = __SparkleSystem();
    return _system.__gamepadIndex;
}