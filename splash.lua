splash = {}

function splash.load()
    splash.dt_temp = 0
end

function splash.update(dt)
    splash.dt_temp = splash.dt_temp + dt
    if splash.dt_temp >= 2.5 then
        splash.dt_temp = 2.5
    end
end

function splash.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("the ritual", 180, (splash.dt_temp-1)*100)
end

function splash.keypressed(key)
    state = "game"
end
