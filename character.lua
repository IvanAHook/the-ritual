
character = {}

function character.load()
    jump = false
    -- is this a good model?
    -- character.properties.x_velocity = 0
    -- character.properties.y_velocity = 0
    -- character.state = ""
end

function character.update(dt)
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        game.character.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        game.character.body:applyForce(-100, 0)
    end
end

function character.draw()
end

function character.keypressed()

end

function character.jump()

end
