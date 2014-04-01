gui = class:new{}

function gui:load()
    -- load strings from file
    gui.padding = 4

    gui.staticstr = {}
    gui.staticstr['info'] = {}
    gui.staticstr['info'].text = 'det är info!'

    gui.str = {}
    gui.str['test'] = {}
    gui.str['test'].visible = true
    gui.str['test'].text = 'jak er förkyld'
end

function gui:update()
end

function gui:keypressed( key )
    if key == 'e' then
        for i, s in pairs( gui.str ) do
            if s.visible == true then
                s.visible = false
            end
        end
    end
end

function gui:draw( camX, camY )
    love.graphics.setColor( 255, 255, 255 )
    love.graphics.rectangle( 'fill', camX, camY, 800, 20 )
    for i, s in pairs( gui.staticstr ) do
        love.graphics.setColor( 0, 0, 0 )
        love.graphics.rectangle( 'line', camX, camY, 800, 20 )
        love.graphics.print( s.text, camX+4, camY+4 )
    end
    for i, s in pairs( gui.str ) do
        if s.visible == true then
            love.graphics.setColor( 255, 255, 255 )
            love.graphics.rectangle( 'fill', 400, 300, 90, 20 )
            love.graphics.setColor( 0, 0, 0 )
            love.graphics.rectangle( 'line', 400, 300, 90, 20 )
            love.graphics.print( s.text, 400+gui.padding, 300+gui.padding )
        end
    end
end
