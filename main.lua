require 'src/Dependencies'

function love.load()
    love.window.setTitle('HTLTW')

    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        highdpi = true
    })

    love.graphics.setDefaultFilter('nearest', 'nearest')

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end
    }

    gStateMachine:change('start')
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
