
game = {}
--require('character')

function game.load()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)

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
    local x, y = game.objects.character.body:getPosition()
    local m_right = 0
    local m_left = 0
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        -- m_right = 1
        game.objects.character.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        -- m_left = 1
        game.objects.character.body:applyForce(-100, 0)
    end
--    if love.keyboard.isDown("w") then -- keypress rather than isDown for this.
--        game.objects.character.body:applyForce(0, -500)
--    end
    -- game.objects.character.body:setPosition(x + (m_right - m_left)*150*dt, y)
end

function game.keypressed(key)
    -- game.objects.character:jump() -- make function in character, how would this work?
    game.objects.character.body:applyForce(0, 0) -- *game.objects.character.preoperties.jump or something in that manner
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
    love.graphics.polygon("fill", game.objects.character.body:getWorldPoints(
                                    game.objects.character.shape:getPoints()))
    love.graphics.setColor(193, 147, 14)
    love.graphics.polygon("fill", game.objects.box.body:getWorldPoints(
                                    game.objects.box.shape:getPoints()))
--    love.graphics.rectangle("fill", game.objects.character.body:getX()-10,
--                                    game.objects.character.body:getY()-10,
--                                    20, 20)
end

