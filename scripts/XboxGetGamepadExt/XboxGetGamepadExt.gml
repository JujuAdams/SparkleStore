// Feather disable all

/// @param user

function XboxGetGamepadExt(_user)
{
    if (not XboxGetUserIsSignedInExt(_user))
    {
        return -1;
    }
    
    var _i = 0;
    repeat(xboxone_get_user_count())
    {
        if (xboxone_user_for_pad(_i) == _user)
        {
            return _i;
        }
        
        ++_i;
    }
    
    return -1;
}