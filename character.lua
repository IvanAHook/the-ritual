character = class:new()

function character:init(world, x, y, object_type, userdata)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage("FFII_Beaver.png")
    self.grounded = false
    self.state = "idle"
    self.body = love.physics.newBody(world, level.charSpawnX-20/2, level.charSpawnY-20/2, "dynamic")
    self.shape = love.physics.newRectangleShape(20, 20)
    self.fixture = love.physics.newFixture(
                            self.body,
                            self.shape)
    self.fixture:setRestitution(0.0)
    self.fixture:setUserData(userdata)
    self.body:setFixedRotation(true)
end

function character:update(dt)
    velX, velY = self.body:getLinearVelocity()
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        self.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        self.body:applyForce(-100, 0)
    end
    if velX > 200 then
        self.body:setLinearVelocity(200, velY)
    end
    if velX < -200 then
        self.body:setLinearVelocity(-200, velY)
    end
end

function character:keypressed(key)
    if key == "j" then
        if self.grounded then
            self.body:applyLinearImpulse(0, -30)
            self.grounded = false
        end
    end
end

function character:keyreleased(key)
   if (key == "a" or  key == "d") and self.grounded == true then
         self.body:setLinearVelocity(0, 0)
    end
end

function character:draw()
    love.graphics.draw(self.image, self.body:getX()-10, self.body:getY()-10)
--    love.graphics.setColor(193, 47, 14)
--    love.graphics.polygon("fill", character.body:getWorldPoints(
--                                    character.shape:getPoints()))
end
