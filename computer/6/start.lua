--look south
function invLeft()
    local foo = 0
    for i = 1,16 do
        foo = foo + turtle.getItemCount(i)
    end
    return foo
end

function digCarefully()
    local foo,bar = turtle.inspect()
    if bar.name == "forbidden_arcanus:stella_arcanum" or  bar.name == "randomium:randomium_ore" then
        shell.run("shutdown")
    end
    turtle.dig()
end

function digCarefullyDown()
    local foo,bar = turtle.inspectDown()
    if bar.name == "forbidden_arcanus:stella_arcanum" then
        shell.run("shutdown")
    end
    turtle.digDown()
end

function doX()
    for i = 1,15 do
        digCarefullyDown()
        digCarefully()
        turtle.forward()
    end
    digCarefullyDown()
end


function goBackX()
    for i =1,15 do
        turtle.back()
    end
end

function goNextX()
    turtle.turnRight()
    digCarefully()
    turtle.forward()
    turtle.turnLeft()
end

function doY()
    print("starting layer with",invLeft(),"inventory and",turtle.getFuelLevel(),"fuel /483")
    digCarefullyDown()
    turtle.down()
    for i = 1,15 do
        doX()
        goBackX()
        goNextX()
    end
    doX()
    turtle.turnRight()
    for i = 1,15 do
        turtle.forward()
    end
    turtle.turnRight()
    turtle.down()
    for i = 1,15 do
        turtle.forward()
    end
    turtle.turnRight()
    for i = 1,15 do
        turtle.forward()
    end
    turtle.turnRight()
end

while true do
doY() -- look south -- be left

end
