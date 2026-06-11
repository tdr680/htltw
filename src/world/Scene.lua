Scene = Class{}

function Scene:init()
    self.images = {}
    self.hotspots = Hotspots(HotspotData)
    self.currentStitchId = nil
    self.currentImage = nil
    self.hoveredHotspot = nil
    self.hotspotLabelProvider = nil
    self.hotspotLabel = Label()
end

function Scene:setHotspotLabelProvider(provider)
    self.hotspotLabelProvider = provider
end

function Scene:setStitch(stitchId)
    self.currentStitchId = stitchId
    self.hoveredHotspot = nil
    local path = 'graphics/' .. stitchId .. '.png'

    if not love.filesystem.getInfo(path) then
        self.currentImage = nil
        return
    end

    if not self.images[path] then
        self.images[path] = love.graphics.newImage(path)
    end

    self.currentImage = self.images[path]
end

function Scene:render()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, STAGE_WIDTH, STAGE_HEIGHT)

    if not self.currentImage then
        return
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.currentImage, 0, 0)

    self:renderHoveredHotspot()
end

function Scene:mousepressed(x, y, button)
    if button ~= 1 or not self.currentStitchId then
        return nil
    end

    if x < 0 or x > STAGE_WIDTH or y < 0 or y > STAGE_HEIGHT then
        return nil
    end

    return self.hotspots:findAt(self.currentStitchId, x, y)
end

function Scene:mousemoved(x, y)
    if not self.currentStitchId or x < 0 or x > STAGE_WIDTH or y < 0 or y > STAGE_HEIGHT then
        self.hoveredHotspot = nil
        return
    end

    self.hoveredHotspot = self.hotspots:findAt(self.currentStitchId, x, y)
end

function Scene:renderHoveredHotspot()
    if not self.hoveredHotspot then
        return
    end

    local fillColor, lineColor = self:getHotspotColors(self.hoveredHotspot)

    love.graphics.setColor(fillColor)
    love.graphics.rectangle(
        'fill',
        self.hoveredHotspot.x,
        self.hoveredHotspot.y,
        self.hoveredHotspot.width,
        self.hoveredHotspot.height
    )

    love.graphics.setColor(lineColor)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle(
        'line',
        self.hoveredHotspot.x,
        self.hoveredHotspot.y,
        self.hoveredHotspot.width,
        self.hoveredHotspot.height
    )

    self:renderHoveredHotspotLabel()
end

function Scene:getHotspotColors(hotspot)
    if hotspot.action == 'game' then
        return {0.28, 0.72, 0.95, 0.22}, {0.28, 0.72, 0.95, 0.85}
    end

    return {0.92, 0.78, 0.3, 0.22}, {0.92, 0.78, 0.3, 0.85}
end

function Scene:renderHoveredHotspotLabel()
    if not self.hotspotLabelProvider then
        return
    end

    local label = self.hotspotLabelProvider(self.hoveredHotspot)

    if not label or label == '' then
        return
    end

    self.hotspotLabel:setText(label)
    self.hotspotLabel:setBounds(
        self.hoveredHotspot.x,
        self.hoveredHotspot.y,
        self.hoveredHotspot.width,
        math.min(34, self.hoveredHotspot.height)
    )
    self.hotspotLabel:render()
end
