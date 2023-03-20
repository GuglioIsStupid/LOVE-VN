function love.load()
    vn = require "lovevn"
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