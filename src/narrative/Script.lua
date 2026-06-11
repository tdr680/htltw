Script = Class{}

function Script:init(path, hotspotData)
    self.story = Story(path)
    self.hotspotData = hotspotData or {}
    self.currentStitchId = nil
    self.text = ''
    self.options = {}
    self.optionBounds = {}
    self.history = {}
    self.changedByBackButton = false
    self.backButton = Button {
        x = WINDOW_WIDTH - PANEL_PADDING - SCRIPT_BACK_BUTTON_WIDTH,
        y = TEXT_PANEL_HEIGHT - PANEL_PADDING - SCRIPT_BACK_BUTTON_HEIGHT,
        width = SCRIPT_BACK_BUTTON_WIDTH,
        height = SCRIPT_BACK_BUTTON_HEIGHT,
        label = 'Back',
        isVisible = function()
            return gDeveloper
        end,
        isEnabled = function()
            return self:canGoBack()
        end,
        onClick = function()
            self.changedByBackButton = self:goBack()
        end
    }

    self:setStitch(self.story:getInitialStitchId())
end

function Script:setStitch(stitchId)
    if not self.story:hasStitch(stitchId) then
        return false
    end

    if self.currentStitchId and self.currentStitchId ~= stitchId then
        table.insert(self.history, self.currentStitchId)
    end

    self:loadStitch(stitchId)

    return true
end

function Script:loadStitch(stitchId)
    self.currentStitchId = stitchId
    self.text = self.story:getStitchText(stitchId)
    self.options = self.story:getOptions(stitchId)
    self.optionBounds = {}
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
    self.backButton:render()
end

function Script:renderOptions()
    local optionHeight = 34
    local options = self:getVisibleOptions()
    local developerOffset = 0
    if gDeveloper then
        developerOffset = SCRIPT_BACK_BUTTON_HEIGHT + 10
    end

    local optionsY = TEXT_PANEL_HEIGHT - PANEL_PADDING - developerOffset - (#options * optionHeight)
    self.optionBounds = {}

    love.graphics.setColor(0.64, 0.6, 0.5, 1)
    for index, option in ipairs(options) do
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

    self.changedByBackButton = false
    if self.backButton:mousepressed(x, y, button) then
        return self.changedByBackButton
    end

    local options = self:getVisibleOptions()
    for index, bounds in ipairs(self.optionBounds) do
        local option = options[index]

        if option and self:isInsideBounds(x, y, bounds) then
            return self:setStitch(option.linkPath)
        end
    end

    return false
end

function Script:goToStitch(stitchId)
    return self:setStitch(stitchId)
end

function Script:getVisibleOptions()
    if gDeveloper then
        return self.options
    end

    local hiddenTargets = self:getHotspotStitchTargets()
    local options = {}

    for _, option in ipairs(self.options) do
        if not hiddenTargets[option.linkPath] then
            table.insert(options, option)
        end
    end

    return options
end

function Script:getHotspotStitchTargets()
    local targets = {}
    local hotspots = self.hotspotData[self.currentStitchId] or {}

    for _, hotspot in ipairs(hotspots) do
        if hotspot.action == 'stitch' and hotspot.target then
            targets[hotspot.target] = true
        end
    end

    return targets
end

function Script:getOptionTextForTarget(target)
    for _, option in ipairs(self.options) do
        if option.linkPath == target then
            return option.text
        end
    end

    return nil
end

function Script:canGoBack()
    return #self.history > 0
end

function Script:goBack()
    if not self:canGoBack() then
        return false
    end

    local previousStitchId = table.remove(self.history)
    self:loadStitch(previousStitchId)

    return true
end

function Script:isInsideBounds(x, y, bounds)
    return x >= bounds.x and x <= bounds.x + bounds.width
        and y >= bounds.y and y <= bounds.y + bounds.height
end
