// Feather disable all

with(__SparkleSystem())
{
    var _id        = async_load[? "id"    ];
    var _error     = async_load[? "error" ];
    var _rawStatus = async_load[? "status"];
    
    if (SPARKLE_ON_SWITCH || SPARKLE_ON_PS_ANY || SPARKLE_ON_XBOX)
    {
        var _status = (_rawStatus >= 0);
    }
    else
    {
        var _status = (_rawStatus > 0);
    }
    
    var _i = 0;
    repeat(array_length(__savePendingArray))
    {
        var _opStruct = __savePendingArray[_i];
        if (_opStruct.__asyncID == _id)
        {
            if (_status)
            {
                if (SPARKLE_ON_PS5)
                {
                    if (SPARKLE_VERBOSE)
                    {
                        __SparkleTrace($"Starting backup for {string(ptr(_opStruct))}");
                    }
                    
                    __ps5BackUpOperation = _opStruct;
                }
                else
                {
                    _opStruct.__Complete(SPARKLE_STATUS_SUCCESS);
                }
            }
            else
            {
                _opStruct.__Complete(SPARKLE_STATUS_FAILED);
            }
            
            return;
        }
        
        ++_i;
    }
    
    var _i = 0;
    repeat(array_length(__loadPendingArray))
    {
        var _opStruct = __loadPendingArray[_i];
        if (_opStruct.__asyncID == _id)
        {
            _opStruct.__Complete(_status? SPARKLE_STATUS_SUCCESS : SPARKLE_STATUS_FAILED);
            return;
        }
        
        ++_i;
    }
}