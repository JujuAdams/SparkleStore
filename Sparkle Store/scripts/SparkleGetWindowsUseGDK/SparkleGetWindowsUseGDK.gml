// Feather disable all

/// Returns whether Sparkle Store is using GDK on Windows. This function will always return `false`
/// when not on Windows.

function SparkleGetWindowsUseGDK()
{
    static _system = __SparkleSystem();
    return SPARKLE_ON_WINDOWS? _system.__windowsUseGDK : false;
}