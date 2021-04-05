function collide(a1, a2)
  
  if (a1==a2) then 
    return false
  end
  
  local dx = a1.positionX - a2.positionX
  local dy = a1.positionY - a2.positionY
  
  if (math.abs(dx) < a1.sprite:getWidth()+a2.sprite:getWidth()) then
    if (math.abs(dy) < a1.sprite:getHeight()+a2.sprite:getHeight()) then
      return true
    end
  end
  
  return false
  
end