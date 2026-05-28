// Feather disable all

/// @param user

function XboxGetUserGamertagExt(_user)
{
    return XboxGetUserIsSignedInExt(_user)? xboxone_classic_gamertag_for_user(_user) : "";
}