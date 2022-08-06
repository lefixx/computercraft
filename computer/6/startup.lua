shell.run("clear")


local x,y,z = gps.locate()
local a,b = true, "asdf"
print(y)


function goToSurface()
    repeat
        digUp()
        turtle.up()
        x,y,z = gps.locate()
    until y >= 70
end

function digDown()
    local a,b = turtle.inspectDown()
    if b.name ~= "forbidden_arcanus:stella_arcanum" then
        turtle.digDown()
    end
end
function digUp()
    local a,b = turtle.inspectUp()
    if b.name ~= "forbidden_arcanus:stella_arcanum" then
        turtle.digUp()
    end
end


function goToBedrock()
    repeat
        digDown()
        turtle.down()
        digDown()
        a,b = turtle.inspectDown()
    until b.name == "minecraft:bedrock"
end

function goToY(num)
    while true do
        local x,y,z = gps.locate()
        if y == num then return
        elseif y < num then
            digUp()
            turtle.up()
        else
            digDown()
            turtle.down()
        end
    end
end


for i = 1,050,1 do
    goToY(20)
    turtle.dig()
    turtle.forward()
    goToY(5)
end
