// Feather disable all

/// Returns if SparkleStore is waiting for any save/load/delete/exists operations to complete.

function SparkleGetBusy()
{
    return (SparkleGetTotalPending() > 0);
}