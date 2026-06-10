ConsoleState = Class{__includes = BaseState}

function ConsoleState:init()
    self.developerCheckbox = Checkbox {
        x = CONSOLE_X + PANEL_PADDING,
        y = CONSOLE_Y + PANEL_PADDING * 3,
        size = CONSOLE_CHECKBOX_SIZE,
        label = 'Developer',
        labelWidth = CONSOLE_WIDTH - PANEL_PADDING * 2,
        getValue = function()
            return gDeveloper
        end,
        setValue = function(value)
            gDeveloper = value
        end
    }
end

function ConsoleState:render()
    love.graphics.setColor(0, 0, 0, 0.55)
    love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

    love.graphics.setColor(0.1, 0.1, 0.11, 1)
    love.graphics.rectangle('fill', CONSOLE_X, CONSOLE_Y, CONSOLE_WIDTH, CONSOLE_HEIGHT)

    love.graphics.setColor(0.78, 0.72, 0.58, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', CONSOLE_X, CONSOLE_Y, CONSOLE_WIDTH, CONSOLE_HEIGHT)

    love.graphics.setColor(0.92, 0.9, 0.84, 1)
    love.graphics.printf(
        'Console',
        CONSOLE_X + PANEL_PADDING,
        CONSOLE_Y + PANEL_PADDING,
        CONSOLE_WIDTH - PANEL_PADDING * 2,
        'center'
    )

    self.developerCheckbox:render()

    love.graphics.setColor(0.64, 0.6, 0.5, 1)
    love.graphics.printf(
        'Press Esc to return',
        CONSOLE_X + PANEL_PADDING,
        CONSOLE_Y + CONSOLE_HEIGHT - PANEL_PADDING * 2,
        CONSOLE_WIDTH - PANEL_PADDING * 2,
        'center'
    )
end

function ConsoleState:mousepressed(x, y, button)
    if self.developerCheckbox:mousepressed(x, y, button) then
        print('Developer mode: ' .. tostring(gDeveloper))
    end
end

function ConsoleState:keypressed(key)
    if key == 'escape' then
        gStateStack:pop()
    end
end
