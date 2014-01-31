require 'unit'
require 'character'

game = {}

t = 0

function game.load()
    buf = 0
    scale=1
    brick = love.graphics.newImage("bricks.jpg") -- store in table!!!
    text = ""
    love.physics.setMeter(64)

    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    game.objects = {}
    game.objects = level.buildLevel(world)

    player = character:new()
    player:spawn(world, level.charSpawnX-20/2, level.charSpawnY-20/2, "dynamic", "player")

    --Camera stuff
    camera:scale(scale)
    camera:setBounds(0,level.width-(love.graphics.getWidth()*scale)+20,0,level.height-(love.graphics.getHeight()*scale)+20)
end

function game.update(dt)
    world:update(dt) --this puts the world into motion
    player:update(dt)
    if string.len(text) > 500 then
        text = ""
    end
     --camera movment
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()

    local charX, charY = player.body:getPosition()
    --fixed on player
    
    local cameraXPoint = charX-((screen_width/2)*scale)+player.look*50
    local cameraYPoint = charY-((screen_height/2)*scale)
    camera:setPositionWithCerp(cameraXPoint, cameraYPoint)
end

function game.keypressed(key)
    player:keypressed(key)
end

function game.keyreleased(key)
    player:keyreleased(key)
end

function beginContact(a, b, coll)
    player:beginContact(a, b, coll)
    local x, y = coll:getNormal()
    text = text .. "\n" .. a:getUserData() .. " " .. b:getUserData()
end

function endContact(a, b, coll)
end

function game.set_level_objects(objects)
    level_objects = objects
end

function game.draw()
    camera:set()
    love.graphics.setColor(0,31,90)

    for i = 1, #game.objects do
        game.objects[i]:draw()
        i=i-1
    end

    love.graphics.setColor(255, 255, 255)
    player:draw()

    love.graphics.setColor(0,0,0, 150)
    love.graphics.rectangle("fill",camera.x , camera.y, 300, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(text, camera.x, camera.y)

    camera:unset()
end
