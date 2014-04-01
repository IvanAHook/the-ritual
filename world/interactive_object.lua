interactive_object = class:new()

function interactive_object:spawn( world, x1, y1, x2, y2, userdata )
    self.body = love.physics.newBody( world, x1+width/2, y1+height/2, body_type )
    self.shape = love.physics.newRectangleShape( width, height )
    self.fixture = love.physics.newFixture( self.body, self.shape )
    self.fixture:setUserData( userdata )

    self.body = love.physics.newBody( world, x2+width/2, y2+height/2, body_type )
    self.shape = love.physics.newRectangleShape( width, height )
    self.fixture = love.physics.newFixture( self.body, self.shape )
    self.fixture:setUserData( userdata )
end

function interactive_object:draw()
end
