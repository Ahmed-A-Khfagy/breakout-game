-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the high score state

HighScoreState = Class{__includes = BasicState}

function HighScoreState:enter(params)

    self.highscore = params.highscore

end

function HighScoreState:update(dt)

    if love.keyboard.wasPressed('escape') then
        gSounds['wall-hit']:play()
        
        gStateMachine:change('start', {

            highscore = self.highscore

        })
    end

end

function HighScoreState:render()

    love.graphics.setFont(gFonts['large'])

    love.graphics.printf('High Scores', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    for i = 1, 10 do
        local name = self.highscore[i].name or '---'
        local score = self.highscore[i].score or '---'

        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4,  60 + i * 13, 50, 'left')

        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38,  60 + i * 13, 50, 'right')
        
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 13, 100, 'right')
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press Escape to return to the main menu..!", 0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')

end

function HighScoreState:exit() end