--[[
    Dentro do fields tileset, temos que sao um total de 64 elementos, tendo em vista que sao
    8 colunas e 8 linhas. Cada elemento representa um tile, que sera referenciado no mapa
    ativo. O valor 0 representa o primeiro tile, o valor 1 representa o segundo
    tile, e assim por diante.
--]]

local TILE_SIZE = 32 -- correto seria 32
local TILESET_PATH = "media/map/tiles/"
local gerenciadorMapas = {
    TILE_SIZE = TILE_SIZE,
    mapaAtivo = nil,
    TILESET_PATH = TILESET_PATH,
    maps = {
        start = { 
            {0,5,3,9,0},
            {0,5,3,9,0},
            {0,5,3,9,0},
            {0,5,3,9,0},
            {0,5,3,9,0}
        }
    },
    tilesets = {}
}

function gerenciadorMapas:loadTileSet(path)
    local tileset = love.filesystem.getDirectoryItems(path)

    for i, file in ipairs(tileset) do 
        local tileImage = love.graphics.newImage(path .. "/" .. file)
        table.insert(self.tilesets, tileImage)
    end
end

function gerenciadorMapas:drawMap(map_name)
    local map = self.maps[map_name]
    for rowIndex, row in ipairs(map) do 
        for colIndex, tile in ipairs(row) do 
            local tileImage = self.tilesets[tile + 1]
            love.graphics.draw(tileImage, ((colIndex-1) * self.TILE_SIZE),((rowIndex-1) * self.TILE_SIZE))
        end
    end

end


return gerenciadorMapas