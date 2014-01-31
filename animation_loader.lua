animation_loader = {}

function animation_loader.load(meta)
    animation = {}
    quadW, quadH, imgW, imgH = nil

    for line in love.filesystem.lines(meta) do
        if string.match(line, '(%a+):%s*') == 'img' then
            imgW, imgH = string.match(line, '(%d+),%s*(%d+)')
        elseif string.match(line, '(%a+):%s*') == 'quad' then
            quadW, quadH = string.match(line, '(%d+),%s*(%d+)')
        else
            local identity = string.match(line, '(%a+):%s*')
            local row, length = string.match(line, '(%d+),%s*(%d+)')
            row = tonumber(row)
            length = tonumber(length)
            animation[identity] = {}
            for i=1, length do
                table.insert(animation[identity], love.graphics.newQuad(quadW*(i-1),quadH*(row-1), quadW, quadH, imgW, imgH))
            end
        end
    end
    return animation
--[[    for k,v in pairs(animation) do
        print('animation: '..k)
        for i,j in pairs(v) do
            print('frame no: '..i)
            for a,b in pairs(j) do
                print(a,b)
            end
        end
    end]]
end
