-- get the current dir

local dir = debug.getinfo(1).source:match("@?(.*/)"):gsub("/", ".")

require (dir .. "vn")