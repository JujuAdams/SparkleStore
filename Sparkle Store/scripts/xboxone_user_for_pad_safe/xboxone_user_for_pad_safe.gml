// Feather disable all

/// @param gamepad

function xboxone_user_for_pad_safe(_gamepad)
{
    try
    {
        var _user = xboxone_user_for_pad(_gamepad);
    }
    catch(_error)
    {
        return int64(0);
    }
    
    if (_user == 0)
    {
        //Account isn't known to the game yet, show the account picker
        xboxone_show_account_picker(_gamepad, false);
        return int64(0);
    }
    else
    {
        return _user;
    }
}