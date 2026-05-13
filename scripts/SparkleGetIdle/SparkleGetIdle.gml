// Feather disable all

/// Returns if SparkleStore has no pending jobs that are yet to complete. This function returns the
/// opposite of `SpakleGetBusy()`.

function SparkleGetIdle()
{
    return (SparkleGetTotalPending() <= 0);
}