unit = class:new()

function unit:spawn(world, x, y, object_type, userdata)
    self.body = love.physics.newBody(world, x, y, object_type)
    self.shape = love.physics.newRectangleShape(20, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(0.0)
    self.fixture:setUserData(userdata)
    self.body:setFixedRotation(true)

    self.lastx, self.lasty = x, y
end

function unit:getDirection() -- not working
    if self.body then
        local x, y = self.body:getPosition()
        local direction
        if x > self.lastx then
            direction = 1
            print(1)
        elseif x < self.lastx then
            direction = -1
            print(2)
        elseif x == self.lastx then
            direction = 0
            print(3)
        end
        self.lastx, self.lasty = x, y
        return direction
    end
end

function unit:draw()
    love.graphics.draw(self.image, self.body:getX()-10, self.body:getY()-10)
end
