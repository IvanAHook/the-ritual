require'Class'
Platform = class()

function Platform:spawn(world,x,y,width,height,body_type)
    --print(x,y,width,height)
    o = {}
    o.body = love.physics.newBody(world, x+width/2, y+height/2,body_type)
    o.shape = love.physics.newRectangleShape(width,height)
    o.fixture = love.physics.newFixture(o.body,o.shape)
    o.fixture:setUserData("Platform")
end

function Platform:draw()
    love.graphics.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
end
