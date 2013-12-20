readfile = {}

function readfile.get_text_from_file(file)
    t = love.filesystem.read(file)
    return t
end
