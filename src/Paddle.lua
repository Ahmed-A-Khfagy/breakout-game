-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the paddle object

Paddle = Class{}

function Paddle:init(skin)

    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 60

    self.dx = 0

    self.skin = skin
    
    self.size = 2
    
    self.width = 64
    self.height = 16

end

function Paddle:update(dt)

    if self.size == 1 then
        self.width = 32
    elseif self.size == 2 then
        self.width = 64
    elseif self.size == 3 then
        self.width = 96
    elseif self.size == 4 then
        self.width = 128
    end

    if love.keyboard.isDown('left') then

        self.dx = -PADDLE_SPEED

    elseif love.keyboard.isDown('right') then

        self.dx = PADDLE_SPEED

    else

        self.dx = 0

    end

    local movement = self.x + self.dx * dt

    if self.dx < 0 then

        self.x = math.max(0, movement)

    elseif(self.dx > 0) then

        self.x = math.min(VIRTUAL_WIDTH - self.width, movement)

    end

end

function Paddle:render()

    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin - 1)], self.x, self.y)

end