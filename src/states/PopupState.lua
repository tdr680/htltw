PopupState = Class{__includes = BaseState}

function PopupState:render()
    love.graphics.setColor(0, 0, 0, 0.55)
    love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

    love.graphics.setColor(0.1, 0.1, 0.11, 1)
    love.graphics.rectangle('fill', POPUP_X, POPUP_Y, POPUP_WIDTH, POPUP_HEIGHT)

    love.graphics.setColor(0.78, 0.72, 0.58, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', POPUP_X, POPUP_Y, POPUP_WIDTH, POPUP_HEIGHT)

    love.graphics.setColor(0.92, 0.9, 0.84, 1)
    love.graphics.printf(
        'Paused',
        POPUP_X + PANEL_PADDING,
        POPUP_Y + PANEL_PADDING,
        POPUP_WIDTH - PANEL_PADDING * 2,
        'center'
    )

    love.graphics.setColor(0.64, 0.6, 0.5, 1)
    love.graphics.printf(
        'Press Esc to return',
        POPUP_X + PANEL_PADDING,
        POPUP_Y + POPUP_HEIGHT - PANEL_PADDING * 2,
        POPUP_WIDTH - PANEL_PADDING * 2,
        'center'
    )
end

function PopupState:keypressed(key)
    if key == 'escape' then
        gStateStack:pop()
    end
end
