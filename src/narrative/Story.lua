Story = Class{}

function Story:init(path)
    self.path = path
    self.data = self:load(path)
end

function Story:load(path)
    local contents = love.filesystem.read(path)
    assert(contents, 'Could not read story file: ' .. tostring(path))

    return lunajson.decode(contents)
end

function Story:getInitialStitchId()
    return self.data.data.initial
end

function Story:getStitch(stitchId)
    local stitches = self.data.data.stitches
    local stitch = stitches[stitchId]

    assert(stitch, 'Story stitch does not exist: ' .. tostring(stitchId))

    return stitch
end

function Story:hasStitch(stitchId)
    return self.data.data.stitches[stitchId] ~= nil
end

function Story:getStitchText(stitchId)
    local stitch = self:getStitch(stitchId)
    local fragments = {}

    for _, item in ipairs(stitch.content) do
        if type(item) == 'string' then
            table.insert(fragments, item)
        end
    end

    return table.concat(fragments, '\n\n')
end

function Story:getOptions(stitchId)
    local stitch = self:getStitch(stitchId)
    local options = {}

    for _, item in ipairs(stitch.content) do
        if type(item) == 'table' and item.option then
            table.insert(options, {
                text = item.option,
                linkPath = item.linkPath
            })
        end
    end

    return options
end
