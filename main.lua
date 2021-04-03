-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

love.window.setMode(1024, 768)
love.window.setTitle('Space Shooter')

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local mainTheme = love.audio.newSource('sounds/music.mp3', 'stream')

local spaceship = require('spaceship')

require('functions/addShoot')
local shootList = {}


function love.load()
  mainTheme:play()
  mainTheme:setVolume(0.6)
  spaceship.load()
end


function love.update(dt)
  spaceship.update(dt)
  
  local i
  for i = #shootList, 1, -1 do
    -- shoot movement
    shootList[i].positionY = shootList[i].positionY - (shootList[i].speed *dt)

    -- destruct shoot
    if shootList[i].positionY < 0 then
      table.remove(shootList, i)
    end
  end
end


function love.draw()
  spaceship.draw()
  
  local i
  for i = 1, #shootList do
    love.graphics.draw(shootList[i].sprite, shootList[i].positionX, shootList[i].positionY, 0, 1, 1, shootList[i].originX, shootList[i].originY)
  end
  
  love.graphics.print('Shoots: ' .. #shootList)
end


function love.keypressed(key)

  if key == 'space' then
    spaceship.shootSound:play()
    addShoot(spaceship.positionX, spaceship.positionY - (spaceship.height / 2), shootList)
  end

end