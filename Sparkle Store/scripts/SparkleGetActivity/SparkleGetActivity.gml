// Feather disable all

/// Returns whether there was save/load activity recently within the given timespan. This is
/// useful for setting up save/load indicators in your game's UI.
/// 
/// @param [milliseconds=1000]

function SparkleGetActivity(_milliseconds = 1000)
{
    static _system = __SparkleSystem();
    
    return (SparkleGetTotalPending() > 0)? true : (current_time - _system.__lastActivityTime <= _milliseconds);
}