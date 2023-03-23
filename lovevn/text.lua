local t = {}

t.txt = ""
t.speed = 20
t.curChar = 1
t.isStr = false
t.sayer = ""
t.curCharacter = "" -- to check for {}
t.curLine = 0

t.set = function(dia)
    -- dialogue will be given like this
    -- {"prefix", "text"}
    -- An example of speed changes mid-text
    -- {"e", "This is a text with a {speed=10}speed change{speed=20} mid-text!"}

    if type(dia) == "table" then
        t.isStr = true
        t.sayer = dia[1]
        t.txt = dia[2]
        if dia[3] then
            t.func = dia[3][1]
        end
        if t.func then
            t.func()
        end
    else
        -- do the function
        dia()
        t.isStr = false
    end
end

t.update = function(dt)
    if t.isStr then
        if t.curChar < #t.txt then
            t.curChar = t.curChar + t.speed * dt
        end

        -- check for speed changes
        if t.txt:sub(t.curChar, t.curChar) == "{" then
            -- there can be multiple speed changes in one line
            -- look for first }
            local endPos = t.txt:find("}", t.curChar)
            -- get the speed change
            local speedChange = t.txt:sub(t.curChar, endPos)
            -- remove the speed change from the string
            t.txt = t.txt:gsub(speedChange, "")
            speedChange = speedChange:gsub("{", "")
            speedChange = speedChange:gsub("}", "")
            speedChange = speedChange:gsub("speed=", "")
            print(speedChange)
            t.speed = tonumber(speedChange)
        end

        -- check for end of string
        if t.curChar >= #t.txt then
            t.curChar = #t.txt
        end
    end
end

t.draw = function()
    if t.isStr then
        --
        love.graphics.print(t.txt:sub(1, t.curChar), 0, 0)
    end
end

return t