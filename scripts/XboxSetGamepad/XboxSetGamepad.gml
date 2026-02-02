// Feather disable all

/// @param gamepad

function XboxSetGamepad(_gamepad)
{
    with(oXbox)
    {
        if (__xboxFindContollerID >= 0)
        {
            show_debug_message("Cannot set gamepad, find_controller dialog is open");
            return;
        }
        
        if (XBOX_SIMPLIFIED_USER_MODEL)
        {
            var _user = xboxone_user_for_pad(_gamepad);
            if (_user == __xboxActivatingUser)
            {
                __xboxGamepad = _gamepad;
                __xboxSeenGamepad = true;
                
                show_debug_message($"Set gamepad {__xboxGamepad}");
            }
            else
            {
                show_debug_message($"Cannot set gamepad {_gamepad}, its user {_user} is not the activating user {__xboxActivatingUser}");
                
                __funcFindController(__xboxActivatingUser);
            }
            
            return;
        }
        
        if (__xboxGamepad == _gamepad)
        {
            show_debug_message($"Gamepad is already {__xboxGamepad}");
        }
        else
        {
            var _user = xboxone_user_for_pad(_gamepad);
            show_debug_message($"Found user {_user} for gamepad {_gamepad} (current user {__xboxUser})");
            
            if (XboxGetInvalidState())
            {
                show_debug_message($"Existing user is invalid, showing account picker");
                
                __funcShowAccountPicker(_gamepad);
            }
            else if (_user == int64(0))
            {
                show_debug_message($"Incoming user is null, showing account picker");
                
                __funcShowAccountPicker(_gamepad);
            }
            else
            {
                __xboxUser    = _user;
                __xboxGamepad = _gamepad;
                
                __xboxSeenGamepad = true;
                
                show_debug_message($"Set user = {__xboxUser}, gamepad = {__xboxGamepad}");
            }
        }
    }
}