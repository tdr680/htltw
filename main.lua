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
        ['play'] = function() return PlayState() end
    }

    gStateMachine:change('play')
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end

function love.mousepressed(x, y, button)
    gStateMachine:mousepressed(x, y, button)
end
