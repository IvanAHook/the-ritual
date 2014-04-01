--require 'world/interactive_object'

switch_door = class:new() -- rename to door?

function switch_door:spawn( world, x1, y1, x2, y2, userdata )
    self.switch_width = 40
    self.switch_height = 40
    self.door_width = 10
    self.door_height = 80
    self.range = 100

    self.switch_body = love.physics.newBody( world, x1+self.switch_width/2, y1+self.switch_height/2, body_type )
    self.switch_shape = love.physics.newRectangleShape( self.switch_width, self.switch_height )
    self.switch_fixture = love.physics.newFixture( self.switch_body, self.switch_shape )
    self.switch_fixture:setUserData( userdata .. ' switch' )
    self.switch_body:setActive( false )

    self.door_body = love.physics.newBody( world, x2+self.door_width/2, y2+self.door_height/2, body_type )
    self.door_shape = love.physics.newRectangleShape( self.door_width, self.door_height )
    self.door_fixture = love.physics.newFixture( self.door_body, self.door_shape )
    self.door_fixture:setUserData( userdata .. 'door' )

    self.in_range = false

    self.message = {}
    self.message.visible = false -- remove?
    self.message.text = 'interract: "e"'
    self.message.posX = x1 - self.switch_width/2
    self.message.posY = y1 - 40
end

function switch_door:init()
end

function switch_door:update()
end

function switch_door:keypressed( key )
    if self.in_range then
        if key == 'e' then
            self.door_body:setActive( false )
            -- change texture
        end
    end
end

function switch_door:interact()
end

function switch_door:draw()
    if self.in_range == true then
        love.graphics.setColor( 255, 255, 255 )
        love.graphics.rectangle( 'fill', self.message.posX, self.message.posY, 90, 20 )
        love.graphics.setColor( 0, 0, 0 )
        love.graphics.rectangle( 'line', self.message.posX, self.message.posY, 90, 20 )
        love.graphics.print( self.message.text, self.message.posX+4, self.message.posY+4 )
    end
    love.graphics.setColor( 222, 222, 0 )
    love.graphics.polygon("fill", self.switch_body:getWorldPoints(self.switch_shape:getPoints()))
    love.graphics.polygon("fill", self.door_body:getWorldPoints(self.door_shape:getPoints()))
end

function switch_door:calculate_distance(pX, pY)
    local distance
    local x = self.switch_body:getX() - pX
    local y = self.switch_body:getY() - pY
    x = math.pow(x, 2)
    y = math.pow(y, 2)
    if math.sqrt(x+y) < self.range then
        self.in_range = true
    else
        self.in_range = false
    end
end
