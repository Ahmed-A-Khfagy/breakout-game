-- Author : Ahmed A. Khfagy
-- Made in CS50 introduction to game development course

-- this class is the serving state of the game

ServeState = Class{__includes = BasicState}

function ServeState:enter(params)

    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.level = params.level
    self.highscore = params.highscore

    self.powerUps = params.powerUps

    self.ball = params.ball

    if self.score == 0 then
        self.ball.skin = 1

    elseif self.score < 2500 and self.score >= 1000 then
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

end

function ServeState:update(dt)

    if self.health == 2 then
        self.paddle.size = 3
    elseif self.health == 1 then
        self.paddle.size = 4
    end

    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball,
            level = self.level,
            highscore = self.highscore,
            powerUps = self.powerUps
        })

    end

    if love.keyboard.wasPressed('escape') then

        love.event.quit()

    end

end

function ServeState:render()

    self.paddle:render()
    self.ball:render()

    for i, brick in pairs(self.bricks) do

        brick:render()

    end

    renderScore(self.score)
    renderHealth(self.health)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve..!', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

end

function ServeState:exit() end