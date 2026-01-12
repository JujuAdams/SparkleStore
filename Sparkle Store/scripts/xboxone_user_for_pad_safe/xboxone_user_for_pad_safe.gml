// Feather disable all

/// @param gamepad

function xboxone_user_for_pad_safe(_gamepad)
{
    try
    {
        return xboxone_user_for_pad(_gamepad);
    }
    catch(_error)
    {
        return pointer_null;
    }
}