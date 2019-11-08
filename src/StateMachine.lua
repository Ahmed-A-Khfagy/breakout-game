-- Author : Ahmed A. Khfagy
-- made in CS50 into to Game Development

-- this class represents the state machine

StateMachine = Class{}

function StateMachine:init(states)

    self.empty = {

        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end

    }

    self.states = states or {} -- [name] -> function that returns states, or {} initializes a variable if not given a value

    self.current = self.empty

end

function StateMachine:change(stateName, enterParams)

    self.current:exit()
    assert(self.states[stateName]) -- state must exist
    self.current = self.states[stateName]()
    self.current:enter(enterParams)

end

function StateMachine:update(dt)

    self.current:update(dt)

end

function StateMachine:render()

    self.current:render()

end