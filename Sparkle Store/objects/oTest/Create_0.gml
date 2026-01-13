// Feather disable all

watchStart = undefined;
loadedSurface = undefined;
loadedGraphicAlpha = 0;

gamepadFocus = -1;

contentText  = "Alfa";
contentImage = 0;

optionIndex = 0;
optionArray = [];

textArray = ["Alfa",    "Bravo",    "Charlie",
             "Delta",   "Echo",     "Foxtrot",
             "Golf",    "Hotel",    "India",
             "Juliett", "Kilo",     "Lima",
             "Mike",    "November", "Oscar",
             "Papa",    "Quebec",   "Romeo",
             "Sierra",  "Tango",    "Uniform",
             "Victor",  "Whiskey",  "Xray",
             "Yankee",  "Zulu"];

array_push(optionArray, {
    name: "Cycle content",
    func: method(other, function()
    {
        contentText = textArray[irandom(array_length(textArray)-1)];
        contentImage = (contentImage + 1) mod sprite_get_number(sprIcons);
    }),
});

array_push(optionArray, {
    name: "Save text",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleSaveString("test.txt", contentText, function(_status)
        {
            show_debug_message($"Returned status {_status}");
        });
    }),
});

array_push(optionArray, {
    name: "Save text x20",
    func: method(other, function()
    {
        watchStart = current_time;
        
        repeat(20)
        {
            SparkleSaveString("test.txt", contentText, function(_status)
            {
                show_debug_message($"Returned status {_status}");
            });
        }
    }),
});

array_push(optionArray, {
    name: "Delete text",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleDelete("test.txt", function(_status)
        {
            show_debug_message($"Returned status {_status}");
        });
    }),
});

array_push(optionArray, {
    name: "Load text",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadString("test.txt", function(_status, _string)
        {
            show_debug_message($"Returned status {_status}, string = \"{_string}\"");
            contentText = _string;
        });
    }),
});

array_push(optionArray, {
    name: "Load text x20",
    func: method(other, function()
    {
        watchStart = current_time;
        
        repeat(40)
        {
            SparkleLoadString("test.txt", function(_status, _string)
            {
                show_debug_message($"Returned status {_status}, string = \"{_string}\"");
                contentText = _string;
            });
        }
    }),
});

array_push(optionArray, {
    name: "Save JSON",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleSaveJSON("test.json", { contentText: contentText, contentImage: contentImage }, function(_status)
        {
            show_debug_message($"Returned status {_status}");
        });
    }),
});

array_push(optionArray, {
    name: "Load JSON",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadJSON("test.json", function(_status, _json)
        {
            show_debug_message($"Returned status {_status}, json = {json_stringify(_json)}");
            contentText  = _json.contentText;
            contentImage = _json.contentImage;
        });
    }),
});

array_push(optionArray, {
    name: "Save screenshot",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleSaveSurface("test.img", application_surface, function(_status)
        {
            show_debug_message($"Returned status {_status}");
        });
    }),
});
    
array_push(optionArray, {
    name: "Load screenshot",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadSurface("test.img", function(_status, _surface)
        {
            show_debug_message($"Surface = {_surface}");
            
            if (loadedSurface != undefined)
            {
                surface_free(loadedSurface);
                loadedSurface = undefined;
            }
            
            loadedSurface = _surface;
            loadedGraphicAlpha = 1.1;
        });
    }),
});