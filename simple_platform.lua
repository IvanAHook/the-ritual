require('Platform')
require'Class'

simple_platform = class(Platform)
simple_platform_mt = {__index = simple_platform}

function simple_platform:new()
    local new_inst = {}
    setmetatable(new_inst, simple_platform_mt )
    return new_inst
end

function simple_platform:load()
    self.red = 30
    self.green = 30
    self.blue = 30
end

function simple_platform:draw()
    love.graphics.setColor(self.red, self.green, self.blue )
    Platform:draw()
end
