// Feather disable all

steam_update_safe();

if (loadedGraphicAlpha > 0)
{
    loadedGraphicAlpha = max(loadedGraphicAlpha - 0.008, 0);
    if (loadedGraphicAlpha <= 0)
    {
        if (loadedSurface != undefined)
        {
            surface_free(loadedSurface);
            loadedSurface = undefined;
        }
    }
}

var _i = 0;
repeat(gamepad_get_device_count())
{
    if (gamepad_button_check_pressed(_i, gp_start))
    {
        gamepadFocus = _i;
        SparkleSetPSGamepadIndex(_i);
        SparkleSetXboxUser(xboxone_user_for_pad_safe(_i));
    }
    
    ++_i;
}

if (keyboard_check(vk_anykey))
{
    gamepadFocus = -1;
    SparkleSetPSGamepadIndex(-1);
}

var _optionCount = array_length(optionArray);

if (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(gamepadFocus, gp_padu))
{
    optionIndex = (optionIndex - 1 + _optionCount) mod _optionCount;
}

if (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(gamepadFocus, gp_padd))
{
    optionIndex = (optionIndex + 1) mod _optionCount;
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(gamepadFocus, gp_face1))
{
    optionArray[optionIndex].func();
}

if (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(gamepadFocus, gp_face4))
{
    SparkleCancelAll();
}

if ((watchStart != undefined) && (not SparkleGetActivity(0)))
{
    show_debug_message($"Operation lasted {current_time - watchStart}ms");
    watchStart = undefined;
}