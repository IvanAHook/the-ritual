character = unit:new(...)

function character:init()
    self.image = love.graphics.newImage("assets/img/darkelf/DA_female1.png")
    self.width = 64
    self.height = 64
    self.anim = {}
    self.anim.walk_r = {love.graphics.newQuad( 0, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 64, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 128, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 192, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 256, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 320, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 384, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 448, 705, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 512, 705, self.width, self.height, 832, 1344 )}
    self.anim.walk_l = {love.graphics.newQuad( 0, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 64, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 128, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 192, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 256, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 320, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 384, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 448, 577, self.width, self.height, 832, 1344 ),
                        love.graphics.newQuad( 512, 577, self.width, self.height, 832, 1344 )}

    self.curranim = self.anim.walk_r

    self.maxspeed = 200
    self.grounded = false
    self.state = "idle"
    self.direction = 0
    self.frame = 1
end

function character:update(dt)
    velX, velY = self.body:getLinearVelocity()
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        self.body:applyForce(400, 0)
        self.curranim = self.anim.walk_r
        self.state = "moving"
    end
    if love.keyboard.isDown("a") then
        self.body:applyForce(-400, 0)
        self.curranim = self.anim.walk_l
        self.state = "moving"
    end
    if velX > self.maxspeed then
        self.body:setLinearVelocity(self.maxspeed, velY)
    end
    if velX < -self.maxspeed then
        self.body:setLinearVelocity(-self.maxspeed, velY)
    end
    self.frame = self:compute_animation(self.curranim, self.state, dt)
    self.direction = self:getDirection()
    self.state = "idle"
end

function character:keypressed(key)
    if key == "j" then
        if self.grounded then
            self.body:applyLinearImpulse(0, -160)
            self.grounded = false
            self.state = "moving"
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
--    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
--    love.graphics.draw(self.image, self.curranim[self.frame], self.body:getX()-self.width/2, self.body:getY()-self.height/2-1)
    self:draw_unit(self.image, self.curranim)
--    love.graphics.draw(self.image, self.body:getX()-24, self.body:getY()-24)
--    love.graphics.setColor(193, 47, 14)
end
