// Feather disable all

function XboxGetGamepadChanged()
{
    with(oXbox)
    {
        return __xboxGamepadChanged;
    }
    
    return false;
}