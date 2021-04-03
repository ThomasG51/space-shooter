
-- create shoot and it to the shootList
function addShoot(x, y, shootList)
  
  local shoot = {}
  shoot.sprite = love.graphics.newImage('images/laser1.png')
  shoot.width = shoot.sprite:getWidth()
  shoot.height = shoot.sprite:getHeight()
  shoot.positionX = x
  shoot.positionY = y
  shoot.originX = shoot.width / 2
  shoot.originY = shoot.height / 2
  shoot.speed = 400

  table.insert(shootList, shoot)
  
end