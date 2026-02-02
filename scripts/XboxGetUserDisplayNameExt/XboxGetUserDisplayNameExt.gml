// Feather disable all

/// @param user

function XboxGetUserDisplayNameExt(_user)
{
    return XboxGetUserIsSignedInExt(_user)? xboxone_gamedisplayname_for_user(_user) : "";
}