Label = Class{}

function Label:init(params)
    params = params or {}

    self.x = params.x or 0
    self.y = params.y or 0
    self.width = params.width or 0
    self.height = params.height or 0
    self.text = params.text or ''
    self.padding = params.padding or 6
    self.align = params.align or 'left'
    self.backgroundColor = params.backgroundColor or {0.04, 0.04, 0.045, 0.78}
    self.textColor = params.textColor or {0.92, 0.9, 0.84, 1}
end

function Label:setText(text)
    self.text = text or ''
end

function Label:setBounds(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Label:render()
    if self.text == '' then
        return
    end

    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.textColor)
    love.graphics.printf(
        self.text,
        self.x + self.padding,
        self.y + self.padding + 1,
        self.width - self.padding * 2,
        self.align
    )
end

return Label
