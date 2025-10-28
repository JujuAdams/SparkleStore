// Feather disable all

with(__SparkleSystem())
{
    while(array_length(__saveActivityArray) > 0)
    {
        if (current_time - __saveActivityArray[0].__activityTime > 60_000)
        {
            array_shift(__saveActivityArray);
        }
        else
        {
            break;
        }
    }
    
    while(array_length(__loadActivityArray) > 0)
    {
        if (current_time - __loadActivityArray[0].__activityTime > 60_000)
        {
            array_shift(__loadActivityArray);
        }
        else
        {
            break;
        }
    }
    
    while(array_length(__queuedArray) > 0)
    {
        __lastActivityTime = current_time;
        
        var _totalPending = array_length(__savePendingArray) + array_length(__loadPendingArray);
        
        var _opStruct = array_first(__queuedArray);
        if (_opStruct.GetOperation() == SPARKLE_OP_SAVE)
        {
            var _recentCount = array_length(__saveActivityArray);
            if ((_recentCount < SPARKLE_MAX_SAVE_FREQUENCY) && (_totalPending <= max(1, SPARKLE_MAX_SIMULTANEOUS_OPERATIONS)))
            {
                array_shift(__queuedArray);
                _opStruct.__Execute();
            }
            else
            {
                break;
            }
        }
        else
        {
            var _recentCount = array_length(__loadActivityArray);
            if ((_recentCount < SPARKLE_MAX_LOAD_FREQUENCY) && (_totalPending <= max(1, SPARKLE_MAX_SIMULTANEOUS_OPERATIONS)))
            {
                array_shift(__queuedArray);
                _opStruct.__Execute();
            }
            else
            {
                break;
            }
        }
    }
}