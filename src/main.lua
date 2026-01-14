local gerenciadorMapas = require("modules.maps")
local player = require("modules.player")
local Camera = require("utils.hump")
local cam = Camera()
local SCALE = 3

function love.load()
    love.window.setTitle("RogueLike")
    love.window.setFullscreen(true)


    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Carrega mapas
    gerenciadorMapas:loadTileSet("media/map/tiles")
    gerenciadorMapas.mapaAtivo = "start"

    cam:zoom(SCALE)
    player:load()
end 

function love.update(dt)
    dt = math.min(dt, 0.016)

    player:move(dt)
    player:update(dt)
	
    local px, py = player:returnPosition()
    cam:lookAt(px, py)
	
    local mapW, mapH = gerenciadorMapas:getMapSize(gerenciadorMapas.mapaAtivo)

    local screenW = love.graphics.getWidth() / cam.scale
    local screenH = love.graphics.getHeight() / cam.scale

    local halfW = screenW / 2
    local halfH = screenH / 2

    cam.x = math.max(halfW, math.min(cam.x, mapW - halfW))
    cam.y = math.max(halfH, math.min(cam.y, mapH - halfH))
	
end

function love.draw()
	cam:attach()
		gerenciadorMapas:drawMap(gerenciadorMapas.mapaAtivo)
		player:draw()
	cam:detach()
end

function love.quit()
    love.window.close()
end
