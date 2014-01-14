-- debug = false
require('splash')
require('game')

state = "game"

function love.load()
    splash.load()
    game.load()
    love.graphics.setBackgroundColor(104, 136, 248)
end

function love.update(dt)
    if state == "splash" then
        splash.update(dt)
    end
    if state == "game" then
        game.update(dt)
    end
end

function love.draw()
    if state == "splash" then
        splash.draw()
    end
    if state == "game" then
        game.draw()
    end
end

function love.keypressed(key)
    if key == "r" then
        love.load()
    end
    if state == "splash" then
        splash.keypressed(key)
    end
    if state == "game" then
        game.keypressed(key)
    end
end

function love.keyreleased(key)
    if state == "game" then
        game.keyreleased(key)
    end
end
