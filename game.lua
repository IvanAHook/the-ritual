
game = {}

function game.load()
    size = 20
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)

    objects = createlevel.get_objects_from_file('map')

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

    game.objects.box = {}
    for i = 1, #objects do
        --print("i", i, "x: ", objects[i].x, " y: ", objects[i].y, "width: ", objects[i].width)
        body = love.physics.newBody(world, objects[i].x*size, objects[i].y*size)
        shape = love.physics.newRectangleShape((objects[i].width*size),size)
        fixture = love.physics.newFixture(body, shape)

        object = {body=body,shape=shape,fixture=fixture}
        table.insert(game.objects.box, object)
    end

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

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", game.objects.ground.body:getWorldPoints(game.objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.polygon("fill", game.objects.character.body:getWorldPoints(game.objects.character.shape:getPoints()))

    love.graphics.setColor(0,0,0)
    for i = 1,#game.objects.box do
        love.graphics.polygon("fill", game.objects.box[i].body:getWorldPoints(game.objects.box[i].shape:getPoints()))
    end

end

