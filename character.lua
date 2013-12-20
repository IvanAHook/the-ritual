character = {}

function character.load()
    character.x = 200
    character.y = 100
    character.speed = 100
end

function character.update(dt)
    if love.keyboard.isDown("d") then
        character.x = character.x + character.speed*dt
    end
    if love.keyboard.isDown("a") then
        character.x = character.x - character.speed*dt
    end
    if love.keyboard.isDown("w") then
        character.y = character.y - character.speed*dt
    end
    if love.keyboard.isDown("s") then
        character.y = character.y + character.speed*dt
    end
end

function character.draw()
    love.graphics.rectangle("fill", character.x, character.y, 20, 20)
end

function character.keypressed()

end
