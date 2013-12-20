
game = {}

function game.load()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)

    game.objects = {}

    game.objects.ground = {}
    game.objects.ground.body = love.physics.newBody(world, 1000/2, 750-50/2)
    game.objects.ground.shape = love.physics.newRectangleShape(1280, 50)
    game.objects.ground.fixture = love.physics.newFixture(game.objects.ground.body, game.objects.ground.shape)
    game.objects.character = {}
    game.objects.character.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
    game.objects.character.shape = love.physics.newRectangleShape(20, 20)
    game.objects.character.fixture = love.physics.newFixture(game.objects.character.body, game.objects.character.shape)
    game.objects.character.fixture:setRestitution(0.0)
    game.objects.character.fixture:setFriction(4.0)

end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    if love.keyboard.isDown("d") then
        game.objects.character.body:applyForce(80, 0)
    end
    if love.keyboard.isDown("a") then
        game.objects.character.body:applyForce(-100, 0)
    end
    if love.keyboard.isDown("w") then
        game.objects.character.body:applyForce(0, -500)
    end
end

function game.draw()
    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", game.objects.ground.body:getWorldPoints(game.objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.rectangle("fill", game.objects.character.body:getX(),
                                    game.objects.character.body:getY()
                                    , 20, 20)
end

