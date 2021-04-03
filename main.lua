-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

love.window.setMode(1024, 768)
love.window.setTitle('Space Shooter')

-- use to active random value
math.randomseed(love.timer.getTime())

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local mainTheme = love.audio.newSource('sounds/music.mp3', 'stream')

local spaceship = require('spaceship')

require('functions/addShoot')
local shootList = {}

require('functions/addAlien')
local alienList = {}

-- Alien direction
local randomDirection = math.random(1,2)


function love.load()
  mainTheme:play()
  mainTheme:setVolume(0.5)
  spaceship.load()
  
  addAlien('mothership', 120, 120, alienList)
  addAlien('fighter', 520, 520, alienList)
  addAlien('cargo', 940, 360, alienList)
end


function love.update(dt)
  -- SPACESHIP
  spaceship.update(dt)
  
  -- SHOOTS
  local i
  for i = #shootList, 1, -1 do
    -- movement
    shootList[i].positionY = shootList[i].positionY - (shootList[i].speed *dt)

    -- remove
    if shootList[i].positionY < 0 then
      table.remove(shootList, i)
    end
  end
  
  -- ALIENS
  local i
  for i = #alienList, 1, -1 do
    -- movement
    alienList[i].positionY = alienList[i].positionY + (alienList[i].speed * dt)
          
    if alienList[i].type == 'cargo' then
      if randomDirection == 2 then
        alienList[i].positionX = alienList[i].positionX - (alienList[i].speed * dt)
      else
        alienList[i].positionX = alienList[i].positionX + (alienList[i].speed * dt)
      end
    elseif alienList[i].type == 'fighter' then
      if randomDirection == 2 then
        alienList[i].positionX = alienList[i].positionX + (alienList[i].speed * dt)
      else
        alienList[i].positionX = alienList[i].positionX - (alienList[i].speed * dt)
      end
    end
    
    -- remove
    if (alienList[i].positionY - ((alienList[i].height * alienList[i].scaleY) / 2)) > WINDOW_HEIGHT then
      table.remove(alienList, i)
    end
  end
end


function love.draw()
  -- draw spaceship
  spaceship.draw()
  
  -- draw shoots
  local i
  for i = 1, #shootList do
    love.graphics.draw(shootList[i].sprite, shootList[i].positionX, shootList[i].positionY, 0, 1, 1, shootList[i].originX, shootList[i].originY)
  end
  
  -- draw aliens
  local i
  for i = 1, #alienList do
    love.graphics.draw(alienList[i].sprite, alienList[i].positionX, alienList[i].positionY, 0, alienList[i].scaleX, alienList[i].scaleY, alienList[i].originX, alienList[i].originY)
  end
  
  -- draw logs
  love.graphics.print('Shoots: ' .. #shootList, 10, 10)
  love.graphics.print('Aliens: ' .. #alienList, 10, 30)
  love.graphics.print('Direction: ' .. randomDirection, 10, 50)
end


function love.keypressed(key)
  if key == 'space' then
    spaceship.shootSound:play()
    addShoot(spaceship.positionX, spaceship.positionY - (spaceship.height / 2), shootList)
  end
end