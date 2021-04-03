-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

love.window.setMode(1024, 768)
love.window.setTitle('Space Shooter')

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local spaceship = require('spaceship')


function love.load()
  spaceship.load()
end


function love.update(dt)
  spaceship.update(dt)
end


function love.draw()
  spaceship.draw()
end