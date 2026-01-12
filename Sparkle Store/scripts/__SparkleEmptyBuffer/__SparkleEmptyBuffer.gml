// Feather disable all

function __SparkleEmptyBuffer()
{
    return buffer_create(__SPARKLE_EMPTY_BUFFER_SIZE, buffer_grow, 1);
}