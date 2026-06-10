Script = Class{}

function Script:init(path)
    self.story = Story(path)
    self.currentStitchId = nil
    self.text = ''
    self.options = {}
    self.optionBounds = {}

    self:setStitch(self.story:getInitialStitchId())
end

function Script:setStitch(stitchId)
    if not self.story:hasStitch(stitchId) then
        return false
    end

    self.currentStitchId = stitchId
    self.text = self.story:getStitchText(stitchId)
    self.options = self.story:getOptions(stitchId)
    self.optionBounds = {}

    return true
end

function Script:getCurrentStitchId()
    return self.currentStitchId
end

function Script:render()
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

    self:renderOptions()
end

function Script:renderOptions()
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

function Script:mousepressed(x, y, button)
    if button ~= 1 then
        return false
    end

    for index, bounds in ipairs(self.optionBounds) do
        local option = self.options[index]

        if option and self:isInsideBounds(x, y, bounds) then
            return self:setStitch(option.linkPath)
        end
    end

    return false
end

function Script:goToStitch(stitchId)
    return self:setStitch(stitchId)
end

function Script:isInsideBounds(x, y, bounds)
    return x >= bounds.x and x <= bounds.x + bounds.width
        and y >= bounds.y and y <= bounds.y + bounds.height
end
