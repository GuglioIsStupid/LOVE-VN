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
            local speed = t.txt:sub(t.curChar + 1, t.txt:find("}", t.curChar) - 1)
            t.speed = tonumber(speed:sub(speed:find("=") + 1))
            t.curChar = t.txt:find("}", t.curChar) + 1
        end
        -- remove the speed change from the string
        t.txt = t.txt:gsub("{speed=%d+}", "")

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