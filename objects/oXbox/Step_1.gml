// Feather disable all

if (__xboxUserDefer != undefined)
{
    __xboxUser = __xboxUserDefer;
    __xboxUserDefer = undefined;
}

if (__xboxGamepadDefer != undefined)
{
    __xboxGamepad = __xboxGamepadDefer;
    __xboxSeenGamepad = true;
    __xboxGamepadDefer = undefined;
}

if ((__xboxUser != int64(0)) && (xboxone_user_for_pad(__xboxGamepad) != __xboxUser))
{
    if (__xboxGamepad >= 0)
    {
        __xboxGamepad = -1;
        show_debug_message($"Gamepad for {__xboxUser} changed to {__xboxGamepad}");
    }
}

if (XBOX_SIMPLIFIED_USER_MODEL)
{
    if (__xboxUser != __xboxActivatingUser)
    {
        __funcFindController(__xboxActivatingUser);
    }
    else if (__xboxGamepad < 0)
    {
        if (__xboxSeenGamepad)
        {
            __funcFindController(__xboxActivatingUser);
        }
    }
}

__xboxUserChanged    = (__xboxUserPrevious    !=__xboxUser);
__xboxGamepadChanged = (__xboxGamepadPrevious !=__xboxGamepad);

__xboxUserPrevious    = __xboxUser;
__xboxGamepadPrevious = __xboxGamepad;

if (__xboxUserChanged)
{
    __funcEnsureAvatar();
}