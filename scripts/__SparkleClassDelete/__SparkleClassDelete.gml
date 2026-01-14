// Feather disable all

/// @param filename
/// @param callback
/// @param callbackMetadata

function __SparkleClassDelete(_filename, _callback, _callbackMetadata) constructor
{
    static _system            = __SparkleSystem();
    static _queuedArray       = _system.__queuedArray;
    static _savePendingArray  = _system.__savePendingArray;
    static _saveActivityArray = _system.__saveActivityArray;
    
    __filename         = _filename;
    __callback         = _callback;
    __callbackMetadata = _callbackMetadata;
    
    __groupName      = _system.__groupName;
    __psShowDialog   = _system.__psShowDialog;
    __psGamepadIndex = _system.__psGamepadIndex;
    __slotTitle      = _system.__slotTitle;
    __slotSubtitle   = _system.__slotSubtitle;
    __xboxUser       = _system.__xboxUser;
    __steamFile      = _system.__steamFile;
    
    if (SPARKLE_VERBOSE)
    {
        __SparkleTrace($"Created DELETE operation {string(ptr(self))}: group name = \"{__groupName}\", slot title = \"{__slotTitle}\", filename = \"{_filename}\", callback = {_callback}");
    }
    
    __dispatched   = false;
    __completed    = false;
    __activityTime = infinity;
    __asyncID      = undefined;
    __status       = SPARKLE_STATUS_QUEUED;
    
    static GetOperation = function()
    {
        return SPARKLE_OP_DELETE;
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
        
        __dispatched = true;
        __activityTime = current_time;
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Dispatching DELETE operation {string(ptr(self))}");
        }
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        array_push(_saveActivityArray, self);
        
        if (__steamFile && SparkleGetSteamCloud())
        {
            var _status = steam_file_delete($"{__groupName}/{__filename}");
            __Complete(_status? SPARKLE_STATUS_SUCCESS : SPARKLE_STATUS_FAILED);
        }
        else
        {
            if (SparkleGetWindowsUseGDK())
            {
                xboxone_set_savedata_user(_system.__xboxUser);
                var _buffer = __SparkleEmptyBuffer();
                
                gdk_save_group_begin($"root/{__groupName}"); //Recommended by YYG for cross-platform save support
                gdk_save_buffer(_buffer, __filename, 0, __SPARKLE_EMPTY_BUFFER_SIZE);
                __asyncID = gdk_save_group_end();
                
                buffer_delete(_buffer);
                
                __status = SPARKLE_STATUS_PENDING;
                array_push(_savePendingArray, self);
            }
            else if (SPARKLE_ON_DESKTOP || SPARKLE_ON_MOBILE)
            {
                file_delete($"{__groupName}/{__filename}");
                __Complete(SPARKLE_STATUS_SUCCESS);
            }
            else //Console
            {
                if (SPARKLE_ON_XBOX)
                {
                    xboxone_set_savedata_user(_system.__xboxUser);
                }
                
                var _buffer = __SparkleEmptyBuffer();
                buffer_async_group_begin(__groupName);
                buffer_async_group_option("slottitle", __slotTitle);
                buffer_async_group_option("subtitle",  __slotSubtitle);
                
                if (SPARKLE_ON_PS_ANY)
                {
                    buffer_async_group_option("showdialog",   __psShowDialog);
                    buffer_async_group_option("savepadindex", __psGamepadIndex);
                }
                
                if (__SPARKLE_PS_SAVE_BACKUP)
                {
                    buffer_async_group_option("ps_create_backup", true);
                }
                
                buffer_save_async(__buffer, __filename, 0, __SPARKLE_EMPTY_BUFFER_SIZE);
                
                __asyncID = buffer_async_group_end();
                buffer_delete(_buffer);
                
                __status = SPARKLE_STATUS_PENDING;
                array_push(_savePendingArray, self);
            }
        }
    }
    
    static __Complete = function(_status)
    {
        if (__completed) return;
        
        __completed = true;
        __activityTime = current_time;
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Completing DELETE operation {string(ptr(self))}: status = {_status}");
        }
        
        if (SPARKLE_ON_SWITCH && (_status == SPARKLE_STATUS_SUCCESS))
        {
            switch_save_data_commit();
        }
        
        __status = _status;
        __asyncID = undefined;
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        var _index = array_get_index(_savePendingArray, self);
        if (_index >= 0) array_delete(_savePendingArray, _index, 1);
        
        if (is_callable(__callback))
        {
            __callback(_status, __callbackMetadata);
        }
    }
}