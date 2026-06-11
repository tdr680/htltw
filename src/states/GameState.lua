GameState = Class{__includes = BaseState}

function GameState:render()
    love.graphics.setColor(0, 0, 0, 0.55)
    love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

    love.graphics.setColor(0.1, 0.1, 0.11, 1)
    love.graphics.rectangle('fill', CONSOLE_X, CONSOLE_Y, CONSOLE_WIDTH, CONSOLE_HEIGHT)

    love.graphics.setColor(0.78, 0.72, 0.58, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', CONSOLE_X, CONSOLE_Y, CONSOLE_WIDTH, CONSOLE_HEIGHT)
end

function GameState:keypressed(key)
    if key == 'escape' then
        gStateStack:pop()
    end
end
