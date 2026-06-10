Checkbox = Class{}

function Checkbox:init(params)
    self.x = params.x
    self.y = params.y
    self.size = params.size or 18
    self.label = params.label or ''
    self.labelWidth = params.labelWidth or 160
    self.getValue = params.getValue
    self.setValue = params.setValue
end

function Checkbox:render()
    love.graphics.setColor(0.92, 0.9, 0.84, 1)
    love.graphics.rectangle('line', self.x, self.y, self.size, self.size)

    if self:isChecked() then
        love.graphics.setLineWidth(2)
        love.graphics.line(
            self.x + 4,
            self.y + self.size / 2,
            self.x + self.size / 2 - 1,
            self.y + self.size - 4,
            self.x + self.size - 3,
            self.y + 4
        )
    end

    love.graphics.printf(
        self.label,
        self.x + self.size + 10,
        self.y - 1,
        self.labelWidth,
        'left'
    )
end

function Checkbox:mousepressed(x, y, button)
    if button ~= 1 or not self:isInside(x, y) then
        return false
    end

    self:setChecked(not self:isChecked())
    return true
end

function Checkbox:isChecked()
    if self.getValue then
        return self.getValue()
    end

    return false
end

function Checkbox:setChecked(value)
    if self.setValue then
        self.setValue(value)
    end
end

function Checkbox:isInside(x, y)
    return x >= self.x and x <= self.x + self.size
        and y >= self.y and y <= self.y + self.size
end

return Checkbox
