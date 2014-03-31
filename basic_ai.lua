basic_ai = {}

-- let npc have a flag indicating the whom they are alerted to.

function basic_ai.check_proximity(player, units)
    for i, v in pairs(units) do
        if calculate_distance(player.body:getX(), player.body:getY(),
                    v.body:getX(), v.body:getY()) < v.awareness then
            move_to_engage(player, v)
            --alert_nearby(player, v, units) -- FIX DIS SHIET
        else
            v:stop()
        end
    end
end

function alert_nearby(player, npc, units)
    for i, v in pairs(units) do
        if calculate_distance(npc.body:getX(), npc.body:getY(),
                    v.body:getX(), v.body:getY()) < v.awareness then
            move_to_engage(player, v)
        end
    end
end

function move_to_engage(player, npc)
    if player.body:getX() < npc.body:getX() then
        npc:move(-1) --replace with v.proximity_response()
    elseif player.body:getX() > npc.body:getX() then
        npc:move(1) --replace with v.proximity_response()
    end
end

function direct_alert(player, units)
    local directly_alerted = {}
    return directly_alerted, units
end

function secondary_alert(directly_alerted, units)
    local alerted = {}
    for i, v in pairs(directly_alerted) do
        table.insert(alerted, v)
        for j, b in pairs(units) do
            if calculate_distance(v.body:getX(), v.body:getY(),
                        b.body:getX(), b.body:getY()) < v.awareness*2 then
                table.insert(alerted, b)
                b = nil
            end
        end
    end
    return alerted
end

function calculate_distance(pX, pY, uX, uY)
    local distance
    local x = uX - pX
    local y = uY - pY
    x = math.pow(x, 2)
    y = math.pow(y, 2)
    distance = math.sqrt(x+y)
    return distance
end
