-- Author : Ahmed A. Khfagy
-- done in CS50 intorduction to game Design course

-- this is the class for the making of the level

LevelMaker = Class{}

function LevelMaker.creatMap(level)

    local bricks = {}

    local numRows = 0

    if level == 1 or level == 2 then
        numRows = 2
    elseif level == 3 or level == 4 then
        numRows = 4
    else
        numRows = 5
    end

    local numCols = math.random(7, 13)

    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    local highestTier = math.min(3, math.floor(level /5))

    local highestColor = math.min(5, level % 5 + 3)

    local maxNumOfPowerUps = math.random(3, 7)

    for y = 1, numRows do

        local skipPattern = math.random(1, 2) == 1 and true or false

        local alternatePattern = math.random(1, 2) == 1 and true or false

        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        local skipFlag = math.random(2) == 1 and true or false

        local alternateFlag = math.random(2) == 1 and true or false

        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(0, highestTier)

        for x = 1, numCols do

            if skipPattern and skipFlag then

                skipFlag = not skipFlag

                goto continue

            else

                skipFlag = not skipFlag

            end

            b = Brick((x - 1) * 32 + 8 + (13 - numCols) * 16, y * 16)

            if maxNumOfPowerUps > 0 then

                local toPutPowerUp = math.random(1, 2)

                if toPutPowerUp == 1 then
                    b.hasPowerup = true
                end

                maxNumOfPowerUps = maxNumOfPowerUps - 1

            end

            if alternatePattern and alternateFlag then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end 

            table.insert(bricks, b)

            ::continue::

        end

    end

    if #bricks == 0 then
        return self.createMap(level)
    else
        return bricks
    end

end