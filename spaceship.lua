local spaceship = {}
spaceship.sprite = love.graphics.newImage('images/heros.png')
spaceship.width = spaceship.sprite:getWidth()
spaceship.height = spaceship.sprite:getHeight()
spaceship.postionX = 0
spaceship.positionY = 0
spaceship.rotation = 0
spaceship.scaleX = 1
spaceship.scaleY = 1
spaceship.originX = spaceship.width / 2
spaceship.originY = spaceship.height / 2

spaceship.load = function()
  spaceship.positionX = WINDOW_WIDTH / 2
  spaceship.positionY = WINDOW_HEIGHT / 2
end

spaceship.update = function(dt)
end

spaceship.draw = function()
  love.graphics.draw(spaceship.sprite, spaceship.positionX, spaceship.positionY, spaceship.rotation, spaceship.scaleX, spaceship.scaleY, spaceship.originX, spaceship.originY)
end

return spaceship