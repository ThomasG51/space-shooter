local map = {}
map.grid = {}
table.insert(map.grid, {0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,0})
table.insert(map.grid, {0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,0})
table.insert(map.grid, {0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(map.grid, {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3})
table.insert(map.grid, {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3})
map.row = #map.grid
map.column = 16
map.tile = {}
map.scroll = 0

map.load = function()
  
  -- tile sprite loading
  for i = 1, 3 do
    map.tile[i] = love.graphics.newImage('images/tile'..i..'.png')
  end

end


map.update = function(dt)

  map.scroll = map.scroll + (GAME_SCROLL*dt)

end


map.draw = function()

  local row,column
  for row = map.row, 1, -1 do
    for column = 1, map.column do
      if map.grid[row][column] > 0 then
        love.graphics.draw(map.tile[map.grid[row][column]], (column-1)*64, ((row-1)-(#map.grid-(WINDOW_HEIGHT/64)))*64 + map.scroll, 0, 2, 2)
      end
    end
  end
  
end

return map