function gameOverUpdate()
  
  for i = #alienList, 1, -1 do
    table.remove(alienList, i)
  end
  
  for i = #shootList, 1, -1 do
    table.remove(shootList, i)
  end
  
  for i = #explosionList, 1, -1 do
    table.remove(explosionList, i)
  end
  
end