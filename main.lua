-- debug = false
require 'class'
require 'splash'
require 'game'
require 'createlevel'
require 'camera'
require 'level'
require 'animation_loader'
require 'menu'

state = "game"

function love.load()
    flags = {}
    flags.fullscreen = false
    flags.vsync = true
    flags.fsaa = 0
    flags.resizable = false
    flags.display = 2
    flags.centered = true
    love.window.setTitle("TheRitual")
    success = love.window.setMode(800,600,flags)
    splash.load()
    menu.load()
    game.load()
    love.graphics.setBackgroundColor(104, 136, 248)
end

function love.update(dt)
    if state == "splash" then
        splash.update(dt)
    end
    if state == "menu" then
        menu.update(dt)
    end
    if state == "game" then
        game.update(dt)
    end
end

function love.draw()
    if state == "splash" then
        splash.draw()
    end
    if state == "menu" then
        menu.draw()
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
    if state == "menu" then
        menu.keypressed(key)
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
