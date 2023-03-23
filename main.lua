function love.load()
    love.setDeprecationOutput(false)
    require "err"
    vn = require "lovevn"

    ss.d = "story"
end

function love.update(dt)
    vn.update(dt)
end

function love.keypressed(key)
    vn.keypressed(key)
end

function love.draw()
    vn.draw()
end