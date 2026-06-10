PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.scene = Scene()
    self.script = Script('narrative/part_01.json')

    self:syncScene()
end

function PlayState:render()
    love.graphics.clear(0.04, 0.04, 0.045, 1)

    self.scene:render()
    self.script:render()
end

function PlayState:mousepressed(x, y, button)
    if button ~= 1 then
        return
    end

    local hotspot = self.scene:mousepressed(x, y, button)

    if hotspot then
        print('Hotspot clicked: ' .. hotspot.id .. ' -> ' .. hotspot.action .. ':' .. tostring(hotspot.target))
        self:handleHotspot(hotspot)
        return
    end

    if self.script:mousepressed(x, y, button) then
        self:syncScene()
    end
end

function PlayState:mousemoved(x, y)
    self.scene:mousemoved(x, y)
end

function PlayState:handleHotspot(hotspot)
    if hotspot.action == 'stitch' and self.script:goToStitch(hotspot.target) then
        self:syncScene()
    end
end

function PlayState:keypressed(key)
    if key == 'escape' then
        gStateStack:push(PopupState())
    end
end

function PlayState:syncScene()
    self.scene:setStitch(self.script:getCurrentStitchId())
end
