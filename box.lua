box = World_object:new()

function box:init()
    self.red = 255
    self.green = 255
    self.blue = 255
    self.image = love.graphics.newImage("assets/img/crate.jpg")
end

function box:draw()
    love.graphics.setColor( self.red, self.green, self.blue )
    love.graphics.draw( self.image, self.body:getX()-10, self.body:getY()-10 )
end
