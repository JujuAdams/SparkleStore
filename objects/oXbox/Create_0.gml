// Feather disable all

__xboxAccountPickerID = -1;
__xboxAccountPickerGamepad = -1;
__funcShowAccountPicker = function(_gamepad)
{
    if ((__xboxAccountPickerID < 0) && (not xboxone_is_constrained()))
    {
        __xboxAccountPickerID = xboxone_show_account_picker(_gamepad, 0);
        __xboxAccountPickerGamepad = _gamepad;
        
        show_debug_message($"__xboxAccountPickerID = {__xboxAccountPickerID}, __xboxAccountPickerGamepad = {__xboxAccountPickerGamepad}");
    }
}

__xboxFindContollerID = -1;
__funcFindController = function(_user)
{
    if ((__xboxFindContollerID < 0) && (_user != int64(0)) && (not xboxone_is_constrained()))
    {
        __xboxFindContollerID = xboxone_find_controller_for_user(_user);
        show_debug_message($"__xboxFindContollerID = {__xboxFindContollerID}");
    }
}

__xboxAvatarRequestID = -1;
__funcEnsureAvatar = function()
{
    if (not XboxGetUserIsSignedIn())
    {
        if (sprite_exists(__xboxAvatar))
        {
            sprite_delete(__xboxAvatar);
            __xboxAvatar = -1;
        }
    }
    else
    {
        if (sprite_exists(__xboxAvatar))
        {
            sprite_delete(__xboxAvatar);
            __xboxAvatar = -1;
        }
        
        __xboxAvatar = xboxone_sprite_add_from_gamerpicture(__xboxUser, XBOX_AVATAR_SIZE, 0, 0);
    }
}

__xboxUser    = xboxone_get_activating_user();
__xboxGamepad = XboxGetGamepadExt(__xboxUser);
__xboxAvatar  = -1; __funcEnsureAvatar();

__xboxActivatingUser = __xboxUser;
__xboxSeenGamepad = (__xboxGamepad >= 0);

__xboxUserChanged  = false;
__xboxUserPrevious = __xboxUser;
__xboxUserDefer    = undefined;

__xboxGamepadChanged  = false;
__xboxGamepadPrevious = __xboxGamepad;
__xboxGamepadDefer    = undefined;

show_debug_message($"On boot: user = {__xboxUser}, gamepad = {__xboxGamepad}");

if (XBOX_SIMPLIFIED_USER_MODEL)
{
    if (__xboxUser == int64(0))
    {
        show_error(" \nThere has an error initializing user accounts. Please try again.\n ", true);
    }
}