// Feather disable all

/// Dispatches all save operations (and also delete operations) immediately. This is helpful when
/// running on Xbox. This should be used when the Xbox OS says that the game is suspending. Any
/// load operations will be cancelled and all callbacks will be ignored entirely for all operation
/// types.

function SparkleSubmitAllSaves()
{
    static _system = __SparkleSystem();
    
    with(_system)
    {
        //Dispatch all queued save/delete operations and ignore load operations
        var _queuedArray = __queuedArray;
        if (array_length(_queuedArray) > 0)
        {
            if (SPARKLE_VERBOSE)
            {
                __SparkleTrace("Submitting all save operations");
            }
            
            __lastActivityTime = current_time;
            
            while(array_length(_queuedArray) > 0)
            {
                var _opStruct = array_first(_queuedArray);
                
                var _operation = _opStruct.GetOperation();
                if ((_operation == SPARKLE_OP_SAVE) || (_operation == SPARKLE_OP_DELETE))
                {
                    _opStruct.__Dispatch();
                }
                
                array_shift(_queuedArray);
            }
        }
    }
}