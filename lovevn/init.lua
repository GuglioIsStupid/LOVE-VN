-- get the current dir

local dir = debug.getinfo(1).source:match("@?(.*/)"):gsub("/", ".")

vn = require (dir .. "vn")

return vn