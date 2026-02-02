// Feather disable all

/// Returns whether the Xbox wrapper is in a valid state. The state will be considered invalid if
/// the current user is not signed in or no gamepad has been set. Additionally, if the game is
/// running using the simplified user model then the state will be considered invalid if the
/// current user is not the activating user.
/// 
/// You should use this function to detect if some sort of user input is needed. Once you have
/// received input from a gamepad, call `XboxSetGamepad()`.

function XboxGetInvalidState()
{
    with(oXbox)
    {
        if (XBOX_SIMPLIFIED_USER_MODEL && (XboxGetUser() != __xboxActivatingUser))
        {
            return false;
        }
        
        return ((not XboxGetUserIsSignedIn()) || (XboxGetGamepad() < 0));
    }
    
    return false;
}