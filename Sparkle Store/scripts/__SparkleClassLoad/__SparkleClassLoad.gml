// Feather disable all

/// @param filename
/// @param callback

function __SparkleClassLoad(_filename, _callback) constructor
{
    static _system = __SparkleSystem();
    static _queuedArray       = _system.__queuedArray;
    static _loadPendingArray  = _system.__loadPendingArray;
    static _loadActivityArray = _system.__loadActivityArray;
    
    __filename = _filename;
    __callback = _callback;
    
    __groupName      = _system.__groupName;
    __psShowDialog   = _system.__psShowDialog;
    __psGamepadIndex = _system.__psGamepadIndex;
    __slotTitle      = _system.__slotTitle;
    __slotSubtitle   = _system.__slotSubtitle;
    __xboxUser       = _system.__xboxUser;
    
    if (SPARKLE_VERBOSE)
    {
        __SparkleTrace($"Created LOAD operation {string(ptr(self))}: group name = \"{__groupName}\", slot title = \"{__slotTitle}\", filename = \"{_filename}\", callback = {_callback}");
    }
    
    __buffer       = undefined;
    __dispatched   = false;
    __completed    = false;
    __activityTime = infinity;
    __asyncID      = undefined;
    __status       = SPARKLE_STATUS_QUEUED;
    
    static GetOperation = function()
    {
        return SPARKLE_OP_LOAD;
    }
    
    static Cancel = function()
    {
        __Complete(SPARKLE_STATUS_CANCELLED);
    }
    
    static GetStatus = function()
    {
        return __status;
    }
    
    static __Dispatch = function()
    {
        if (__dispatched) return;
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Dispatching LOAD operation {string(ptr(self))}");
        }
        
        __dispatched = true;
        __activityTime = current_time;
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        array_push(_loadActivityArray, self);
        
        if (SparkleGetSteamCloud())
        {
            var _status = SPARKLE_STATUS_FAILED;
            
            if (steam_file_exists($"{__groupName}/{__filename}"))
            {
                __buffer = steam_file_read_buffer($"{__groupName}/{__filename}");
                
                if (__buffer < 0)
                {
                    __buffer = __SparkleEmptyBuffer();
                }
                else
                {
                    _status = SPARKLE_STATUS_SUCCESS;
                }
            }
            else
            {
                __buffer = __SparkleEmptyBuffer();
            }
            
            __Complete(_status);
        }
        else
        {
            __buffer = __SparkleEmptyBuffer();
            
            if (SparkleGetWindowsUseGDK())
            {
                xboxone_set_savedata_user(__xboxUser);
                __asyncID = gdk_load_buffer(__buffer, $"root/{__groupName}/{__filename}", 0, -1); //Recommended by YYG for cross-platform save support
            }
            else
            {
                if (SPARKLE_ON_XBOX)
                {
                    xboxone_set_savedata_user(__xboxUser);
                }
                
                buffer_async_group_begin(__groupName);
                
                if (SPARKLE_ON_CONSOLE)
                {
                    buffer_async_group_option("slottitle", __slotTitle);
                }
                
                if (SPARKLE_ON_PS_ANY)
                {
                    buffer_async_group_option("showdialog",   __psShowDialog);
                    buffer_async_group_option("savepadindex", __psGamepadIndex);
                }
                
                buffer_load_async(__buffer, __filename, 0, -1);
                
                __asyncID = buffer_async_group_end();
            }
            
            __status = SPARKLE_STATUS_PENDING;
            array_push(_loadPendingArray, self);
        }
    }
    
    static __Complete = function(_status)
    {
        if (__completed) return;
        
        __completed = true;
        __activityTime = current_time;
        
        if (SPARKLE_ON_CONSOLE && _status)
        {
            if (buffer_get_size(__buffer) == __SPARKLE_EMPTY_BUFFER_SIZE)
            {
                var _valid = false;
                
                var _i = 0;
                repeat(__SPARKLE_EMPTY_BUFFER_SIZE)
                {
                    if (buffer_peek(__buffer, _i, buffer_u8) != 0x00)
                    {
                        _valid = true;
                        break;
                    }
                    
                    ++_i;
                }
                
                if (not _valid)
                {
                    _status = SPARKLE_STATUS_FAILED;
                    
                    if (SPARKLE_VERBOSE)
                    {
                        __SparkleTrace("Buffer is empty, making LOAD as failed");
                    }
                }
            }
        }
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Completing LOAD operation {string(ptr(self))}: status = {_status}");
        }
        
        __status = _status;
        __asyncID = undefined;
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        var _index = array_get_index(_loadPendingArray, self);
        if (_index >= 0) array_delete(_loadPendingArray, _index, 1);
        
        if (is_callable(__callback))
        {
            __callback(_status, __buffer);
        }
    }
}