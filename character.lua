
character = {}

function character.load()
    character.image = love.graphics.newImage("FFII_Beaver.png")
    character.grounded = false
    character.state = "alive"
end

function character.update(dt)
    velX, velY = character.body:getLinearVelocity()
    if love.keyboard.isDown("d") then -- how do i handle movement in a neat way that also feels good?
        character.body:applyForce(100, 0)
    end
    if love.keyboard.isDown("a") then
        character.body:applyForce(-100, 0)
    end
    if velX > 200 then
        character.body:setLinearVelocity(200, velY)
    end
    if velX < -200 then
        character.body:setLinearVelocity(-200, velY)
    end
end

function character.keypressed(key)
    if key == "j" then
        character.jump()
    end
end

function character.keyreleased(key)
   if (key == "a" or  key == "d") and character.grounded == true then
         character.body:setLinearVelocity(0, 0)
    end
end

function character.jump()
    if character.grounded then
        character.body:applyLinearImpulse(0, -30) -- character.jump or something in that manner
        character.grounded = false
    end
end

function character.draw()
    love.graphics.draw(character.image, character.body:getX()-10, character.body:getY()-10)
--    love.graphics.setColor(193, 47, 14)
--    love.graphics.polygon("fill", character.body:getWorldPoints(
--                                    character.shape:getPoints()))
end
