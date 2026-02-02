// Feather disable all

/// Returns which user was last signed in.

function XboxGetUserLastSignedIn()
{
    with(oXbox)
    {
        return __xboxUser;
    }
    
    return int64(0);
}