StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    if #self.states > 0 then
        self.states[#self.states]:update(dt)
    end
end

function StateStack:render()
    for _, state in ipairs(self.states) do
        state:render()
    end
end

function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:pop()
    if #self.states == 0 then
        return
    end

    self.states[#self.states]:exit()
    table.remove(self.states)
end

function StateStack:clear()
    self.states = {}
end

function StateStack:mousepressed(x, y, button)
    if #self.states > 0 then
        self.states[#self.states]:mousepressed(x, y, button)
    end
end

function StateStack:keypressed(key)
    if #self.states > 0 then
        self.states[#self.states]:keypressed(key)
    end
end
