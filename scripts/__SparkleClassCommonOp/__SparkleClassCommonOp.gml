// Feather disable all

/// @param filename
/// @param callback
/// @param callbackMetadata

function __SparkleClassCommonOp(_filename, _callback, _callbackMetadata) constructor
{
    static _system           = __SparkleSystem();
    static _queuedArray      = _system.__queuedArray;
    static _presenceCacheMap = _system.__presenceCacheMap;
    
    __filename         = _filename;
    __callback         = _callback;
    __callbackMetadata = _callbackMetadata;
    
    __groupName      = _system.__groupName;
    __psShowDialog   = _system.__psShowDialog;
    __psGamepadIndex = _system.__psGamepadIndex;
    __psSlotTitle    = _system.__psSlotTitle;
    __psSlotSubtitle = _system.__psSlotSubtitle;
    __xboxUser       = _system.__xboxUser;
    __steamFile      = _system.__steamFile;
    
    __fileCacheKey = __SparkleFileCacheKey(__filename);
    
    __dispatched   = false;
    __completed    = false;
    __activityTime = infinity;
    __asyncID      = undefined;
    __status       = SPARKLE_STATUS_QUEUED;
    
    
    
    static GetFilename = function()
    {
        return __filename;
    }
    
    static GetCallbackMetadata = function()
    {
        return __callbackMetadata;
    }
    
    static Cancel = function()
    {
        __Complete(SPARKLE_STATUS_CANCELLED);
    }
    
    static GetStatus = function()
    {
        return __status;
    }
    
    static __GetFileCacheKey = function()
    {
        return __fileCacheKey;
    }
}