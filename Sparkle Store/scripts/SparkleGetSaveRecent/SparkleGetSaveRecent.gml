// Feather disable all

/// Returns the number of save operations completed in the last minute.

function SparkleGetSaveRecent()
{
    static _saveActivityArray = __SparkleSystem().__saveActivityArray;
    return array_length(_saveActivityArray);
}