local gerenciadorMapas = require("modules.maps")

-- Called only one time
function love.load()
  gerenciadorMapas:loadTileSet("media/map/tiles")
  gerenciadorMapas.mapaAtivo = "start"

  love.window.setFullscreen(true)
  fullscreen_modes = love.window.getFullscreenModes(1)
  -- love.window.setMode(1)  
  --for k, v in ipairs(fullscreen_modes) do 
    --print(k)
    --print(v)
    --print(v.height .. " & " .. v.width)

  --end
end 

-- Updating the screen
function love.draw()
  gerenciadorMapas:drawMap(gerenciadorMapas.mapaAtivo)
end


function love.quit() 
  love.window.close()
end

-- Game loop
function love.update(dt) 

end


