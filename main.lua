-- debug = false
require('character')
require('readfile')

function love.load()
    t = readfile.get_text_from_file("map")
    character.load()
end

function love.update(dt)
    character.update(dt)
end

function love.draw()
    love.graphics.print(t, 400,300)
    character.draw()
end

function love.keypressed(key)

end
