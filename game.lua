require('character')
require('camera')
require('level')
game = {}

t = 0

function game.load()
    scale=1
    brick = love.graphics.newImage("bricks.jpg") -- store in table!!!
    text = ""
    love.physics.setMeter(64)

    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    game.objects = {}
    game.objects = level.buildLevel(world)

    character.load()
    character.body = love.physics.newBody(world, 20-20/2, 20-20/2, "dynamic")
    character.shape = love.physics.newRectangleShape(20, 20)
    character.fixture = love.physics.newFixture(
                            character.body,
                            character.shape)
    character.fixture:setRestitution(0.0)
    character.fixture:setUserData("char")
    character.body:setFixedRotation(true)

    --Camera stuff
    camera:scale(scale)
    --camera:setBounds(0,level.width-(love.graphics.getWidth()*scale),0,level.height-(love.graphics.getHeight()*scale))

    effect = love.graphics.newShader [[
        extern number time;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);
        }
    ]]
end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    character.update(dt)
    if string.len(text) > 500 then
        text = ""
    end
--    text = character.body:getLinearVelocity()

     --camera movment
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

    local charX, charY = character.body:getPosition()
    --fixed on character
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
--        game.objects.character.body:applyForce(0, -500)
--    end
    -- game.objects.character.body:setPosition(x + (m_right - m_left)*150*dt, y)
    t = t + dt
    effect:send("time",t)
end

function game.keypressed(key)
    character.keypressed(key)
end

function game.keyreleased(key)
    character.keyreleased(key)
end

function beginContact(a, b, coll)
    local x, y = coll:getNormal()
    text = text .. "\n" .. x .. ", " .. y .. " " .. a:getUserData() .. " " .. b:getUserData()
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
    camera:set()
    love.graphics.setColor(0,31,90)
    --print(game.objects[3].id)

    for i = 1, #game.objects do
        --print(game.objects[i].id)
        game.objects[i]:draw()
        i=i-1
    end

    love.graphics.setColor(255, 255, 255)
    character.draw()

    love.graphics.setColor(0,0,0, 150)
    love.graphics.rectangle("fill",0 , 0, 300, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(text, 10, 10)

    camera:unset()
end
