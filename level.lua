require('createlevel')
require('simple_platform')
require'box'
level = {}

function level.buildLevel(world)
    local current_level = createlevel.get_objects_from_file("map")

    level.width = current_level.width
    level.height = current_level.height

    objects = {}

    --[[table.insert(objects, level_boarders_roof(level.width,level.height))
    table.insert(objects, level_boarders_ground(level.width,level.height))
    table.insert(objects, level_boarders_r_wall(level.width,level.height))
    table.insert(objects, level_boarders_l_wall(level.width,level.height))
]]

    for i = 1, #current_level do
        local object = {}
        if current_level[i].object_type == "P" then
            object = simple_platform:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"static")
            table.insert(objects, object)

        elseif level[i].object_type == "B" then
            object = box:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"dynamic")
            table.insert(objects, object)
        end
    end

    return objects
end
--[[
function level.draw()
    for i = 1, #objects do
        love.graphics.setColor(level.objects[i].red,level.objects[i].green,level.objects[i].blue)
        love.graphics.polygon("fill", level.objects[i].body:getWorldPoints(
                                        level.objects.entity[i].shape:getPoints()))
    end
end
]]
function level_boarders_roof(_width,_height)
    local thickness = 20

    roof = {}
    roof.body = love.physics.newBody(world, _width/2, thickness/2, "static") -- static is default, typed for clarity
    roof.shape = love.physics.newRectangleShape(_width, thickness)
    roof.fixture = love.physics.newFixture(
    roof.body,
    roof.shape)
    roof.fixture:setUserData("roof")

    return r_wall
end
function level_boarders_ground(_width,_height)
    local thickness = 20

    ground = {}
    ground.body = love.physics.newBody(world, _width/2, _height-thickness/2, "static") -- static is default, typed for clarity
    ground.shape = love.physics.newRectangleShape(_width, thickness)
    ground.fixture = love.physics.newFixture(
    ground.body,
    ground.shape)
    ground.fixture:setUserData("ground")

    return r_wall
end

function level_boarders_r_wall(_width,_height)
    local thickness = 20

    r_wall = {}
    r_wall.body = love.physics.newBody(world, _width-thickness/2, _height/2, "static")
    r_wall.shape = love.physics.newRectangleShape(thickness, _height)
    r_wall.fixture = love.physics.newFixture(
    r_wall.body,
    r_wall.shape)
    r_wall.fixture:setUserData("r_wall")

    return r_wall
end
function level_boarders_l_wall(_width,_height)
    local thickness = 20

    l_wall = {}
    l_wall.body = love.physics.newBody(world, thickness/2, _height/2, "static") -- all the /2 is because of body and shape origin
    l_wall.shape = love.physics.newRectangleShape(thickness, _height)
    l_wall.fixture = love.physics.newFixture(
    l_wall.body,
    l_wall.shape)
    l_wall.fixture:setUserData("l_wall")

    return r_wall
end
