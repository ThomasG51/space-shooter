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

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()
GAME_SCROLL = 30

gameMode = 'menu'

require('functions/addShoot')
require('functions/addAlien')
require('functions/addExplosion')
require('functions/collide')
require('modes/game/gameLoad')
require('modes/game/gameUpdate')
require('modes/game/gameDraw')
require('modes/menu/menuLoad')
require('modes/menu/menuDraw')
require('modes/game-over/gameOverLoad')
require('modes/game-over/gameOverDraw')

spaceship = require('spaceship')
map = require('map')


function love.load()
  menuLoad()
  gameLoad()
  gameOverLoad()
end


function love.update(dt)
  if gameMode == 'game' then
    gameUpdate(dt)
  elseif gameMode == 'menu' then
    
  elseif gameMode == 'pause' then
    
  elseif gameMode == 'game-over' then
    
  end
end


function love.draw() 
  if gameMode == 'game' then
    gameDraw() 
  elseif gameMode == 'menu' then
    menuDraw()
  elseif gameMode == 'pause' then
    
  elseif gameMode == 'game-over' then
    gameOverDraw()
  end
end


function love.keypressed(key)
  if key == 'space' then
    addShoot('spaceship', spaceship.positionX, spaceship.positionY - (spaceship.height / 2), 0, -10, shootList)
    shootEffect:play()
  end
  
  if key == 'return' then
    gameMode = 'game'
    mainTheme:play()
    mainTheme:setVolume(0.5)
  end
end