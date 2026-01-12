// Feather disable all

var _string = string_join("\n",
$"Sparkle Store = {SPARKLE_VERSION}, {SPARKLE_DATE}",
$"Time = {date_datetime_string(date_current_datetime())}",
$"Gamepad focus = {gamepadFocus}",
$"Group name    = \"{SparkleGetGroupName()}\"",
$"Slot title    = \"{SparkleGetConsoleSlotTitle()}\"",
$"Slot subtitle = \"{SparkleGetConsoleSlotSubtitle()}\"");

_string += "\n\n";

if (SPARKLE_ON_PS_ANY)
{
    _string += $"PS show dialog   = {SparkleGetPSShowDialog()}\n";
    _string += $"PS gamepad index = {SparkleGetPSGamepadIndex()}\n";
}

if (SPARKLE_ON_XBOX || SparkleGetWindowsUseGDK())
{
    _string += $"Windows using GDK = {SparkleGetWindowsUseGDK()? "true" : "false"}\n";
    _string += $"Xbox user         = {SparkleGetXboxUser()}\n";
}

_string += "\n";

_string += string_join("\n",
$"Total pending = {SparkleGetTotalPending()}",
$"Save pending  = {SparkleGetSavePending()}",
$"Save recent   = {SparkleGetSaveRecent()}",
$"Load pending  = {SparkleGetLoadPending()}",
$"Load recent   = {SparkleGetLoadRecent()}",
$"Activity      = {SparkleGetActivity()? "true" : "false"}",
" ",
"Press gp_start to focus a gamepad. Press any keyboard key to focus the keyboard",
"Use arrow keys or dpad to choose an option. Press space/gp_face1 to select an option",
"Press escape/gp_face4 to cancel all pending operations",
);

_string += "\n\n";
_string += $"Random text = {contentText}\n";
_string += $"Image = {contentImage}\n";
_string += "\n";

var _i = 0;
repeat(array_length(optionArray))
{
    _string += (_i == optionIndex)? "--> " : "    ";
    _string += optionArray[_i].name;
    _string += "\n";
    
    ++_i;
}

draw_text(10, 10, _string);

draw_sprite(sprIcons, contentImage, room_width - sprite_get_width(sprIcons), 0);

if (surface_exists(loadedSurface))
{
    draw_surface_ext(loadedSurface, 0, 0, 1, 1, 0, c_white, min(1, loadedGraphicAlpha));
}