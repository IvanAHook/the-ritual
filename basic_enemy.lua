basic_enemy = unit:new(...)

function basic_enemy:init()
    self.image = love.graphics.newImage("assets/img/darkelf/DA_male1.png")
    self.anim = animation_loader.load('assets/img/darkelf/DA_male1_meta')
    self.curranim = self.anim['walkl']
    self.state = 'idle'
    self.walkspeed = 100
    self.awareness = 300
end

function basic_enemy:move(dir)
    self.state = 'moving'
    self.body:applyForce(dir*100, 0)
end

function basic_enemy:stop()
    self.state = 'idle'
    local velX, velY = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, velY)
end

function basic_enemy:update(dt) -- dont set animation after direction...
    self:update_unit(dt)
    local direction = self:get_direction()
    if direction == 1 then
        self.curranim = self.anim['walkr']
    elseif direction == -1 then
        self.curranim = self.anim['walkl']
    elseif direction == 0 then
    end
    self:limit_velocity()
    self.frame = self:compute_animation(self.curranim, self.state, dt)
end

function basic_enemy:draw()
    love.graphics.circle('line', self.body:getX(), self.body:getY(), self.awareness)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    self:draw_unit(self.image, self.curranim)
end

function basic_enemy:limit_velocity()
    speed = self.walkspeed
    local velX, velY = self.body:getLinearVelocity()
    if velX > speed then
        self.body:setLinearVelocity(speed, velY)
    end
    if velX < -speed then
        self.body:setLinearVelocity(-speed, velY)
    end
end
