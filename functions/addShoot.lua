
-- create shoot and it to the shootList
function addShoot(type, x, y, speedX, speedY, shootList)
  
  local shoot = {}
  shoot.type = type
  if type == 'spaceship' then
    shoot.sprite = love.graphics.newImage('images/laser1.png')
  elseif type == 'alien' then
    shoot.sprite = love.graphics.newImage('images/laser2.png')
  end
  shoot.width = shoot.sprite:getWidth()
  shoot.height = shoot.sprite:getHeight()
  shoot.positionX = x
  shoot.positionY = y
  shoot.originX = shoot.width / 2
  shoot.originY = shoot.height / 2
  shoot.speedX = speedX
  shoot.speedY = speedY

  table.insert(shootList, shoot)
  
end