function addExplosion(x, y)

  local explosion = {}
  explosion.sprites = {}
  for i = 1,5 do
    explosion.sprites[i] = love.graphics.newImage('images/explode_'..i..'.png')
  end
  explosion.activeSprite = 1
  explosion.positionX = x
  explosion.positionY = y
  
  table.insert(explosionList, explosion)

end