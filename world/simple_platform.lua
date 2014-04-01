require'world/Platform'

simple_platform = Platform:new()

function simple_platform:init()
    self.red = 120
    self.green = 100
    self.blue = 100
    self.image = love.graphics.newImage("assets/img/bricks.jpg")
end

function simple_platform:draw()
    local w = self.width
    local img_w = self.image:getWidth()
    love.graphics.setColor( self.red, self.green, self.blue )
    if w > img_w and w%img_w == 0 then
        local tiles = w/img_w
        for offset=0, tiles-1 do
            love.graphics.draw( self.image, self.body:getX()+(offset*img_w), self.body:getY(), self.body:getAngle(),
                                1, 1, w/2, self.image:getHeight()/2 )
        end
    else
        love.graphics.draw( self.image, self.body:getX(), self.body:getY(), self.body:getAngle(),
                            1, 1, self.image:getWidth()/2, self.image:getHeight()/2 )
    end
end
