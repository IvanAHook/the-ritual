createlevel = {}

function createlevel.get_objects_from_file(file)
    level = {}
    size = 20
    y=0
    for line in love.filesystem.lines(file) do
        for x = 0, string.len(line) do

            if string.sub(line,x,x) == "S" then
                level.charSpawnX = x*size
                level.charSpawnY = y*size
            end

            if string.sub(line,x,x) == "X" then
                level.width = x*size
            end

            if string.sub(line,x,x) == "Y" then
                level.height = y*size
            end

            -- don't like so many objects but can't figure it out
            if string.sub(line,x,x) == "O" then
                table.insert(level, {object_type="O",x=x*size,y=y*size})
            end--]]

            --[[ i want this but iworks poorly
            if string.sub(line,x,x) == "O" then
                if x == 0 then
                    --start of line and object
                    table.insert(objects,{type="O", x=x-1, y=y, width=1})
                    width = 1
                elseif string.sub(line,x-1,x-1) ~= string.sub(line,x,x) then
                    --start of object
                    table.insert(objects,{type="O", x=x-1, y=y, width=1})
                    width = 1
                elseif string.sub(line,x,x) ~= string.sub(line,x+1,x+1) then
                    --end of object
                    width = width + 1
                    objects[#objects].width = width
                elseif string.sub(line,x,x) == string.sub(line, x+1,x+1) then
                    --object contiues
                    width = width+1
                end
            end--]]
        end
        y=y+1
    end
    return level
end
