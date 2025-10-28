// Feather disable all

/// Returns the total number of pending operations.

function SparkleGetTotalPending()
{
    static _system           = __SparkleSystem();
    static _queuedArray      = _system.__queuedArray;
    static _savePendingArray = _system.__savePendingArray;
    static _loadPendingArray = _system.__loadPendingArray;
    
    return array_length(_queuedArray) + array_length(_savePendingArray) + array_length(_loadPendingArray);
}