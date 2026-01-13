local anim8 = require("utils.anim8")
local player = {
	position = {
		x = 100,
		y = 100
	},
	speed = 100,
	state = "idle",
	direction = "down",
	animations = {},
	currentAnimation = nil,
	image = nil,
	scaleX = 1 

}

function player:load()
    -- Carrega a imagem
    self.images = {
        idle = love.graphics.newImage("media/player/idle_with_shadow.png"),
        walk = love.graphics.newImage("media/player/walk_with_shadow.png")
    }

    -- Grids
    local idleGrid = anim8.newGrid(
        64, 64,
        self.images.idle:getWidth(),
        self.images.idle:getHeight()
    )

    local walkGrid = anim8.newGrid(
        64, 64,
        self.images.walk:getWidth(),
        self.images.walk:getHeight()
    )

    -- Cria animações
    self.animations = {
        idle = {
			up    = anim8.newAnimation(idleGrid("1-4", 4), 0.2),
			left  = anim8.newAnimation(idleGrid("1-5", 2), 0.2),
			right = anim8.newAnimation(idleGrid("1-5", 3), 0.2),
			down  = anim8.newAnimation(idleGrid("1-5", 1), 0.2)
		},
		walk = {
			up    = anim8.newAnimation(walkGrid("1-5", 4), 0.2),
			left  = anim8.newAnimation(walkGrid("1-5", 2), 0.2),
			right = anim8.newAnimation(walkGrid("1-5", 3), 0.2),
			down  = anim8.newAnimation(walkGrid("1-5", 1), 0.2)
		}
	}

    self.currentAnimation = self.animations.idle.down
end

function player:move(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown("a", "left") then dx = dx - 1 end
    if love.keyboard.isDown("d", "right") then dx = dx + 1 end
    if love.keyboard.isDown("w", "up") then dy = dy - 1 end
    if love.keyboard.isDown("s", "down") then dy = dy + 1 end

    local length = math.sqrt(dx * dx + dy * dy)

    if length > 0 then
        dx, dy = dx / length, dy / length
        self.state = "walk"

        if dx < 0 then self.direction = "left" end
        if dx > 0 then self.direction = "right" end
        if dy < 0 then self.direction = "up" end
        if dy > 0 then self.direction = "down" end
    else
        self.state = "idle"
    end

    self.currentAnimation =
        self.animations[self.state][self.direction]

    self.position.x = self.position.x + dx * self.speed * dt
    self.position.y = self.position.y + dy * self.speed * dt
end

function player:update(dt)
    self.currentAnimation:update(dt)
end

function player:draw()
	self.currentAnimation:draw(
		self.images[self.state],
		self.position.x,
		self.position.y,
		0,
		self.scaleX,
		1,
		64,
		64
	)
end

return player