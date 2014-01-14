require('camera')
game = {}

direction = 10

--require('character')

function game.load()
    size = 20
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)

    objects = createlevel.get_objects_from_file('map')

    game.objects = {}

    game.objects.ground = {}
    game.objects.ground.body = love.physics.newBody(world, 1280/2, 650-50/2, "static") -- static is default, typed for clarity
    game.objects.ground.shape = love.physics.newRectangleShape(1280, 50)
    game.objects.ground.fixture = love.physics.newFixture(
                                    game.objects.ground.body,
                                    game.objects.ground.shape)
    game.objects.l_wall = {}
    game.objects.l_wall.body = love.physics.newBody(world, 50-50/2, 1000/2, "static") -- all the /2 is because of body and shape origin
    game.objects.l_wall.shape = love.physics.newRectangleShape(50, 1000)
    game.objects.l_wall.fixture = love.physics.newFixture(
                                    game.objects.l_wall.body,
                                    game.objects.l_wall.shape)

    game.objects.r_wall = {}
    game.objects.r_wall.body = love.physics.newBody(world, 800-50/2, 1000/2, "static")
    game.objects.r_wall.shape = love.physics.newRectangleShape(50, 1000)
    game.objects.r_wall.fixture = love.physics.newFixture(
                                    game.objects.r_wall.body,
                                    game.objects.r_wall.shape)

    game.objects.roof = {}
    game.objects.roof.body = love.physics.newBody(world, 1280/2, 0+50/2, "static")
    game.objects.roof.shape = love.physics.newRectangleShape(1280, 50)
    game.objects.roof.fixture = love.physics.newFixture(
                                    game.objects.roof.body,
                                    game.objects.roof.shape)
    game.objects.character = {}

    -- require('character') and add init function to make this possible?
    -- game.objects.character.properties = character:init()
    game.objects.character.body = love.physics.newBody(world, 500-20/2, 500-20/2, "dynamic")

    game.objects.character.shape = love.physics.newRectangleShape(20, 20)
    game.objects.character.fixture = love.physics.newFixture(
                                        game.objects.character.body,
                                        game.objects.character.shape)
    game.objects.character.fixture:setRestitution(0.0)
    -- game.objects.character.fixture:setFriction(4.0)
    game.objects.quads = {}

    for i = 1, #objects do
        --print("i", i, "x: ", objects[i].x, " y: ", objects[i].y, "width: ", objects[i].width)
        body = love.physics.newBody(world, (objects[i].x*size)-size/2, (objects[i].y*size)-size/2)
        shape = love.physics.newRectangleShape(size,size)
        fixture = love.physics.newFixture(body, shape)

        table.insert(game.objects.quads, {body=body,shape=shape,fixture=fixture})
        --print("i", i, "x: ", body:getX(), " y: ", body:getY(), "width: ", objects[i].width)
    end

    --Camera stuff
    camera:setBounds(0,1000,-500,-300)

    --camera:setPosition(game.objects.character.body:getX(),game.objects.character.body:getY())
    game.objects.box = {}
    game.objects.box.body = love.physics.newBody(world, 400-20/2, 500-20/2, "dynamic")
    game.objects.box.shape = love.physics.newRectangleShape(20, 20)
    game.objects.box.fixture = love.physics.newFixture(
                                        game.objects.box.body,
                                        game.objects.box.shape)
    game.objects.box.fixture:setRestitution(0.6)

end

function game.update(dt)
    world:update(dt) --this puts the world into motion

    if love.keyboard.isDown("d") then
        game.objects.character.body:applyForce(80, 0)
        direction = 10
    end
    if love.keyboard.isDown("a") then
        -- m_left = 1
        game.objects.character.body:applyForce(-100, 0)
        direction = -10
    end
    if love.keyboard.isDown("w") then
        game.objects.character.body:applyLinearImpulse(0, -30)
    end

     --camera movment
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

    local charX, charY = game.objects.character.body:getPosition()
    --fixed on character
    local cameraXPoint = charX-(screen_width/2)--+direction
    local cameraYPoint = charY-(screen_height/2)
    camera:setPosition(cameraXPoint, cameraYPoint)
    --]]

    --[[ some nicer camera movement I dident get right :)
    local cameraEndX = camera.x+(screen_width/2)+direction
    local cameraEndY = camera.y+(screen_height/2)
    if charX < cameraEndX then
        camera:move(-1,0)
    elseif charX > cameraEndX then
        camera:move(1,0)
    end

    if charY < cameraEndY then
        camera:move(0,-1)
    elseif charY > cameraEndY then
        camera:move(0,1)
    end
    --]]

--    if love.keyboard.isDown("w") then -- keypress rather than isDown for this.
--        game.objects.character.body:applyForce(0, -500)
--    end
    -- game.objects.character.body:setPosition(x + (m_right - m_left)*150*dt, y)
end

function game.keypressed(key)
    -- game.objects.character:jump() -- make function in character, how would this work?
    game.objects.character.body:applyForce(0, 0) -- *game.objects.character.preoperties.jump or something in that manner
end

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
    camera:set()

    -- for each in game.objects do
    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", game.objects.ground.body:getWorldPoints(
                                    game.objects.ground.shape:getPoints()))
    love.graphics.polygon("fill", game.objects.l_wall.body:getWorldPoints(
                                    game.objects.l_wall.shape:getPoints()))
    love.graphics.polygon("fill", game.objects.r_wall.body:getWorldPoints(
                                    game.objects.r_wall.shape:getPoints()))
    love.graphics.polygon("fill", game.objects.roof.body:getWorldPoints(
                                    game.objects.roof.shape:getPoints()))

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.polygon("fill", game.objects.character.body:getWorldPoints(
                                    game.objects.character.shape:getPoints()))
    love.graphics.setColor(193, 147, 14)
    love.graphics.polygon("fill", game.objects.box.body:getWorldPoints(
                                    game.objects.box.shape:getPoints()))
--    love.graphics.rectangle("fill", game.objects.character.body:getX()-10,
--                                    game.objects.character.body:getY()-10,
--                                    20, 20)

    love.graphics.setColor(0,0,0)
    for i = 1,#game.objects.quads do
        love.graphics.polygon("fill", game.objects.quads[i].body:getWorldPoints(game.objects.quads[i].shape:getPoints()))
    end
    camera:unset()
end
