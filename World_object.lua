World_object = class:new()

function World_object:spawn(world,x,y,width,height,body_type)
    --print(x,y,width,height)
    self.body = love.physics.newBody(world, x+width/2, y+height/2,body_type)
    self.shape = love.physics.newRectangleShape(width,height)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData("World_object")
end

function World_object:draw()
    love.graphics.setColor(self.red, self.green, self.blue ) 
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
