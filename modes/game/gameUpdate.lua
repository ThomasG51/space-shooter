function gameUpdate(dt)

  -- MAP
  map.update(dt)
  
  -- SPACESHIP
  spaceship.update(dt)
  
  -- SHOOTS
  local i
  for i = #shootList, 1, -1 do
    -- shoot scrolling
    shootList[i].positionX = shootList[i].positionX + shootList[i].speedX
    shootList[i].positionY = shootList[i].positionY + shootList[i].speedY

    -- Spaceship collision detection
    if shootList[i] ~= nil then
      if shootList[i].type == 'alien' and collide(spaceship, shootList[i]) then
         table.remove(shootList, i)
         spaceship.life = spaceship.life - 1
         if spaceship.life <= 0 then
           --gameMode = 'game-over'
         end
      elseif shootList[i].positionY < 0 or 
             shootList[i].positionY > WINDOW_HEIGHT or 
             shootList[i].positionX < 0 or 
             shootList[i].positionX > WINDOW_WIDTH then
          table.remove(shootList, i)
      end
    end
    
    -- Alien collision detection
    for n = #alienList, 1, -1 do
      if shootList[i] ~= nil then
        if shootList[i].type == 'spaceship' and collide(alienList[n], shootList[i]) then
          addExplosion(alienList[n].positionX, alienList[n].positionY)
          explodeEffect:play()
          table.remove(shootList, i)
          alienList[n].life = alienList[n].life - 1  
          if alienList[n].life <= 0 then
            for i=1,5 do
              addExplosion((alienList[n].positionX - (alienList[n].width/2)) + math.random(-10, 10), (alienList[n].positionY - (alienList[n].height/2)) + math.random(-10, 10))
            end
            explodeEffect:play()
            table.remove(alienList, n)
          end
        elseif shootList[i].positionY < 0 or 
               shootList[i].positionY > WINDOW_HEIGHT or 
               shootList[i].positionX < 0 or 
               shootList[i].positionX > WINDOW_WIDTH then
            table.remove(shootList, i)
        end
      end
    end
  end
  
  -- ALIENS
  local i
  for i = #alienList, 1, -1 do
    -- wake-up
    if alienList[i].positionY > 0 then
      alienList[i].sleep = false
    end
    
    if alienList[i].sleep == false then
      local shootDirection = math.angle(alienList[i].positionX,alienList[i].positionY, spaceship.positionX,spaceship.positionY)
      
      alienList[i].chronoShoot = alienList[i].chronoShoot + 1
      
      -- Aliens type settings
      if alienList[i].type == 'mothership' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)
        alienList[i].shootInterval = math.random(120, 240) 
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10
        
      elseif alienList[i].type == 'turret' then
        alienList[i].positionY = alienList[i].positionY + (GAME_SCROLL * dt) 
        alienList[i].shootInterval = math.random(10, 30)
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10 * math.sin(shootDirection)
        
      elseif alienList[i].type == 'cargo' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)        
        if randomDirection == 2 then
          alienList[i].positionX = alienList[i].positionX - (alienList[i].speedX * dt)
        else
          alienList[i].positionX = alienList[i].positionX + (alienList[i].speedX * dt)
        end
        alienList[i].shootInterval = math.random(80, 120)  
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10
        
      elseif alienList[i].type == 'fighter' then
        alienList[i].positionY = alienList[i].positionY + (alienList[i].speedY * dt)
        if randomDirection == 2 then
          alienList[i].positionX = alienList[i].positionX + (alienList[i].speedX * dt)
        else
          alienList[i].positionX = alienList[i].positionX - (alienList[i].speedX * dt)
        end
        alienList[i].shootInterval = math.random(50, 180)  
        alienList[i].shootSpeedX = 10 * math.cos(shootDirection)
        alienList[i].shootSpeedY = 10 * math.sin(shootDirection)
      end
      
      -- shoots
      if alienList[i].chronoShoot >= alienList[i].shootInterval then
        addShoot('alien', alienList[i].positionX, alienList[i].positionY, alienList[i].shootSpeedX, alienList[i].shootSpeedY, shootList)
        shootEffect:play()
        alienList[i].chronoShoot = 0
      end
    else
      alienList[i].positionY = alienList[i].positionY + (GAME_SCROLL * dt)
    end
    
    -- remove
    if (alienList[i].positionY - ((alienList[i].height * alienList[i].scaleY) / 2)) > WINDOW_HEIGHT then
      table.remove(alienList, i)
    end
  end

  --EXPLOSIONS
  if #explosionList > 0 then
    for i = #explosionList, 1, -1 do
      explosionList[i].activeSprite = explosionList[i].activeSprite + 0.2
      if math.floor(explosionList[i].activeSprite) > 5 then
        table.remove(explosionList, i)
      end
    end
  end
end