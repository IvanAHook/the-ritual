createlevel = {}

function createlevel.get_objects_from_file(file)
    objects = {}
    y=0
    for line in love.filesystem.lines(file) do
        for x = 0, string.len(line) do
            if string.sub(line, x, x) == "O" then
                table.insert(objects, {type="O", x=x, y=y});
            end
        end
        y=y+1
    end
    print("objects: " , #objects)
    return objects
end
