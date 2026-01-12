// Feather disable all

/// Sets up GDK functions for use with saving and loading. This function should only be called once
/// and must be called before saving/loading any data (otherwise Sparkle Store will use the wrong
/// internal functions).
/// 
/// N.B. You will still need to call `gdk_init()`, `gdk_update()` etc. in your own code.

function SparkleSetWindowsUseGDK()
{
    static _system = __SparkleSystem();
    
    if (os_type == os_windows)
    {
        if (not _system.__windowsUseGDK)
        {
            if (SPARKLE_RUNNING_FROM_IDE && _system.__anyRequestMade)
            {
                __SparkleError("Must call `SparkleSetWindowsUseGDK()` before calling save/load functions");
            }
            
            _system.__windowsUseGDK = true;
        }
    }
    else
    {
        __SparkleTrace("Warning! Can only use GDK on Windows");
    }
}