Scene = Class{}

function Scene:init()
    self.images = {}
    self.hotspots = Hotspots(HotspotData)
    self.currentStitchId = nil
    self.currentImage = nil
    self.hoveredHotspot = nil
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

    love.graphics.setColor(0.92, 0.78, 0.3, 0.22)
    love.graphics.rectangle(
        'fill',
        self.hoveredHotspot.x,
        self.hoveredHotspot.y,
        self.hoveredHotspot.width,
        self.hoveredHotspot.height
    )

    love.graphics.setColor(0.92, 0.78, 0.3, 0.85)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle(
        'line',
        self.hoveredHotspot.x,
        self.hoveredHotspot.y,
        self.hoveredHotspot.width,
        self.hoveredHotspot.height
    )
end
