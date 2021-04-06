function gameDraw()

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
  love.graphics.draw(spaceship.sprite, spaceship.positionX, spaceship.positionY, spaceship.rotation, spaceship.scaleX, spaceship.scaleY, spaceship.originX, spaceship.originY)
  
  -- draw explosions
  if #explosionList > 0 then
    for i = #explosionList, 1, -1 do
      love.graphics.draw(explosionList[i].sprites[math.floor(explosionList[i].activeSprite)], explosionList[i].positionX, explosionList[i].positionY, 0, 1.4, 1.4)
    end
  end
  
  
  -- draw logs
  love.graphics.print('Life: ' .. spaceship.life, 10, 10)
  love.graphics.print('Shoots: ' .. #shootList, 10, 30)
  love.graphics.print('Aliens: ' .. #alienList, 10, 50)
  love.graphics.print('Direction: ' .. randomDirection, 10, 70)
  love.graphics.print('Explosions: ' .. #explosionList, 10, 90)

end