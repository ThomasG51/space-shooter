-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

love.window.setMode(1024, 768)
love.window.setTitle('Space Shooter')

-- use to active random value
math.randomseed(love.timer.getTime())

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

require('functions/addShoot')
require('functions/addAlien')
require('functions/collide')

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()
GAME_SCROLL = 30

local mainTheme = love.audio.newSource('sounds/music.mp3', 'stream')
local shootEffect = love.audio.newSource('sounds/shoot.wav', 'static')

local spaceship = require('spaceship')
local map = require('map')

local shootList = {}
local alienList = {}

-- Alien direction
local randomDirection = math.random(1,2)


function love.load()
  
  mainTheme:play()
  mainTheme:setVolume(0.5)
  spaceship.load()
  map.load()
  
  local line = 7
  local column = 8
  addAlien('turret', (column - 1) * 64, -(line - 1) * 64 + 32, alienList)
  
  local line = 14
  local column = 4
  addAlien('turret', (column - 1) * 64, -(line - 1) * 64 + 32, alienList)
  
  local line = 2
  local column = 8
  addAlien('fighter',  (column - 1) * 64, -(line - 1) * 64, alienList)
  
  local line = 6
  local column = 12
  addAlien('cargo',  (column - 1) * 64, -(line - 1) * 64, alienList)
  
  local line = 14
  local column = 4
  addAlien('mothership', (column - 1) * 64, -(line - 1) * 64, alienList)
  
end


function love.update(dt)
  
  -- MAP
  map.update(dt)
  
  -- SPACESHIP
  spaceship.update(dt)
  
  -- SHOOTS
  local i
  for i = #shootList, 1, -1 do
    
    -- movement
    shootList[i].positionX = shootList[i].positionX + shootList[i].speedX
    shootList[i].positionY = shootList[i].positionY + shootList[i].speedY

    -- Spaceship collision detection
    if shootList[i] ~= nil then
      if shootList[i].type == 'alien' and collide(spaceship, shootList[i]) then
         table.remove(shootList, i)
         spaceship.life = spaceship.life - 1
         if spaceship.life <= 0 then
           print('GAME OVER')
         end
      elseif shootList[i].positionY < 0 or 
             shootList[i].positionY > WINDOW_HEIGHT or 
             shootList[i].positionX < 0 or 
             shootList[i].positionX > WINDOW_WIDTH then
          table.remove(shootList, i)
      end
    end
    
    -- Alien collision detection
    for n = #alienList, 1, -1 do
      if shootList[i] ~= nil then
        if shootList[i].type == 'spaceship' and collide(alienList[n], shootList[i]) then
          table.remove(shootList, i)
          alienList[n].life = alienList[n].life - 1
          if alienList[n].life <= 0 then
            table.remove(alienList, n)
          end
        elseif shootList[i].positionY < 0 or 
               shootList[i].positionY > WINDOW_HEIGHT or 
               shootList[i].positionX < 0 or 
               shootList[i].positionX > WINDOW_WIDTH then
            table.remove(shootList, i)
        end
      end
    end

  end
  
  -- ALIENS
  local i
  for i = #alienList, 1, -1 do
    -- wake-up
    if alienList[i].positionY > 0 then
      alienList[i].sleep = false
    end
    
    if alienList[i].sleep == false then
      local shootDirection = math.angle(alienList[i].positionX,alienList[i].positionY, spaceship.positionX,spaceship.positionY)
      
      alienList[i].chronoShoot = alienList[i].chronoShoot + 1
      
      -- Aliens type settings
      if alienList[i].type == 'mothership' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)
        alienList[i].shootInterval = math.random(120, 240) 
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10
        
      elseif alienList[i].type == 'turret' then
        alienList[i].positionY = alienList[i].positionY + (GAME_SCROLL * dt) 
        alienList[i].shootInterval = math.random(10, 30)
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10 * math.sin(shootDirection)
        
      elseif alienList[i].type == 'cargo' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)        
        if randomDirection == 2 then
          alienList[i].positionX = alienList[i].positionX - (alienList[i].speedX * dt)
        else
          alienList[i].positionX = alienList[i].positionX + (alienList[i].speedX * dt)
        end
        alienList[i].shootInterval = math.random(80, 120)  
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10
        
      elseif alienList[i].type == 'fighter' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)
        if randomDirection == 2 then
          alienList[i].positionX = alienList[i].positionX + (alienList[i].speedX * dt)
        else
          alienList[i].positionX = alienList[i].positionX - (alienList[i].speedX * dt)
        end
        alienList[i].shootInterval = math.random(50, 180)  
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10 * math.sin(shootDirection)
      end
      
      -- shoots
      if alienList[i].chronoShoot >= alienList[i].shootInterval then
        addShoot('alien', alienList[i].positionX, alienList[i].positionY, alienList[i].shootSpeedX, alienList[i].shootSpeedY, shootList)
        shootEffect:play()
        alienList[i].chronoShoot = 0
      end
    else
      alienList[i].positionY = alienList[i].positionY + (GAME_SCROLL * dt)
    end
    
    -- remove
    if (alienList[i].positionY - ((alienList[i].height * alienList[i].scaleY) / 2)) > WINDOW_HEIGHT then
      table.remove(alienList, i)
    end
  end
  
end


function love.draw()
    
  -- draw map
  map.draw()
  
  -- draw shoots
  local i
  for i = 1, #shootList do
    love.graphics.draw(shootList[i].sprite, shootList[i].positionX, shootList[i].positionY, 0, 1.4, 1.4, shootList[i].originX, shootList[i].originY)
  end
  
  -- draw aliens
  local i
  for i = 1, #alienList do
    love.graphics.draw(alienList[i].sprite, alienList[i].positionX, alienList[i].positionY, 0, alienList[i].scaleX, alienList[i].scaleY, alienList[i].originX, alienList[i].originY)
  end
  
  -- draw spaceship
  spaceship.draw()
  
  -- draw logs
  love.graphics.print('Life: ' .. spaceship.life, 10, 10)
  love.graphics.print('Shoots: ' .. #shootList, 10, 30)
  love.graphics.print('Aliens: ' .. #alienList, 10, 50)
  love.graphics.print('Direction: ' .. randomDirection, 10, 70)
  
end


function love.keypressed(key)
  
  if key == 'space' then
    addShoot('spaceship', spaceship.positionX, spaceship.positionY - (spaceship.height / 2), 0, -10, shootList)
    shootEffect:play()
  end
  
end