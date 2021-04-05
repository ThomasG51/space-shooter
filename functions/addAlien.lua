-- create alien and it to the alienList
function addAlien(type, x, y, alienList)

  local alien = {}
  alien.type = type
  alien.sprite = love.graphics.newImage('images/alien_'..type..'.png')
  alien.positionX = x
  alien.positionY = y
  alien.width = alien.sprite:getWidth()
  alien.height = alien.sprite:getHeight()
  alien.originX = alien.width /2
  alien.originY = alien.height / 2
  alien.speedX = 20
  alien.speedY = 50
  alien.sleep = true
  
  if type == 'mothership' then
    alien.scaleX = 3.4
    alien.scaleY = 3.4
  elseif type == 'cargo' then
    alien.scaleX = 2.4
    alien.scaleY = 2.4
  elseif type == 'fighter' then
    alien.scaleX = 1.4
    alien.scaleY = 1.4
  elseif type == 'turret' then
    alien.scaleX = 1.4
    alien.scaleY = 1.4
  end
  
  table.insert(alienList, alien)
  
end