function restartGame()

  spaceship.life = 5
  spaceship.positionX = WINDOW_WIDTH / 2
  spaceship.positionY = WINDOW_HEIGHT - 96

  map.scroll = 0
    
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

  local line = map.row - (WINDOW_HEIGHT / 64)
  local column = 8
  addAlien('mothership', WINDOW_WIDTH/2, -(line - 1) * 64, alienList)

end