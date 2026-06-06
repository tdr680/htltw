Scene = Class{}

function Scene:init()
    self.images = {}
    self.currentImage = nil
end

function Scene:setStitch(stitchId)
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
end
