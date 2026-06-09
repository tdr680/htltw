require 'src/Dependencies'

function love.load()
    love.window.setTitle('HTLTW')

    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        highdpi = true
    })

    love.graphics.setDefaultFilter('nearest', 'nearest')

    gStateStack = StateStack()
    gStateStack:push(PlayState())
end

function love.update(dt)
    gStateStack:update(dt)
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end

function love.mousepressed(x, y, button)
    gStateStack:mousepressed(x, y, button)
end

function love.mousemoved(x, y)
    gStateStack:mousemoved(x, y)
end

function love.keypressed(key)
    gStateStack:keypressed(key)
end
