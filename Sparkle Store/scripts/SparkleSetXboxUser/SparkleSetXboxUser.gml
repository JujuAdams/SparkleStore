// Feather disable all

/// Sets the current Xbox user for future save/load operations. This value will not impact any
/// operations that have already been started. Tip: For parity for PlayStation, you might want to
/// use `xboxone_user_for_pad()`.
/// 
/// @param xboxUser

function SparkleSetXboxUser(_xboxUser)
{
    static _system = __SparkleSystem();
    
    _system.__xboxUser = _xboxUser;
}