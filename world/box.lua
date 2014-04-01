box = World_object:new()

function box:init()
    self.red = 255
    self.green = 255
    self.blue = 255
    self.image = love.graphics.newImage("assets/img/crate.jpg")
end

function box:draw()
    love.graphics.setColor( self.red, self.green, self.blue )
    love.graphics.draw( self.image, self.body:getX(), self.body:getY(), self.body:getAngle(),
                        1, 1, self.image:getWidth()/2, self.image:getHeight()/2 )
end
