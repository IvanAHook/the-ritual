character = unit:new(...)

function character:init()
    self.image = love.graphics.newImage("assets/img/darkelf/DA_female1.png")
    self.controls_enabled = true
    self.width = 64
    self.height = 64

    self.anim = animation_loader.load('assets/img/darkelf/meta')
    self.curranim = self.anim['walkr']

    self.walkspeed = 200
    self.runspeed = 400
    self.grounded = false
    self.state = "idle"
    self.form = "human"
    self.direction = 0
end

function character:update(dt)
    if self.controls_enabled then
        if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
            if self.form == "human" then
                self:moveRight(400)
            elseif self.form ==  "ghost" then
                self:moveRight(100)
            end
            self.curranim = self.anim['walkr']
            self.state = "moving"
        end
        if love.keyboard.isDown("a") then
            if self.form == "human" then
                self:moveLeft(400)
            elseif self.form ==  "ghost" then
                self:moveLeft(100)
            end
            self.curranim = self.anim['walkl']
            self.state = "moving"
        end
        if love.keyboard.isDown("w") then
            if self.form == "human" then
            elseif self.form ==  "ghost" then
                self:moveUp(100)
            end
        end
        if love.keyboard.isDown("s") then
            if self.form == "human" then
            elseif self.form ==  "ghost" then
                self:moveDown(100)
            end
        end
        if love.keyboard.isDown("p") then
            self:death()
        end
    end
    self:limit_velocity()
    self.frame = self:compute_animation(self.curranim, self.state, dt)
    if self.direction ~= self:getDirection() then self.direction = self:getDirection() end -- solve this so that it does not need to be called here...
    self.state = "idle"

    if self.curranim == self.anim["walkl"] then
        self.look = -1
    else
        self.look = 1
    end
    if self.form == "ghost" then
        self.body:setLinearDamping(1)
    end
end

function character:keypressed(key)
    if self.controls_enabled then
        if key == "j" and self.form == "human" then
            if self.grounded then
                self.body:applyLinearImpulse(0, -120)
                self.grounded = false
            end
        end
    end
end

function character:keyreleased(key)
    if (key == "a" or  key == "d") and self.grounded == true then
        if self.form == "human" then
            self.body:setLinearVelocity(0, 0)
        end
    end
    if key == "k" then
        if self.form == "human" then
            self.form = "ghost"
            self.body:setGravityScale(0.01)
        elseif self.form == "ghost" then
            self.form = "human"
            self.body:setGravityScale(1)
        end
    end
end

function character:beginContact(a, b, coll) -- make so that a and b y pos is not in their respective centers
    local x, y = coll:getNormal()
    if b == self.fixture then -- this requires self to be added last in game.load
        if a:getBody():getY() > b:getBody():getY() then
            self.grounded = true
            if not (love.keyboard.isDown("d") or love.keyboard.isDown("a")) then
                self.body:setLinearVelocity(0, 0) -- fix stoping when landing
            end
        end
    end
end

function character:limit_velocity()
    local velX, velY = self.body:getLinearVelocity()
    if love.keyboard.isDown("lshift") then
        speed = self.runspeed
    else
        speed = self.walkspeed
    end
    if velX > speed then
        self.body:setLinearVelocity(speed, velY)
    end
    if velX < -speed then
        self.body:setLinearVelocity(-speed, velY)
    end
    if self.form == "ghost" then
        if velY > speed then
            self.body:setLinearVelocity(velX, speed)
        end
        if velY < -speed then
            self.body:setLinearVelocity(velX, -speed)
        end
    end
end
function character:death()
    --more death stuff
    self.state = 'moving'
    self.curranim = self.anim['death']
end
function character:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    self:draw_unit(self.image, self.curranim)
end
