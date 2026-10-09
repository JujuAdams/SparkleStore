// Feather disable all

if (__SPARKLE_PS_SAVE_BACKUP && (async_load[? "event_type"] == "save_data_event") && (async_load[? "type"] == "unmount_backup_end"))
{
    with(__SparkleSystem())
    {
        if (is_struct(__ps5BackUpOperation))
        {
            if (SPARKLE_VERBOSE)
            {
                __SparkleTrace($"Backup process completed for {string(ptr(__ps5BackUpOperation))}");
            }
            
            __ps5BackUpOperation.__Complete(SPARKLE_STATUS_SUCCESS);
            __ps5BackUpOperation = undefined;
        }
        else
        {
            __SparkleTrace("Warning! Backup event received but no backup is in progress");
        }
    }
}