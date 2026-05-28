// Feather disable all

/// Returns if SparkleStore is waiting for any save/load/delete/exists operations to complete. This
/// function returns the opposite of `SpakleGetIdle()`.

function SparkleGetBusy()
{
    return (SparkleGetTotalPending() > 0);
}