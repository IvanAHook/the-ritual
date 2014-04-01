require'world/Platform'

ramp = Platform:new()

function ramp:spawn(world,x,y,width,height,body_type,userdata,bool)
    self.body = love.physics.newBody(world, x, y, body_type)
    if bool then
        self.shape = love.physics.newPolygonShape(0,0,0,height,width,height)
    else
        self.shape = love.physics.newPolygonShape(width,0,width,height,0,height)
    end
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData(userdata)
end

function ramp:init()
    self.red = 0
    self.green = 0
    self.blue = 0
end
