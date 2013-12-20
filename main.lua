-- debug = false
require('character')

function love.load()
    character.load()
end

function love.update(dt)
    character.update(dt)
end

function love.draw()
    character.draw()
end

function love.keypressed(key)

end
