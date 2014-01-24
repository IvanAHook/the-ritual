character = unit:new(...)

function character:init()
    self.image = love.graphics.newImage("FFII_Beaver.png")
    self.maxspeed = 200
    self.grounded = false
    self.state = "idle"
    self.direction = 0
end

function character:update(dt)
    velX, velY = self.body:getLinearVelocity()
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        self.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        self.body:applyForce(-100, 0)
    end
    if velX > self.maxspeed then
        self.body:setLinearVelocity(self.maxspeed, velY)
    end
    if velX < -self.maxspeed then
        self.body:setLinearVelocity(-self.maxspeed, velY)
    end
    self.movekeydown = false
    self.direction = unit:getDirection()
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

function character:beginContact(a, b, coll)
    local x, y = coll:getNormal()
    if b == self.fixture then -- this requires self to be added last in game.load
        if a:getBody():getY() > b:getBody():getY() then
            self.grounded = true
            self.body:setLinearVelocity(0, 0) -- fix stoping when landing
        end
    end
end

function character:draw()
     love.graphics.draw(self.image, self.body:getX()-10, self.body:getY()-10)
--    love.graphics.setColor(193, 47, 14)
--    love.graphics.polygon("fill", self.body:getWorldPoints(
--                                    self.shape:getPoints()))
end
