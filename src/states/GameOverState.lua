-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the game over state

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)

    self.score = params.score
    self.highscore = params.highscore

end

function GameOverState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        local heGotHighscore = false

        local highScoreIndex = 11

        for i = 10, 1, -1 do
           
            local scoreHere = self.highscore[i].score or 0

            if self.score > scoreHere then

                highScoreIndex = i
                heGotHighscore = true

            end
            
        end

        if heGotHighscore then

            gSounds['high-score']:play()

            gStateMachine:change('enter-high-score',{
                highscore = self.highscore,
                score = self.score,
                scoreIndex = highScoreIndex
            })

        else

            gStateMachine:change('start',{
                highscore = self.highscore
            })

        end
    
    end

    if love.keyboard.wasPressed('escape') then
    
        love.event.quit()
    
    end

end

function GameOverState:render()

    love.graphics.setFont(gFonts['large'])

    love.graphics.printf('GAME OVER..!', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter..!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

end