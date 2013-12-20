function menu()
    local menu1 = { text = "option1", x = 100, y = 200, color = {255, 255, 255} }
    local menu2 = { text = "option2", x = 100, y = 240, color = {0,255, 255} }
    local menu = { menu1, menu2 }
    return menu
end

function love.draw()
    local menu = menu()
    love.graphics.setColor(menu[1]["color"])
    love.graphics.print(menu[1]["text"], menu[1]["x"], menu[1]["y"])
    love.graphics.setColor(menu[2]["color"])
    love.graphics.print(menu[2]["text"], menu[2]["x"], menu[2]["y"])
end
