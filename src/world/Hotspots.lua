Hotspots = Class{}

function Hotspots:init(data)
    self.data = data or {}
end

function Hotspots:getForStitch(stitchId)
    return self.data[stitchId] or {}
end

function Hotspots:findAt(stitchId, x, y)
    for _, hotspot in ipairs(self:getForStitch(stitchId)) do
        if self:isInside(hotspot, x, y) then
            return hotspot
        end
    end

    return nil
end

function Hotspots:isInside(hotspot, x, y)
    if hotspot.shape ~= 'rect' then
        return false
    end

    return x >= hotspot.x and x <= hotspot.x + hotspot.width
        and y >= hotspot.y and y <= hotspot.y + hotspot.height
end
