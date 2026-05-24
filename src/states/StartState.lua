StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = love.graphics.newImage('graphics/ch_01.png')
    self.story = Story('narrative/part_01.json')
    self.currentStitchId = 'aTeacherYesThats'
    self.text = self.story:getStitchText(self.currentStitchId)
    self.options = self.story:getOptions(self.currentStitchId)
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
        self.text,
        TEXT_PANEL_X + PANEL_PADDING,
        PANEL_PADDING,
        TEXT_PANEL_WIDTH - PANEL_PADDING * 2,
        'left'
    )

    local optionsY = TEXT_PANEL_HEIGHT - PANEL_PADDING - (#self.options * 34)

    love.graphics.setColor(0.64, 0.6, 0.5, 1)
    for index, option in ipairs(self.options) do
        love.graphics.printf(
            index .. '. ' .. option.text,
            TEXT_PANEL_X + PANEL_PADDING,
            optionsY + (index - 1) * 34,
            TEXT_PANEL_WIDTH - PANEL_PADDING * 2,
            'left'
        )
    end
end
