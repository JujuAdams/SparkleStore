// Feather disable all

/// Clears the presence cache that tracks whether files do or don't exist (see `SparkleExists()` for
/// more information). You may specify a particular file whose cache you wish to clear, or you can
/// not provide a file in which case `SparkleExistsClearCache()` will clear the cache for every file.
/// 
/// @param [filename]

function SparkleExistsClearCache(_filename = undefined)
{
    static _presenceCacheMap = __SparkleSystem().__presenceCacheMap;
    
    if (_filename == undefined)
    {
        __SparkleTrace("Clearing presence cache for all files");
        ds_map_clear(_presenceCacheMap);
    }
    else
    {
        __SparkleTrace($"Clearing presence cache for \"{_filename}\"");
        ds_map_delete(_presenceCacheMap, __SparkleFileCacheKey(_filename));
    }
}