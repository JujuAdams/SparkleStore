// Feather disable all

/// Sets the current gamepad index for future save/load operations.
/// 
/// @param gamepadIndex

function SparkleSetConsoleGamepadIndex(_gamepadIndex)
{
    static _system = __SparkleSystem();
    _system.__gamepadIndex = string(_gamepadIndex);
}