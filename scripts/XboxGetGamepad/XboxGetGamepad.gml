// Feather disable all

function XboxGetGamepad()
{
    with(oXbox)
    {
        return __xboxGamepad;
    }
    
    return -1;
}