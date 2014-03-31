require 'createlevel'
require 'simple_platform'
require 'box'
require 'border'
require 'ramp'
level = {}

function level.buildLevel(world)
    local current_level = createlevel.get_objects_from_file("map")

    level.width = current_level.width
    level.height = current_level.height

    objects = {}

    --[[table.insert(objects, level_borders_roof(level.width,level.height))
    table.insert(objects, level_borders_ground(level.width,level.height))
    table.insert(objects, level_borders_r_wall(level.width,level.height))
    table.insert(objects, level_borders_l_wall(level.width,level.height))
]]
    for i=1,4 do
        object = border:new()
        local thickness = 20
        if i == 1 then
            --roof
            object:spawn(world, 0, 0, level.width, thickness, "static","roof")
        elseif i == 2 then
            --ground
            object:spawn(world, 0, level.height, level.width, thickness, "static","ground")
        elseif i == 3 then
            --left_wall
            object:spawn(world, 0, 0, thickness, level.height, "static","left_wall")
        elseif i == 4 then
            ---right_wall
            object:spawn(world, level.width, 0, thickness, level.height+thickness, "static","right_wall")
        end
        table.insert(objects, object)
    end

    for i = 1, #current_level do
        local object = {}
        if current_level[i].object_type == "P" then
            object = simple_platform:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"static", "simple_platform")
            table.insert(objects, object)

        elseif level[i].object_type == "B" then
            object = box:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"dynamic","box")
            table.insert(objects, object)
        elseif level[i].object_type == "r" then
            object = ramp:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"static","ramp", true)
            table.insert(objects, object)
        elseif level[i].object_type == "p" then
            object = ramp:new()
            object:spawn(world,current_level[i].x,current_level[i].y
                        ,current_level[i].width,current_level[i].height,"static","ramp", false)
            table.insert(objects, object)
        end
    end

    return objects
end
