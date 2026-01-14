--[[
    Dentro do fields tileset, temos que sao um total de 64 elementos, tendo em vista que sao
    8 colunas e 8 linhas. Cada elemento representa um tile, que sera referenciado no mapa
    ativo. O valor 0 representa o primeiro tile, o valor 1 representa o segundo
    tile, e assim por diante.
--]]

local TILE_SIZE = 32 -- correto seria 32
local MAP_TILE_PATH = "media/map/tiles/"

local maps_object = require("media.map.tileset.tilesets")
local gerenciadorMapas = {
    TILE_SIZE = TILE_SIZE,
    mapaAtivo = nil,
    MAP_TILE_PATH = MAP_TILE_PATH,
    maps = maps_object,
    tilesets = {}
}

function gerenciadorMapas:loadTileSet(path)
    local tileset = love.filesystem.getDirectoryItems(path)

    for i, file in ipairs(tileset) do 
        local tileImage = love.graphics.newImage(path .. "/" .. file)
        table.insert(self.tilesets, tileImage)
    end
end

function gerenciadorMapas:drawMapLayer(layer)
    for rowIndex, row in ipairs(layer.data) do
        for colIndex, tileIndex in ipairs(row) do
            local tileImage = self.tilesets[tileIndex + 1]
            if tileImage then
                love.graphics.draw(
                    tileImage,
                    (colIndex - 1) * self.TILE_SIZE,
                    (rowIndex - 1) * self.TILE_SIZE
                )
            end
        end
    end
end

function gerenciadorMapas:drawMap(mapName)
	local map = self.maps[mapName]
	if not map or not self.maps[mapName] then return end

	table.sort(map.layers, 
		function(a, b) 
			return a.priority < b.priority
		end
	)
	for _, layer in ipairs(map.layers) do 
		self:drawMapLayer(layer)
	end
end

function gerenciadorMapas:getMapSize(mapName)
    local map = self.maps[mapName]
    if not map then return 0, 0 end

    local layer = map.layers[1]
    local rows = #layer.data
    local cols = #layer.data[1]

    return cols * self.TILE_SIZE, rows * self.TILE_SIZE
end



return gerenciadorMapas