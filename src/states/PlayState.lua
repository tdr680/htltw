PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.story = Story('narrative/part_01.json')
    self.scene = Scene()
    self.optionBounds = {}

    self:setStitch('aTeacherYesThats')
end

function PlayState:setStitch(stitchId)
    self.currentStitchId = stitchId
    self.text = self.story:getStitchText(self.currentStitchId)
    self.options = self.story:getOptions(self.currentStitchId)
    self.scene:setStitch(self.currentStitchId)
end

function PlayState:render()
    love.graphics.clear(0.04, 0.04, 0.045, 1)

    self.scene:render()

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

    local optionHeight = 34
    local optionsY = TEXT_PANEL_HEIGHT - PANEL_PADDING - (#self.options * optionHeight)
    self.optionBounds = {}

    love.graphics.setColor(0.64, 0.6, 0.5, 1)
    for index, option in ipairs(self.options) do
        local optionX = TEXT_PANEL_X + PANEL_PADDING
        local optionY = optionsY + (index - 1) * optionHeight
        local optionWidth = TEXT_PANEL_WIDTH - PANEL_PADDING * 2

        self.optionBounds[index] = {
            x = optionX,
            y = optionY,
            width = optionWidth,
            height = optionHeight
        }

        love.graphics.printf(
            index .. '. ' .. option.text,
            optionX,
            optionY,
            optionWidth,
            'left'
        )
    end
end

function PlayState:mousepressed(x, y, button)
    if button ~= 1 then
        return
    end

    for index, bounds in ipairs(self.optionBounds) do
        local option = self.options[index]

        if option and self:isInsideBounds(x, y, bounds) then
            self:setStitch(option.linkPath)
            return
        end
    end
end

function PlayState:isInsideBounds(x, y, bounds)
    return x >= bounds.x and x <= bounds.x + bounds.width
        and y >= bounds.y and y <= bounds.y + bounds.height
end
