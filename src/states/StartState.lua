StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = love.graphics.newImage('graphics/ch_01.png')
    self.title = 'HTLTW'
end

function StartState:render()
    love.graphics.clear(0.04, 0.04, 0.045, 1)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.background, 0, 0)

    love.graphics.setColor(0.08, 0.08, 0.09, 1)
    love.graphics.rectangle('fill', TEXT_PANEL_X, 0, TEXT_PANEL_WIDTH, TEXT_PANEL_HEIGHT)

    love.graphics.setColor(0.9, 0.86, 0.76, 1)
    love.graphics.setLineWidth(1)
    love.graphics.line(TEXT_PANEL_X, 0, TEXT_PANEL_X, TEXT_PANEL_HEIGHT)

    love.graphics.setColor(0.92, 0.9, 0.84, 1)
    love.graphics.printf(
        self.title,
        TEXT_PANEL_X + PANEL_PADDING,
        PANEL_PADDING,
        TEXT_PANEL_WIDTH - PANEL_PADDING * 2,
        'left'
    )
end
