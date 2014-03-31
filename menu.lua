menu =  {}

function menu.load()
    menu.menus= {}
    menu.menus.menu1 = { text = "play", outcome='game', x = 100, y = 200, color = {255, 255, 255}, id = 1 }
    menu.menus.menu2 = { text = "option2", x = 100, y = 240, color = {0,255, 255}, id = 2 }
    menu.selected = 1
end

function menu.update()
end

function menu.keypressed(key)
    if key == 's' then
        menu.selected = menu.selected + 1
    end
    if key == 'w' then
        menu.selected = menu.selected - 1
    end
    if key == 'e' then
    end
end

function menu.draw()
    for i, m in pairs(menu.menus) do
        if m['id'] == menu.selected then
            love.graphics.setColor(0, 0, 200)
        else
            love.graphics.setColor(m["color"])
        end
        love.graphics.print(m["text"], m["x"], m["y"])
    end
end
