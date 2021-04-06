mainTheme = love.audio.newSource('sounds/music.mp3', 'stream')
shootEffect = love.audio.newSource('sounds/shoot.wav', 'static')
explodeEffect = love.audio.newSource('sounds/explode_touch.wav', 'static')


shootList = {}
alienList = {}
explosionList = {}

-- Alien direction
randomDirection = math.random(1,2)


function gameLoad()
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
  local column = 8
  addAlien('mothership', (column - 1) * 64, -(line - 1) * 64, alienList)

end