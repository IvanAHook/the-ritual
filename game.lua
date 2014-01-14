
require('character')

game = {}

function game.load()
    brick = love.graphics.newImage("bricks.jpg") -- store in table!!!
    text = ""
    size = 20
    love.physics.setMeter(64)

    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    game.objects = {} -- change to world.objects = {} and npc = {}

    game.objects.ground = {}
    game.objects.ground.body = love.physics.newBody(world, 2000/2, 650-50/2, "static") -- static is default, typed for clarity
    game.objects.ground.shape = love.physics.newRectangleShape(2000, 50)
    game.objects.ground.fixture = love.physics.newFixture(
                                    game.objects.ground.body,
                                    game.objects.ground.shape)
    game.objects.ground.fixture:setUserData("ground")

    game.objects.l_wall = {}
    game.objects.l_wall.body = love.physics.newBody(world, 50-50/2, 625/2, "static") -- all the /2 is because of body and shape origin
    game.objects.l_wall.shape = love.physics.newRectangleShape(50, 625)
    game.objects.l_wall.fixture = love.physics.newFixture(
                                    game.objects.l_wall.body,
                                    game.objects.l_wall.shape)
    game.objects.l_wall.fixture:setUserData("l_wall")

    game.objects.r_wall = {}
    game.objects.r_wall.body = love.physics.newBody(world, 2000-50/2, 625/2, "static")
    game.objects.r_wall.shape = love.physics.newRectangleShape(50, 625)
    game.objects.r_wall.fixture = love.physics.newFixture(
                                    game.objects.r_wall.body,
                                    game.objects.r_wall.shape)
    game.objects.r_wall.fixture:setUserData("r_wall")

    game.objects.boxes = {}
    boxY = 500
    for i = 1, 30 do
        local x = 400
        if i > 3 then
            body = love.physics.newBody(world, (x)-size/2, (boxY)-size/2, "dynamic")
        else
            body = love.physics.newBody(world, (x)-size/2, (boxY)-size/2, "static")
        end
        shape = love.physics.newRectangleShape(size,size)
        fixture = love.physics.newFixture(body, shape)
        fixture:setRestitution(0)
        fixture:setUserData("box" .. i)
        table.insert(game.objects.boxes, {body=body,shape=shape,fixture=fixture})
        boxY = boxY - 25
    end

    character.load()
    character.body = love.physics.newBody(world, 500-20/2, 500-20/2, "dynamic")
    character.shape = love.physics.newRectangleShape(20, 20)
    character.fixture = love.physics.newFixture(
                                        character.body,
                                        character.shape)
    character.fixture:setRestitution(0.0)
    character.fixture:setUserData("char")
    character.body:setFixedRotation(true)
end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    character.update(dt)
    if string.len(text) > 500 then
        text = ""
    end
    text = character.body:getLinearVelocity()
end

function game.keypressed(key)
    character.keypressed(key)
end

function game.keyreleased(key)
    character.keyreleased(key)
end

function beginContact(a, b, coll)
    local x, y = coll:getNormal()
--    text = text .. "\n" .. x .. ", " .. y .. " " .. a:getUserData() .. " " .. b:getUserData()
    if b:getUserData() == "char" and a:getBody():getY() > b:getBody():getY() then -- this requires character to be added last in game.load
        character.body:setLinearVelocity(0, 0)
        character.grounded = true
    end
end

function endContact(a, b, coll)
end

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
    love.graphics.setColor(72, 160, 14)
    love.graphics.polygon("fill", game.objects.ground.body:getWorldPoints(
                                    game.objects.ground.shape:getPoints()))
    love.graphics.polygon("fill", game.objects.l_wall.body:getWorldPoints(
                                    game.objects.l_wall.shape:getPoints()))
    love.graphics.polygon("fill", game.objects.r_wall.body:getWorldPoints(
                                    game.objects.r_wall.shape:getPoints()))

    love.graphics.setColor(0, 0, 0, 150)
    love.graphics.rectangle("fill", 0, 0, 400, 400 )

    love.graphics.setColor(193, 147, 14)
    for i = 1,#game.objects.boxes do
--        love.graphics.polygon("fill", game.objects.boxes[i].body:getWorldPoints(game.objects.boxes[i].shape:getPoints()))
        love.graphics.draw(brick, game.objects.boxes[i].body:getX()-10, game.objects.boxes[i].body:getY()-10)
    end
--    love.graphics.polygon("fill", game.objects.boxes.box1.body:getWorldPoints(
--                                    game.objects.boxes.box1.shape:getPoints()))

    character.draw()

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(text, 10, 10)
end

