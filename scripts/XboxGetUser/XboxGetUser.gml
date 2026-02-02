// Feather disable all

/// Returns the currently signed in Xbox user.

function XboxGetUser()
{
    with(oXbox)
    {
        if (__xboxUser == int64(0))
        {
            return int64(0);
        }
        
        if (XboxGetUserIsSignedInExt(__xboxUser))
        {
            return __xboxUser;
        }
    }
    
    return int64(0);
}