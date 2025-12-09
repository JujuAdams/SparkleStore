// Feather disable all

#macro __SPARKLE_MAX_SIMULTANEOUS_OPERATIONS  (SPARKLE_ON_PS_ANY? 1 : SPARKLE_MAX_SIMULTANEOUS_OPERATIONS)

__SparkleSystem();

function __SparkleSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    if (debug_mode) global.__SparkleStore = _system;
    
    with(_system)
    {
        __SparkleTrace("Welcome to Sparkle Store by Juju Adams!");
        
        __lastActivityTime = -infinity;
        
        __slotTitle      = SPARKLE_CONSOLE_SLOT_TITLE;
        __slotSubtitle   = SPARKLE_CONSOLE_SUBTITLE;
        __psShowDialog   = false;
        __psGamepadIndex = -1;
        __xboxUserID     = pointer_null;
        
        __queuedArray       = [];
        __savePendingArray  = [];
        __loadPendingArray  = [];
        __saveActivityArray = [];
        __loadActivityArray = [];
        
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