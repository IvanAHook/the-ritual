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
    love.graphics.print("the ritual", 250, (splash.dt_temp-1)*100)
    if splash.dt_temp >= 2.5 then
        love.graphics.print("press a key", 250, 250)
    end
end

function splash.keypressed(key)
    state = "game"
end
