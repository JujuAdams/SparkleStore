// Feather disable all

#macro __SPARKLE_MAX_SIMULTANEOUS_OPERATIONS  1
#macro __SPARKLE_EMPTY_BUFFER_SIZE  1
#macro __SPARKLE_PS_SAVE_BACKUP  SPARKLE_ON_PS4

__SparkleSystem();

function __SparkleSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    if (debug_mode) global.__SparkleStore = _system;
    
    with(_system)
    {
        __SparkleTrace($"Welcome to SparkleStore by Juju Adams! This is version {SPARKLE_VERSION}, {SPARKLE_DATE}");
        
        __lastActivityTime = -infinity;
        __anyRequestMade = false;
        
        __steamFile = SPARKLE_ALLOW_STEAM_FILE;
        
        __psSlotTitle    = SPARKLE_PLAYSTATION_SLOT_TITLE;
        __psSlotSubtitle = SPARKLE_PLAYSTATION_SUBTITLE;
        __psShowDialog   = false;
        __psGamepadIndex = -1;
        
        __xboxUser = int64(0);
        
        __queuedArray = [];
        
        __savePendingArray = [];
        __loadPendingArray = [];
        
        __saveActivityArray = [];
        __loadActivityArray = [];
        
        __presenceCacheMap = ds_map_create();
        
        __ps5BackUpOperation = undefined;
        
        if (string_pos(" ", __psSlotTitle) > 0)
        {
            if (SPARKLE_RUNNING_FROM_IDE)
            {
                __SparkleError("`SPARKLE_PLAYSTATION_SLOT_TITLE` title must not contain spaces");
            }
            else
            {
                __SparkleTrace("Warning! `SPARKLE_PLAYSTATION_SLOT_TITLE` must not contain spaces");
                __psSlotTitle = string_replace_all(__psSlotTitle, " ", "");
            }
        }
        
        if (SPARKLE_IDE_GROUP_NAME != undefined)
        {
            __groupName = string(SPARKLE_IDE_GROUP_NAME);
            __SparkleTrace($"Initialized group name to \"{__groupName}\" (via `SPARKLE_IDE_GROUP_NAME`)");
        }
        else
        {
            __groupName = string(SPARKLE_DEFAULT_GROUP_NAME);
            __SparkleTrace($"Initialized group name to \"{__groupName}\" (via `SPARKLE_DEFAULT_GROUP_NAME`)");
        }
        
        __SparkleInitializeSteam();
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            static _createdInstance = false;
            
            //Verify our controller instance still exists
            if (not _createdInstance)
            {
                _createdInstance = true;
                instance_create_depth(0, 0, 0, __oSparkleStore);
            }
            else if (not instance_exists(__oSparkleStore))
            {
                __SparkleError("`__oSparkleStore` has been destroyed or deactivated.\nPlease ensure this instance is never destroyed or deactivated.");
            }
            
            //Clean up recent activity arrays
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
            
            //Dispatch queued operations
            while(array_length(__queuedArray) > 0)
            {
                __lastActivityTime = current_time;
                
                var _totalPending = array_length(__savePendingArray) + array_length(__loadPendingArray);
                
                var _opStruct = array_first(__queuedArray);
                var _operation = _opStruct.GetOperation();
                if ((_operation == SPARKLE_OP_SAVE) || (_operation == SPARKLE_OP_DELETE))
                {
                    var _recentCount = array_length(__saveActivityArray);
                    if ((_recentCount < SPARKLE_MAX_SAVE_FREQUENCY) && (_totalPending < max(1, __SPARKLE_MAX_SIMULTANEOUS_OPERATIONS)))
                    {
                        array_shift(__queuedArray);
                        _opStruct.__Dispatch();
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    var _recentCount = array_length(__loadActivityArray);
                    if ((_recentCount < SPARKLE_MAX_LOAD_FREQUENCY) && (_totalPending < max(1, __SPARKLE_MAX_SIMULTANEOUS_OPERATIONS)))
                    {
                        array_shift(__queuedArray);
                        _opStruct.__Dispatch();
                    }
                    else
                    {
                        break;
                    }
                }
            }
        },
        [], -1));
    }
    
    return _system;
}