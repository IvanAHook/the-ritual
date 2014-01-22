require 'character'
game = {}

direction = 10

function game.load()
    scale=1
    brick = love.graphics.newImage("bricks.jpg") -- store in table!!!
    text = ""
    love.physics.setMeter(64)

    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    level = createlevel.get_objects_from_file("map")

    game.objects = {} -- change to world.objects = {} and npc = {}

    --boraders
    game.objects.ground = {}
    game.objects.l_wall = {}
    game.objects.r_wall = {}

    game.objects.ground, game.objects.l_wall, game.objects.r_wall = createBoarders(level.width,level.height)

    game.objects.entity = {}

    for i = 1, #level do
        --platform
        if level[i].object_type == "P" then
            body = love.physics.newBody(world, (level[i].x)+level[i].width/2, (level[i].y)+level[i].height/2,"static")
            shape = love.physics.newRectangleShape(level[i].width,level[i].height)
            fixture = love.physics.newFixture(body, shape)
            fixture:setUserData("platform" .. i)
            table.insert(game.objects.entity, {body=body,shape=shape,fixture=fixture})
        elseif level[i].object_type == "B" then
            body = love.physics.newBody(world, (level[i].x)+level[i].width/2, (level[i].y)+level[i].height/2,"dynamic")
            shape = love.physics.newRectangleShape(level[i].width,level[i].height)
            fixture = love.physics.newFixture(body, shape)
            fixture:setUserData("box" .. i)
            table.insert(game.objects.entity, {body=body,shape=shape,fixture=fixture})
        end
        --print("i", i, "x: ", body:getX(), " y: ", body:getY(), "width: ", objects[i].width)
    end

    player = character:new(world, level.charSpawnX-20/2, level.charSpawnY-20/2, "dynamic", "player")

    --Camera stuff
    camera:scale(scale)
    camera:setBounds(0,level.width-(love.graphics.getWidth()*scale),0,level.height-(love.graphics.getHeight()*scale))
end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    player:update(dt)
    if string.len(text) > 500 then
        text = ""
    end
--    text = player.body:getLinearVelocity()

     --camera movment
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

    local charX, charY = player.body:getPosition()
    --fixed on player
    local cameraXPoint = charX-((screen_width/2)*scale)--+direction
    local cameraYPoint = charY-((screen_height/2)*scale)
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
--        game.objects.player.body:applyForce(0, -500)
--    end
    -- game.objects.player.body:setPosition(x + (m_right - m_left)*150*dt, y)
end

function game.keypressed(key)
    player:keypressed(key)
end

function game.keyreleased(key)
    player:keyreleased(key)
end

function beginContact(a, b, coll)
    local x, y = coll:getNormal()
    if b:getUserData() == player.fixture:getUserData() and a:getBody():getY() > b:getBody():getY() then -- this requires player to be added last in game.load
        player.body:setLinearVelocity(0, 0)
        player.grounded = true
        text = text .. "\n" .. x .. ", " .. y .. " " .. a:getUserData() .. " " .. b:getUserData()
    end
end

function endContact(a, b, coll)
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

    love.graphics.setColor(255, 255, 255)
    player:draw()

    for i = 1,#game.objects.entity do
        if string.sub(game.objects.entity[i].fixture:getUserData(),1, 8) == "platform" then
            love.graphics.setColor(84, 84, 84)
        elseif string.sub(game.objects.entity[i].fixture:getUserData(),1, 3) == "box" then
            love.graphics.setColor(205,149,12)
        else
            love.graphicd.setColor(0,0,0)
        end
        love.graphics.polygon("fill", game.objects.entity[i].body:getWorldPoints(
                                        game.objects.entity[i].shape:getPoints()))
    end

    love.graphics.setColor(0,0,0, 150)
    love.graphics.rectangle("fill",0 , 0, 300, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(text, 10, 10)

    camera:unset()
end

function createBoarders(_width,_height)
    local thickness = 20

    ground = {}
    ground.body = love.physics.newBody(world, _width/2, _height-thickness/2, "static") -- static is default, typed for clarity
    ground.shape = love.physics.newRectangleShape(_width, thickness)
    ground.fixture = love.physics.newFixture(
    ground.body,
    ground.shape)
    ground.fixture:setUserData("ground")

    l_wall = {}
    l_wall.body = love.physics.newBody(world, thickness/2, _height/2, "static") -- all the /2 is because of body and shape origin
    l_wall.shape = love.physics.newRectangleShape(thickness, _height)
    l_wall.fixture = love.physics.newFixture(
    l_wall.body,
    l_wall.shape)
    l_wall.fixture:setUserData("l_wall")

    r_wall = {}
    r_wall.body = love.physics.newBody(world, _width-thickness/2, _height/2, "static")
    r_wall.shape = love.physics.newRectangleShape(thickness, _height)
    r_wall.fixture = love.physics.newFixture(
    r_wall.body,
    r_wall.shape)
    r_wall.fixture:setUserData("r_wall")

    return ground, l_wall, r_wall
end
