-- Author : Ahmed A. Khfagy
-- Made in CS50 introduction to game development course

-- this class is the starting state of the game

StartState = Class{__includes = BasicState}

local highlighted = 1

function StartState:enter(params) 

    self.highscore = params.highscore

end

function StartState:init()

    self.level = 1

end

function StartState:update(dt)

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then

        highlighted = highlighted == 1 and 2 or 1

        gSounds['paddle-hit']:play()

    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gSounds['confirm']:play()

        if highlighted == 1 then

            gStateMachine:change('select-paddle', {
                highscore = self.highscore
            })

        elseif highlighted == 2 then 


            gStateMachine:change('high-score',{
                highscore = self.highscore
            })

        end

    end

    if love.keyboard.wasPressed('escape') then

        love.event.quit()

    end

end

function StartState:render()

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['large'])

    love.graphics.printf("Ball hit thingie!", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    if highlighted == 1 then

        love.graphics.setColor(103 / 255, 1, 1, 1)

    end

    love.graphics.printf("START!", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then

        love.graphics.setColor(103 / 255, 1, 1, 1)

    end

    love.graphics.printf("Height Scores!", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

end

function StartState:exit() end