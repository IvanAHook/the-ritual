require'Platform'

ramp = Platform:new()

function ramp:spawn(world,x,y,width,height,body_type,userdata,bool)
    self.body = love.physics.newBody(world, x, y, body_type)
    if bool then
        self.shape = love.physics.newPolygonShape(0,0,0,height,width,height)
    else
        print(width,height)
        self.shape = love.physics.newPolygonShape(width,0,width,height,0,height)
    end
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData(userdata)
    print(x,y,width,height,userdata)
    print(self.body:getX(), self.body:getY())
end

function ramp:init()
    self.red = 0
    self.green = 0
    self.blue = 0
end
