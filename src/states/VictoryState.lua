-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the victory state

VictoryState = Class{__includes = BasicState}

function VictoryState:enter(params)

    self.level = params.level
    self.score = params.score
    self.paddle = params.paddle
    self.health = params.health
    self.ball = params.ball
    self.highscore = params.highscore
    self.addLevel = false
    self.addedHealth = false

end

function VictoryState:update(dt)

    if self.health < 3 then
        self.addLevel = true

        if self.addedHealth == false then
            self.health = self.health + 1
            self.addedHealth = not self.addedHealth

            if self.health == 2 then
                self.paddle.size = 3
            elseif self.health == 3 then
                self.paddle.size = 2
            end

        end

    elseif self.health == 3 and self.addedHealth == false then
        self.paddle.size = 1
    end

    self.paddle:update(dt)

    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gStateMachine:change('serve', {
            level = self.level + 1,
            bricks = LevelMaker.creatMap(self.level + 1),
            paddle = self.paddle,
            health = self.health,
            score = self.score,
            highscore = self.highscore,
            ball = self.ball
        })

    end

end

function VictoryState:render()

    self.paddle:render()
    self.ball:render()

    renderHealth(self.health)
    renderScore(self.score)

    if self.addLevel then
        love.graphics.setFont(gFonts['small'])
        love.graphics.print("Added Life..!!", VIRTUAL_WIDTH - 89, 15)
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Level " .. tostring(self.level) .. " complete..!", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to go to the next level..!', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

end

function VictoryState:exit() end