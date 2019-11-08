-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the play state

PlayState = Class{__includes = BasicState}

math.randomseed(os.time())

function PlayState:enter(params)

    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.level = params.level
    self.highscore = params.highscore
    self.powerUps = params.powerUps

    self.paused = false

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

end

function PlayState:update(dt)

    if self.paused then

        if love.keyboard.wasPressed('space') then

            self.paused = false
            gSounds['pause']:play()

        else
            return
        end

    elseif love.keyboard.wasPressed('space') then

        self.paused = true
        gSounds['pause']:play()

        return

    end

    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then

        
        if self.ball.y < self.paddle.y + (self.paddle.height / 2) - 6 then

            self.ball.dy = -self.ball.dy

            self.ball.y = self.paddle.y - 8

            if self.ball.x < (self.paddle.x) + (self.paddle.width / 2) and self.paddle.dx < 0 then

                self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
    
            elseif math.floor(self.ball.x) > math.floor(self.paddle.x) + (self.paddle.width / 2) and self.paddle.dx > 0 then
    
                self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
    
            end

        else

            self.ball.y = self.paddle.y + self.paddle.height

            if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then

                self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
    
            elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
    
                self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
    
            end

        end

       

        gSounds['paddle-hit']:play()

    end

    for i, brick in pairs(self.bricks) do

        if brick.inPlay and self.ball:collides(brick) then

            self.score = self.score + (brick.tier * 200 + brick.color * 25)

            if self.score < 2500 and self.score >= 1000 then
                if self.ball.skin == 1 then
                    self.ball.skin = 2
                    gSounds['change-ball']:play()
                end
            elseif self.score < 5000 then
                if self.ball.skin == 2 then
                    self.ball.skin = 3
                    gSounds['change-ball']:play()
                end
            elseif self.score < 7500 then
                if self.ball.skin == 3 then
                    self.ball.skin = 4
                    gSounds['change-ball']:play()
                end
            elseif self.score < 10000 then
                if self.ball.skin == 4 then
                    self.ball.skin = 5
                    gSounds['change-ball']:play()
                end
            elseif self.score < 12500 then
                if self.ball.skin == 5 then
                    self.ball.skin = 6
                    gSounds['change-ball']:play()
                end
            elseif self.score > 12500 then
                if self.ball.skin == 6 then
                    self.ball.skin = 7
                    gSounds['change-ball']:play()
                end
            end

            brick:hit()

            if self:checkVectory() then

                gSounds['victory']:play()
        
                gStateMachine:change('victory',{
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    ball = self.ball,
                    highscore = self.highscore
                })
        
            end

            if not self.ball.inPlay and self.ball.hasPowerup then

            end
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then

                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8

            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then

                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32

            elseif self.ball.y < brick.y then

                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8

            else 

                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16

            end

            self.ball.dy = self.ball.dy - 1.02

        end

    end

    if self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highscore = self.highscore
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                level = self.level,
                highscore = self.highscore,
                powerUps = self.powerUps,
                ball = self.ball
            })
        end
    end

    for k, brick in pairs(self.bricks) do

        brick:update(dt)
    
    end

    if love.keyboard.wasPressed('escape') then

        love.event.quit()

    end

end

function PlayState:checkVectory()

    for i, brick in pairs(self.bricks) do

        if brick.inPlay then
            return false
        end

    end

    return true

end

function PlayState:render()

    for i, brick in pairs(self.bricks) do

        brick:render()

    end

    for k, brick in pairs(self.bricks) do

        brick:renderParticles()
    
    end


    self.paddle:render()
    self.ball:render()
    
    renderScore(self.score)
    renderHealth(self.health)

    if self.paused then 

        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED!!", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    end

end

function PlayState:exit() end