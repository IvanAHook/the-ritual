
require('character')

game = {}

function game.load()
    text = ""
    grounded = true
    size = 20
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    game.objects = {}

    game.objects.ground = {}
    game.objects.ground.body = love.physics.newBody(world, 800/2, 650-50/2, "static") -- static is default, typed for clarity
    game.objects.ground.shape = love.physics.newRectangleShape(800, 50)
    game.objects.ground.fixture = love.physics.newFixture(
                                    game.objects.ground.body,
                                    game.objects.ground.shape)
    game.objects.ground.fixture:setUserData("ground")

    game.objects.roof = {}
    game.objects.roof.body = love.physics.newBody(world, 800/2, 0+50/2, "static")
    game.objects.roof.shape = love.physics.newRectangleShape(800, 50)
    game.objects.roof.fixture = love.physics.newFixture(
                                    game.objects.roof.body,
                                    game.objects.roof.shape)
    game.objects.roof.fixture:setUserData("roof")

    game.objects.l_wall = {}
    game.objects.l_wall.body = love.physics.newBody(world, 50-50/2, 625/2, "static") -- all the /2 is because of body and shape origin
    game.objects.l_wall.shape = love.physics.newRectangleShape(50, 625)
    game.objects.l_wall.fixture = love.physics.newFixture(
                                    game.objects.l_wall.body,
                                    game.objects.l_wall.shape)
    game.objects.l_wall.fixture:setUserData("l_wall")

    game.objects.r_wall = {}
    game.objects.r_wall.body = love.physics.newBody(world, 800-50/2, 625/2, "static")
    game.objects.r_wall.shape = love.physics.newRectangleShape(50, 625)
    game.objects.r_wall.fixture = love.physics.newFixture(
                                    game.objects.r_wall.body,
                                    game.objects.r_wall.shape)
    game.objects.r_wall.fixture:setUserData("r_wall")


    game.objects.box = {}
    game.objects.box.body = love.physics.newBody(world, 400-20/2, 500-20/2, "dynamic")
    game.objects.box.shape = love.physics.newRectangleShape(20, 20)
    game.objects.box.fixture = love.physics.newFixture(
                                        game.objects.box.body,
                                        game.objects.box.shape)
    game.objects.box.fixture:setRestitution(0)
    game.objects.box.fixture:setUserData("box")

    game.character = charater.load()
    -- require('character') and add init function to make this possible?
    -- game.character.properties = character:init()
    game.character.body = love.physics.newBody(world, 500-20/2, 500-20/2, "dynamic")
    game.character.shape = love.physics.newRectangleShape(20, 20)
    game.character.fixture = love.physics.newFixture(
                                        game.character.body,
                                        game.character.shape)
    game.character.fixture:setRestitution(0.0)
    -- game.character.fixture:setFriction(4.0)
    game.character.fixture:setUserData("char")
end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    game.character.update()
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        game.character.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        game.character.body:applyForce(-100, 0)
    end
    if string.len(text) > 500 then
        text = ""
    end
end

function game.keypressed(key)
    -- game.character:jump() -- make function in character, how would this work?
    if key == "j" and grounded == true then
        game.character.body:applyLinearImpulse(0, -30) -- *game.character.properties.jump or something in that manner
        grounded = false
    end
end

function game.keyreleased(key)
   if (key == "a" or  key == "d") and grounded == true then
         game.character.body:setLinearVelocity(0, 0)
    end
end

function beginContact(a, b, coll)
    local x, y = coll:getNormal()
    text = text .. "\n" .. x .. ", " .. y .. " " .. a:getUserData() .. " " .. b:getUserData()
    if b:getUserData() == "char" and a:getBody():getY() > b:getBody():getY() then
        grounded = true
    end
end

function endContact(a, b, coll)
end

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
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
    love.graphics.polygon("fill", game.character.body:getWorldPoints(
                                    game.character.shape:getPoints()))
    love.graphics.setColor(193, 147, 14)
    love.graphics.polygon("fill", game.objects.box.body:getWorldPoints(
                                    game.objects.box.shape:getPoints()))
--    love.graphics.rectangle("fill", game.character.body:getX()-10,
--                                    game.character.body:getY()-10,
--                                    20, 20)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, 10, 10)
end

