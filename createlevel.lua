createlevel = {}

function createlevel.get_objects_from_file(file)
    level = {}
    tile_base = 20
    y=0
    for line in love.filesystem.lines(file) do
        for x = 0, string.len(line) do

            if string.sub(line,x,x) == "S" then
                level.charSpawnX = x*tile_base
                level.charSpawnY = y*tile_base
            end

            if string.sub(line,x,x) == "X" then
                level.width = x*tile_base
            end

            if string.sub(line,x,x) == "Y" then
                level.height = y*tile_base
            end

            --static platforms
            if string.sub(line,x,x) == "P" then
                --start
                if x == 0 then
                    --start of line and object
                    table.insert(level,{object_type="P", x=x*tile_base, y=y*tile_base, width=1,height=tile_base})
                    width = 1
                elseif string.sub(line,x-1,x-1) ~= string.sub(line,x,x) then
                    --start of object
                    table.insert(level,{object_type="P", x=x*tile_base, y=y*tile_base, width=1, height=tile_base})
                    width = 1
                end

                --object contiues
                if string.sub(line,x,x) == string.sub(line, x+1,x+1) then
                    width = width+1
                end

                --end
                if string.sub(line,x,x) ~= string.sub(line,x+1,x+1) then
                    --end of object
                    width = width*tile_base
                    level[#level].width = width
                end

            end
        end
        y=y+1
    end
    return level
end
