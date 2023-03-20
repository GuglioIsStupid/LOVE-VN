local dir = debug.getinfo(1).source:match("@?(.*/)"):gsub("/", ".")
local t = require (dir .. "text")
label = {}
curLabel = "story"

-- labels are basically "chapter" markers
-- labels are given as tables, they are lined with functions
-- example:
--[[
    label["label_name"] = {
        {"prefix", "text"},
        -- example of a function, i dont want the function to execute when the label is loaded
        -- so i put it in a table, and then execute it when the label is loaded
        {function() end},
    }
]]

-- 

function go(label)
    if label[label] then
        curLabel = label
        label[label]()
    else
        error("Label '" .. label .. "' does not exist")
    end
end

label["story"] = {
    -- The default chapter, this one is choosen by default,
    -- Since it is empty, it will go right to main menu when game is started
    {"e", "You just made a new VN with lovevn!"},
    {"e", "To start writing story, make a file called \"story.lua\" and require it in love.load()"},
    {"e", "{speed=30}I love{speed=20} changing speeds{speed=10} mid-text!"},
    {"e", "{speed=100}aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa{speed=1}aaaaaaaaaaaaaaaaaaaaaaaaaaa"},
    {function() print("t") end},
}

label["end"] = {
}

label["main_menu"] = {
    -- todo
}

function onLabelEnd()
    -- go to main menu
    go("main_menu")
end

function set(dia)
    t.set(dia)
end

return {
    draw = function()
        t.draw()
    end,

    update = function(dt)
        t.update(dt)
    end,

    keypressed = function(key)
        if key == "return" then
            if t.curChar < #t.txt then
                t.curChar = #t.txt
            else
                if label[curLabel][t.curLine + 1] then
                    t.curLine = t.curLine + 1
                    t.curChar = 1
                    set(label[curLabel][t.curLine])
                else
                    onLabelEnd()
                end
            end
        end
    end,
}