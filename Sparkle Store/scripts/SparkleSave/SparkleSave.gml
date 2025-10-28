// Feather disable all

/// Starts an asynchronous save operation for a buffer (or part of a buffer).
/// 
/// @param filename
/// @param buffer
/// @param callback
/// @param [offset=0]
/// @param [size]
/// @param [priority=normal]

function SparkleSave(_filename, _buffer, _callback, _offset = 0, _size = infinity, _priority = false)
{
    static _system = __SparkleSystem();
    static _queuedArray = _system.__queuedArray;
    
    _offset = clamp(_offset, 0, buffer_get_size(_buffer)-1);
    _size = clamp(_size, 0, buffer_get_size(_buffer) - _offset);
    
    var _struct = new __SparkleClassSave(_filename, _buffer, _offset, _size, _callback);
    
    if (_priority == SPARKLE_PRIORITY_HIGH)
    {
        array_insert(_queuedArray, _struct, 0);
    }
    else if (_priority == SPARKLE_PRIORITY_IMMEDIATE)
    {
        _struct.__Execute();
    }
    else
    {
        array_push(_queuedArray, _struct);
    }
    
    return _struct;
}