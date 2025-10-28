// Feather disable all

/// Returns the number of load operations completed in the last minute.

function SparkleGetLoadRecent()
{
    static _loadActivityArray = __SparkleSystem().__loadActivityArray;
    return array_length(_loadActivityArray);
}