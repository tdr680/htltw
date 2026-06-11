Button = Class{}

function Button:init(params)
    self.x = params.x
    self.y = params.y
    self.width = params.width
    self.height = params.height
    self.label = params.label or ''
    self.onClick = params.onClick
    self.isVisible = params.isVisible
    self.isEnabled = params.isEnabled
end

function Button:render()
    if not self:visible() then
        return
    end

    local enabled = self:enabled()

    if enabled then
        love.graphics.setColor(0.18, 0.17, 0.16, 1)
    else
        love.graphics.setColor(0.12, 0.12, 0.12, 1)
    end
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    if enabled then
        love.graphics.setColor(0.78, 0.72, 0.58, 1)
    else
        love.graphics.setColor(0.36, 0.34, 0.3, 1)
    end
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

    love.graphics.printf(
        self.label,
        self.x,
        self.y + 5,
        self.width,
        'center'
    )
end

function Button:mousepressed(x, y, button)
    if button ~= 1 or not self:visible() or not self:enabled() or not self:isInside(x, y) then
        return false
    end

    if self.onClick then
        self.onClick()
    end

    return true
end

function Button:visible()
    if self.isVisible then
        return self.isVisible()
    end

    return true
end

function Button:enabled()
    if self.isEnabled then
        return self.isEnabled()
    end

    return true
end

function Button:isInside(x, y)
    return x >= self.x and x <= self.x + self.width
        and y >= self.y and y <= self.y + self.height
end

return Button
