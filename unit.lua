unit = class:new()

function unit:spawn(world, x, y, object_type, userdata)
    self.body = love.physics.newBody(world, x, y, object_type)
    self.shape = love.physics.newRectangleShape(20, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(0.0)
    self.fixture:setUserData(userdata)
    self.body:setFixedRotation(true)
end

function unit:draw()
    love.graphics.draw(self.image, self.body:getX()-10, self.body:getY()-10)
end
