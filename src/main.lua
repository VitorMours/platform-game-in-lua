local gerenciadorMapas = require("modules.maps")
local player = require("modules.player")
local SCALE = 3

function love.load()
    love.window.setTitle("RogueLike")
    love.window.setFullscreen(true)


    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Carrega mapas
    gerenciadorMapas:loadTileSet("media/map/tiles")
    gerenciadorMapas.mapaAtivo = "start"



    player:load()
end 

function love.update(dt)
    dt = math.min(dt, 0.016)

    player:move(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.scale(SCALE, SCALE)

    gerenciadorMapas:drawMap(gerenciadorMapas.mapaAtivo)
    player:draw()
end

function love.quit()
    love.window.close()
end
