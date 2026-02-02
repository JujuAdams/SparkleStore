// Feather disable all

randomize();

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

if (SPARKLE_ON_XBOX)
{
    instance_create_depth(0, 0, 0, oXbox);
    SparkleSetXboxUser(XboxGetUser());
    gamepadFocus = XboxGetGamepad();
}

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
        
        SparkleSaveString("test.txt", contentText, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, callbackMetadata = {_callbackMetadata}");
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
            SparkleSaveString("test.txt", contentText, function(_status, _buffer_UNUSED, _callbackMetadata)
            {
                show_debug_message($"Returned status {_status}, callbackMetadata = {_callbackMetadata}");
            });
        }
    }),
});

array_push(optionArray, {
    name: "Delete text",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleDelete("test.txt", function(_status, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, callbackMetadata = {_callbackMetadata}");
        });
    }),
});

array_push(optionArray, {
    name: "Load text",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadString("test.txt", function(_status, _string, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, string = \"{_string}\", callbackMetadata = {_callbackMetadata}");
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
            SparkleLoadString("test.txt", function(_status, _string, _callbackMetadata)
            {
                show_debug_message($"Returned status {_status}, string = \"{_string}\", callbackMetadata = {_callbackMetadata}");
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
        
        SparkleSaveJSON("test.json", { contentText: contentText, contentImage: contentImage }, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, callbackMetadata = {_callbackMetadata}");
        });
    }),
});

array_push(optionArray, {
    name: "Load JSON",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadJSON("test.json", function(_status, _json, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, json = {json_stringify(_json)}, callbackMetadata = {_callbackMetadata}");
            if (_status == SPARKLE_STATUS_SUCCESS)
            {
                contentText  = _json.contentText;
                contentImage = _json.contentImage;
            }
        });
    }),
});

array_push(optionArray, {
    name: "Save screenshot",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleSaveSurface("test.img", application_surface, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"Returned status {_status}, callbackMetadata = {_callbackMetadata}");
        });
    }),
});

array_push(optionArray, {
    name: "Load screenshot",
    func: method(other, function()
    {
        watchStart = current_time;
        
        SparkleLoadSurface("test.img", function(_status, _surface, _callbackMetadata)
        {
            show_debug_message($"Returned status = {_status}, surface = {_surface}, callbackMetadata = {_callbackMetadata}");
            
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

array_push(optionArray, {
    name: "Test all",
    func: method(other, function()
    {
        watchStart = current_time;
        
        var _testBuffer  = buffer_create(69, buffer_fixed, 1);
        var _testString  = "hello world!";
        var _testJSON    = { hello: ["w", "o", "r", "l", "d"] };
        var _testSurface = -1;
        var _testSprite  = sprIcons;
        var _testImage   = 4;
        
        SparkleSave("test_bin", _testBuffer, function(_status, _buffer, _callbackMetadata)
        {
            show_debug_message($"\"test_bin\" SAVE returned status = {_status}, buffer = {_buffer} (size={buffer_get_size(_buffer)}), callbackMetadata = {_callbackMetadata}");
            buffer_delete(_buffer);
        },
        "test_bin SAVE");
        
        SparkleSaveString("test_string", _testString, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"\"test_string\" SAVE returned status = {_status}, callbackMetadata = {_callbackMetadata}");
        },
        "test_string SAVE");
        
        SparkleSaveJSON("test_json", _testJSON, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"\"test_json\" SAVE returned status = {_status}, callbackMetadata = {_callbackMetadata}");
        },
        "test_json SAVE");
        
        SparkleSaveSurface("test_surface", _testSurface, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"\"test_surface\" SAVE returned status = {_status}, callbackMetadata = {_callbackMetadata}");
        },
        "test_surface SAVE");
        
        SparkleSaveSprite("test_sprite", _testSprite, _testImage, function(_status, _buffer_UNUSED, _callbackMetadata)
        {
            show_debug_message($"\"test_sprite\" SAVE returned status = {_status}, callbackMetadata = {_callbackMetadata}");
        },
        "test_sprite SAVE");
        
        SparkleLoad("test_bin", function(_status, _buffer, _callbackMetadata)
        {
            show_debug_message($"\"test_bin\" LOAD returned status = {_status}, buffer = {_buffer}, callbackMetadata = {_callbackMetadata}");
            buffer_delete(_buffer);
        },
        "test_bin LOAD");
        
        SparkleLoadString("test_string", function(_status, _string, _callbackMetadata)
        {
            show_debug_message($"\"test_string\" LOAD returned status = {_status}, string = \"{_string}\", callbackMetadata = {_callbackMetadata}");
        },
        "test_string LOAD");
        
        SparkleLoadJSON("test_json", function(_status, _json, _callbackMetadata)
        {
            show_debug_message($"\"test_json\" LOAD returned status = {_status}, JSON = \"{json_stringify(_json)}\", callbackMetadata = {_callbackMetadata}");
        },
        "test_json LOAD");
        
        SparkleLoadSurface("test_surface", function(_status, _surface, _callbackMetadata)
        {
            show_debug_message($"\"test_surface\" LOAD returned status = {_status}, buffer = {_surface}, callbackMetadata = {_callbackMetadata}");
            
            if (surface_exists(_surface))
            {
                surface_free(_surface);
            }
        },
        "test_surface LOAD");
        
        SparkleLoadSprite("test_sprite", function(_status, _sprite, _callbackMetadata)
        {
            show_debug_message($"\"test_sprite\" LOAD returned status = {_status}, buffer = {_sprite}, callbackMetadata = {_callbackMetadata}");
            
            if (sprite_exists(_sprite))
            {
                sprite_delete(_sprite);
            }
        },
        "test_sprite LOAD");
        
        SparkleDelete("test_bin", function(_status, _callbackMetadata)
        {
            show_debug_message($"\"test_bin\" DELETE returned status = {_status}, callbackMetadata = {_callbackMetadata}");
        },
        "test_bin DELETE");
    }),
});

array_push(optionArray, {
    name: "\"test.txt\" exists",
    func: method(other, function()
    {
        var _exists = SparkleExist("test.txt", function(_state, _cached, _callbackMetadata)
        {
            if (not _cached)
            {
                show_debug_message($"Callback said: \"{_callbackMetadata}\" exists = {_state}");
            }
        },
        "test.txt");
        
        show_debug_message($"\"test.txt\" exists = {_exists}");
    }),
});

array_push(optionArray, {
    name: "Clear cache",
    func: method(other, function()
    {
        SparkleExistClearCache();
    }),
});