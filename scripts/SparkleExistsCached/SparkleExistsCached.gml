// Feather disable all

/// Returns whether a file's presence has been cached. Please see `SparkleExists()` for more
/// information.
/// 
/// @param filename

function SparkleExistsCached(_filename)
{
    static _presenceCacheMap = __SparkleSystem().__presenceCacheMap;
    return ds_map_exists(_presenceCacheMap, __SparkleFileCacheKey(_filename));
}