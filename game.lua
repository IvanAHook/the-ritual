require('camera')
game = {}
direction = 10
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
    game.objects.character.body = love.physics.newBody(world, 650-20/2, 650-20/2, "dynamic")
    game.objects.character.shape = love.physics.newRectangleShape(20, 20)
    game.objects.character.fixture = love.physics.newFixture(game.objects.character.body, game.objects.character.shape)
    game.objects.character.fixture:setRestitution(0.0)
    game.objects.character.fixture:setFriction(4.0)

    game.objects.box = {}
    for i = 1, #objects do
        --print("i", i, "x: ", objects[i].x, " y: ", objects[i].y, "width: ", objects[i].width)
        body = love.physics.newBody(world, (objects[i].x*size)-size/2, (objects[i].y*size)-size/2)
        shape = love.physics.newRectangleShape(size,size)
        fixture = love.physics.newFixture(body, shape)

        table.insert(game.objects.box, {body=body,shape=shape,fixture=fixture})
        --print("i", i, "x: ", body:getX(), " y: ", body:getY(), "width: ", objects[i].width)
    end

    --Camera stuff
    camera:setBounds(0,1000,-500,-300)

    --camera:setPosition(game.objects.character.body:getX(),game.objects.character.body:getY())
end

function game.update(dt)
    world:update(dt) --this puts the world into motion

    if love.keyboard.isDown("d") then
        game.objects.character.body:applyForce(80, 0)
        direction = 10
    end
    if love.keyboard.isDown("a") then
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
end

-- Linear interpolation between two numbers.
function lerp(a,b,t) return a+(b-a)*t end

-- Cosine interpolation between two numbers.
function cerp(a,b,t) local f=(1-math.cos(t*math.pi))*.5 return a*(1-f)+b*f end

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
    camera:set()

    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", game.objects.ground.body:getWorldPoints(game.objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.rectangle("fill", game.objects.character.body:getX()-10,
                                  game.objects.character.body:getY()-10,
                                  20,20)

    love.graphics.setColor(0,0,0)
    for i = 1,#game.objects.box do
        love.graphics.polygon("fill", game.objects.box[i].body:getWorldPoints(game.objects.box[i].shape:getPoints()))
    end

    camera:unset()
end

