// Feather disable all

var _string = string_join("\n", 
$"Total pending = {SparkleGetTotalPending()}",
$"Save pending = {SparkleGetSavePending()}",
$"Save recent = {SparkleGetSaveRecent()}",
$"Load pending = {SparkleGetLoadPending()}",
$"Load recent = {SparkleGetLoadRecent()}",
$"Activity = {SparkleGetActivity()}",
);

draw_text(10, 10, _string);