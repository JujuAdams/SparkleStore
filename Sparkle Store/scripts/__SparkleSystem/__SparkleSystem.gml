// Feather disable all

#macro __SPARKLE_MAX_SIMULTANEOUS_OPERATIONS  1
#macro __SPARKLE_EMPTY_BUFFER_SIZE  1

__SparkleSystem();

function __SparkleSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    if (debug_mode) global.__SparkleStore = _system;
    
    with(_system)
    {
        __SparkleTrace($"Welcome to Sparkle Store by Juju Adams! This is version {SPARKLE_VERSION}, {SPARKLE_DATE}");
        
        __lastActivityTime = -infinity;
        __anyRequestMade = false;
        
        __slotTitle      = SPARKLE_CONSOLE_SLOT_TITLE;
        __slotSubtitle   = SPARKLE_CONSOLE_SUBTITLE;
        __psShowDialog   = false;
        __psGamepadIndex = -1;
        __windowsUseGDK  = false;
        __xboxUser       = pointer_null;
        
        __queuedArray = [];
        
        __savePendingArray = [];
        __loadPendingArray = [];
        
        __saveActivityArray = [];
        __loadActivityArray = [];
        
        __ps5BackUpOperation = undefined;
        
        if (SPARKLE_IDE_GROUP_NAME != undefined)
        {
            __groupName = string(SPARKLE_IDE_GROUP_NAME);
            __SparkleTrace($"Initialized group name to \"{__groupName}\" (forced from IDE)");
        }
        else
        {
            __groupName = string(SPARKLE_DEFAULT_GROUP_NAME);
            __SparkleTrace($"Initialized group name to \"{__groupName}\"");
        }
        
        __SparkleInitializeSteam();
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            static _createdInstance = false;
            
            if (not _createdInstance)
            {
                _createdInstance = true;
                instance_create_depth(0, 0, 0, __oSparkleStore);
            }
            else if (not instance_exists(__oSparkleStore))
            {
                __SparkleError("`__oSparkleStore` has been destroyed or deactivated.\nPlease enough this instance is never destroyed or deactivated.");
            }
        },
        [], -1));
    }
    
    return _system;
}