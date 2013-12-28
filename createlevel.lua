createlevel = {}

function createlevel.get_objects_from_file(file)
    objects = {}
    y=0
    for line in love.filesystem.lines(file) do
        for x = 0, string.len(line) do
            if x == 0 then  -- start of line
                if string.sub(line, x,x) == "O" then -- creat object
                    table.insert(objects, {type="O", x=x, y=y, width=0})
                    width = 1
                    if string.sub(line, x,x) == string.sub(line,x+1,x+1) then -- if object is one tile
                        objects[#objects].width = width
                    end
                end

            elseif string.sub(line, x-1, x-1) ~= string.sub(line, x, x) then -- new or end of an object after first char
                if string.sub(line, x, x) == "O" then --new object
                    table.insert(objects, {type="O", x=x-1, y=y, width=0})
                    width = 1
                elseif string.sub(line,x,x) == " " then
                    objects[#objects].width = width
                    print(objects[#objects].width)
                end
            elseif string.sub(line, x-1, x-1) == string.sub(line, x, x) then -- the object continues
                width = width + 1
            end
        end
        y=y+1
    end
    print("objects: " , #objects)
    return objects
end
