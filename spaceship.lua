local spaceship = {}
spaceship.sprite = love.graphics.newImage('images/heros.png')
spaceship.width = spaceship.sprite:getWidth()
spaceship.height = spaceship.sprite:getHeight()
spaceship.positionX = 0
spaceship.positionY = 0
spaceship.rotation = 0
spaceship.scaleX = 1
spaceship.scaleY = 1
spaceship.originX = spaceship.width / 2
spaceship.originY = spaceship.height / 2
spaceship.speed = 350
spaceship.borderUp = 0
spaceship.borderRight = 0
spaceship.borderDown = 0
spaceship.borderLeft = 0
spaceship.life = 5


spaceship.load = function()
  
  spaceship.positionX = WINDOW_WIDTH / 2
  spaceship.positionY = WINDOW_HEIGHT - 96
  
  spaceship.scaleX = 1.8
  spaceship.scaleY = 1.8
  
end


spaceship.update = function(dt)
  
  -- sprite limit
  spaceship.borderUp = spaceship.positionY - (spaceship.height / 2)
  spaceship.borderRight = spaceship.positionX + (spaceship.width / 2)
  spaceship.borderDown = spaceship.positionY + (spaceship.height / 2)
  spaceship.borderLeft = spaceship.positionX - (spaceship.width / 2)
  
  --spaceship movement
  if love.keyboard.isDown('up') and spaceship.borderUp >= 40 then
    spaceship.positionY = spaceship.positionY - (spaceship.speed * dt)
  end
  
  if love.keyboard.isDown('right') and spaceship.borderRight <= (WINDOW_WIDTH - 10) then
    spaceship.positionX = spaceship.positionX + (spaceship.speed * dt)
  end
  
  if love.keyboard.isDown('down') and spaceship.borderDown <= (WINDOW_HEIGHT - 40) then
    spaceship.positionY = spaceship.positionY+ (spaceship.speed * dt)
  end
  
  if love.keyboard.isDown('left') and spaceship.borderLeft >= 10  then
    spaceship.positionX = spaceship.positionX - (spaceship.speed * dt)
  end
  
end


spaceship.draw = function()
  
  love.graphics.draw(spaceship.sprite, spaceship.positionX, spaceship.positionY, spaceship.rotation, spaceship.scaleX, spaceship.scaleY, spaceship.originX, spaceship.originY)
  
end


return spaceship