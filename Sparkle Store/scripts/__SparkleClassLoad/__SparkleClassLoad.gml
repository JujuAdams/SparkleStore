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
    
    __groupName    = _system.__groupName;
    __gamepadIndex = _system.__gamepadIndex;
    __slotTitle    = _system.__slotTitle;
    __slotSubtitle = _system.__slotSubtitle;
    
    if (SPARKLE_VERBOSE)
    {
        __SparkleTrace($"Created LOAD operation {string(ptr(self))}: group name = \"{__groupName}\", slot title = \"{__slotTitle}\", filename = \"{_filename}\", callback = {_callback}");
    }
    
    __buffer       = undefined;
    __executed     = false;
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
    
    static __Execute = function()
    {
        if (__executed)
        {
            return;
        }
        
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Executing LOAD operation {string(ptr(self))}");
        }
        
        __executed = true;
        __activityTime = current_time;
        
        __buffer = buffer_create(1, buffer_grow, 1);
        
        buffer_async_group_begin(__groupName);
    	buffer_async_group_option("showdialog", 0);
        
        if (SPARKLE_ON_PS4)
        {
        	buffer_async_group_option("savepadindex", __gamepadIndex);
        	buffer_async_group_option("slottitle",    __slotTitle);
        	buffer_async_group_option("subtitle",     __slotSubtitle);
        }
        
        buffer_load_async(__buffer, __filename, 0, -1);
        
    	__asyncID = buffer_async_group_end();
        
        var _index = array_get_index(_queuedArray, self);
        if (_index >= 0) array_delete(_queuedArray, _index, 1);
        
        array_push(_loadPendingArray, self);
        array_push(_loadActivityArray, self);
        
        __status = SPARKLE_STATUS_PENDING;
    }
    
    static __Complete = function(_status)
    {
        if (SPARKLE_VERBOSE)
        {
            __SparkleTrace($"Completing LOAD operation {string(ptr(self))}: status = {_status}");
        }
        
        __status = _status;
        __asyncID = undefined;
        __activityTime = current_time;
        
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