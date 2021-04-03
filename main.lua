-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local spaceship = require('spaceship')


function love.load()
  spaceship.load()
end


function love.update(dt)
end


function love.draw()
  spaceship.draw()
end