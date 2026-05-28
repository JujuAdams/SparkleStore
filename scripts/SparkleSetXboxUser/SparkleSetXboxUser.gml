// Feather disable all

/// Sets the current Xbox user for future save/load operations. This value will not impact any
/// operations that have already been started. You should still call this function even if you're
/// using GDK on Windows.
/// 
/// Tip: To bring Xbox Series X/S into parity with PlayStation, you might want to make use of
///      `xboxone_user_for_pad()`. For GDK on Windows, you should use the account picker in
///      combination with `xboxone_get_activating_user()`.
/// 
/// @param xboxUser

function SparkleSetXboxUser(_xboxUser)
{
    static _system = __SparkleSystem();
    
    __SparkleTrace($"xbox user = {_xboxUser}          {debug_get_callstack()}");
    
    _system.__xboxUser = _xboxUser;
}