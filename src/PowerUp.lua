-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the power up object

PowerUp = Class{}

local GRAVITY = 10

function PowerUp:init(x, y, skin)

    self.x = x
    self.y = y
    self.skin = skin
    self.startFadding = false

end

function PowerUp:collides(target)

    -- AABB collision detection

    if self.x > target.x + target.width or target.x > self.x + 16 then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + 16 then
        return false
    end

    return true

end

function PowerUp:update(dt)

    if not self.startFadding then
        self.y = self.y + GRAVITY * dt
    end

end

function PowerUp:render()

    love.graphics.draw(gTextures['main'], gFrames['power-ups'][self.skin], self.x, self.y)

end