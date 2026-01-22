// Feather disable all

/// @param filename
/// @param buffer
/// @param offset
/// @param size
/// @param callback
/// @param callbackMetadata

function __SparkleClassSave(_filename, _buffer, _offset, _size, _callback, _callbackMetadata) : __SparkleClassCommonOp(_filename, _callback, _callbackMetadata) constructor
{
    static _savePendingArray  = _system.__savePendingArray;
    static _saveActivityArray = _system.__saveActivityArray;
    
    __buffer = _buffer;
    __offset = _offset;
    __size   = _size;
    
    if (SPARKLE_VERBOSE)
    {
        __SparkleTrace($"Created SAVE operation {string(ptr(self))}: group name = \"{__groupName}\", slot title = \"{__psSlotTitle}\", filename = \"{_filename}\", buffer = {_buffer}, offset = {_offset}, size = {_size}, callback = {_callback}");
    }
    
    __opType = SPARKLE_OP_SAVE;
    
    
    
    static GetOperation = function()
    {
        return __opType;
    }
    
    static __Dispatch = function()
    {
        if (__dispatched) return;
        
        __dispatched = true;
        __activityTime = current_time;
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Dispatching SAVE operation {string(ptr(self))}");
        }
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        array_push(_saveActivityArray, self);
        
        if (__steamFile && SparkleGetSteamCloud())
        {
            if ((__offset != 0) || (buffer_get_size(__buffer) != __size))
            {
                var _tempBuffer = buffer_create(__size, buffer_fixed, 1);
                buffer_copy(__buffer, __offset, __size, _tempBuffer, 0);
                var _status = steam_file_write_buffer($"{__groupName}/{__filename}", _tempBuffer);
                buffer_delete(_tempBuffer);
            }
            else
            {
                var _status = steam_file_write_buffer($"{__groupName}/{__filename}", __buffer);
            }
            
            __Complete(_status? SPARKLE_STATUS_SUCCESS : SPARKLE_STATUS_FAILED);
        }
        else
        {
            if (SparkleGetWindowsUseGDK())
            {
                xboxone_set_savedata_user(_system.__xboxUser);
                gdk_save_group_begin($"root/{__groupName}"); //Recommended by YYG for cross-platform save support
                gdk_save_buffer(__buffer, __filename, __offset, __size);
                __asyncID = gdk_save_group_end();
            }
            else
            {
                if (SPARKLE_ON_XBOX)
                {
                    xboxone_set_savedata_user(_system.__xboxUser);
                }
                
                buffer_async_group_begin(__groupName);
                
                if (SPARKLE_ON_PS_ANY)
                {
                    buffer_async_group_option("showdialog",   __psShowDialog);
                    buffer_async_group_option("savepadindex", __psGamepadIndex);
                    buffer_async_group_option("slottitle",    __psSlotTitle);
                    buffer_async_group_option("subtitle",     __psSlotSubtitle);
                }
                
                if (__SPARKLE_PS_SAVE_BACKUP)
                {
                    buffer_async_group_option("ps_create_backup", true);
                }
                
                buffer_save_async(__buffer, __filename, __offset, __size);
                
                __asyncID = buffer_async_group_end();
            }
            
            __status = SPARKLE_STATUS_PENDING;
            array_push(_savePendingArray, self);
        }
    }
    
    static __Complete = function(_status)
    {
        if (__completed) return;
        
        __completed = true;
        __activityTime = current_time;
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Completing SAVE operation {string(ptr(self))}: status = {_status}");
        }
        
        if (SPARKLE_ON_SWITCH && (_status == SPARKLE_STATUS_SUCCESS))
        {
            switch_save_data_commit();
        }
        
        if (_status == SPARKLE_STATUS_SUCCESS)
        {
            _presenceCacheMap[? __SparkleFileCacheKey(__filename)] = true;
        }
        
        __status = _status;
        __asyncID = undefined;
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        var _index = array_get_index(_savePendingArray, self);
        if (_index >= 0) array_delete(_savePendingArray, _index, 1);
        
        if (is_callable(__callback))
        {
            __callback(_status, __buffer, __callbackMetadata);
        }
    }
}