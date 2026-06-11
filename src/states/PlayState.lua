PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.scene = Scene()
    self.script = Script('narrative/part_01.json', HotspotData)
    self.scene:setHotspotLabelProvider(function(hotspot)
        if hotspot.action == 'stitch' then
            return self.script:getOptionTextForTarget(hotspot.target)
        elseif hotspot.action == 'game' then
            return hotspot.target
        end

        return nil
    end)

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
        print(
            'Hotspot clicked: ' .. hotspot.id
            .. ' -> ' .. hotspot.action .. ':' .. tostring(hotspot.target)
            .. ' at x=' .. tostring(hotspot.x)
            .. ', y=' .. tostring(hotspot.y)
            .. ', width=' .. tostring(hotspot.width)
            .. ', height=' .. tostring(hotspot.height)
        )
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
    elseif hotspot.action == 'game' then
        self:pushGame(hotspot.target)
    end
end

function PlayState:pushGame(gameName)
    local gameClass = _G[gameName]

    if not gameClass then
        print('Game not found: ' .. tostring(gameName))
        return
    end

    gStateStack:push(gameClass())
end

function PlayState:keypressed(key)
    if key == 'escape' then
        gStateStack:push(ConsoleState())
    end
end

function PlayState:syncScene()
    self.scene:setStitch(self.script:getCurrentStitchId())
end
