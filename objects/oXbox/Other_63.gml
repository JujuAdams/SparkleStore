// Feather disable all

if (async_load[? "id"] == __xboxAccountPickerID)
{
    var _user = async_load[? "user"] ?? int64(0);
    
    show_debug_message($"Account picker return, old user = {__xboxUser} \"{XboxGetUserDisplayNameExt(__xboxUser)}\", new user = {_user} \"{XboxGetUserDisplayNameExt(_user)}\"");
    
    if ((_user != int64(0)) && (_user != __xboxUser))
    {
        show_debug_message($"Changing user");
        
        __xboxUserDefer = _user;
        __xboxGamepadDefer = __xboxAccountPickerGamepad;
    }
    
    __xboxAccountPickerID = -1;
    __xboxAccountPickerGamepad = -1;
}