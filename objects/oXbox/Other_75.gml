// Feather disable all

if ((async_load[? "id"] == __xboxFindContollerID) && (async_load[? "event_type"] == "find_controller_for_user_result"))
{
    var _user    = async_load[? "userID"];
    var _gamepad = async_load[? "pad_index"];
    
    show_debug_message("xboxone_find_controller_for_user() returned");
    show_debug_message($"Event user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad}");
    
    if (_user != int64(0))
    {
        __xboxUserDefer = _user;
        
        if (xboxone_user_for_pad(_gamepad) == _user)
        {
            __xboxGamepadDefer = _gamepad;
        }
        else
        {
            show_debug_message($"xboxone_find_controller_for_user() user {_user} for gamepad {_gamepad} is incorrect, trying workaround");
            if (xboxone_pad_count_for_user(_user) <= 0)
            {
                show_debug_message("xboxone_find_controller_for_user() workaround failed");
            }
            else
            {
                __xboxGamepadDefer = xboxone_pad_for_user(_user, 0);
                show_debug_message($"Workaround set gamepad {__xboxGamepadDefer}");
            }
        }
    }
    
    __xboxFindContollerID = -1;
}

if (async_load[? "event_type"] == "user controller associated")
{
    var _user    = async_load[? "user"];
    var _gamepad = async_load[? "pad_index"];
    
    show_debug_message($"User controller associated: user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__xboxUser} \"{XboxGetUserGamertagExt(__xboxUser)}\", existing gamepad = {__xboxGamepad})");
    
    if ((_gamepad == __xboxGamepad) && (_user != __xboxUser))
    {
        show_debug_message($"User for current gamepad {__xboxGamepad} changed");
        
        __xboxUserDefer = _user;
    }
    
    if ((_gamepad != __xboxGamepad) && (_user == __xboxUser))
    {
        show_debug_message($"Gamepad for current user {__xboxUser} changed");
        
        __xboxGamepadDefer = _gamepad;
    }
} 

if (async_load[? "event_type"] == "user controller disassociated")
{
    var _user    = async_load[? "user"];
    var _gamepad = async_load[? "pad_index"];
    
    show_debug_message($"User controller disassociated: user = {_user} \"{XboxGetUserGamertagExt(_user)}\", gamepad = {_gamepad} (existing user = {__xboxUser} \"{XboxGetUserGamertagExt(__xboxUser)}\", existing gamepad = {__xboxGamepad})");
    
    if ((_gamepad == __xboxGamepad) && (_user == __xboxUser))
    {
        show_debug_message($"User lost current gamepad {__xboxGamepad}");
        
        __xboxGamepadDefer = -1;
    }
}