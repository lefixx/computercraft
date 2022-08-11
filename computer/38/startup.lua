shell.run("clear")

refuelingStation = {4313, 68, -2832}
inventoryStation = {4314, 68, -2832}
wheat = {4315, 64, -2831}
cabbage = {4315, 64, -2828}
beetroot = {4315, 64, -2825}

function writeLocationToFile()
    local x,y,z = gps.locate()
    loc = fs.open("loc","w")
    loc.write(x..","..y..","..z)
    loc.close()
    loc = fs.open("loc","r")
    -- print(loc.read(100))
    loc.close()
    return x,y,z
end

function readLocationFromFile()
    local loc = fs.open("loc","r")
    local location = loc.readAll()
    -- print( location)
    local nextCommaLocation,b = string.find(location,",") --finds next comma locatin
    local x = string.sub(location,1,nextCommaLocation-1)  --extracts up to first comma location to x 
    -- print(x)
    location = string.sub(location,nextCommaLocation+1)   --crops up to first comma location
    local nextCommaLocation,b = string.find(location,",")
    local y = string.sub(location,1,nextCommaLocation-1)
    -- print(y)
    local z = string.sub(location,nextCommaLocation+1)
    -- print(z)
    return x,y,z
end

function writeDirectionToFile(dir)
    local file = fs.open("dir","w")
    file.write(dir)
    file.close()
    -- print("wrote direction to file: ",dir)
end

function readDirectionFromFile()
    local file = fs.open("dir","r")
    local dir = file.readAll()
    return dir    
end
    
function goForward()
    local x,y,z = readLocationFromFile()
    turtle.forward()
    writeLocationToFile()
    local X,Y,Z = readLocationFromFile()
    if x == X and z == Z then 
        return false 
    elseif x > X and z ==Z then
        writeDirectionToFile("West")
    elseif x < X and z == Z then
        writeDirectionToFile("East")
    elseif x == X and z > Z then
        writeDirectionToFile("South")
    elseif x == X and z < Z then
        writeDirectionToFile("North")
    end
    return true
end

function saveCurrentState()
    writeLocationToFile()
    local x,y,z = readLocationFromFile()
    print(x,y,z )
    local direction = readDirectionFromFile()
    local selectedSlot = turtle.getSelectedSlot()
    local currentState = z..","..y..","..z..","..direction..","..selectedSlot
    local file = fs.open("stateSave","w")

    local state = {}
    state["x"] = x
    state["y"] = y
    state["z"] = z
    state["direction"] = direction
    state["selectedSlot"] = selectedSlot
    file.write(textutils.serialise(state))
    file.close()
end

function getSavedState()
    local file = fs.open("stateSave","r")
    state = textutils.unserialise(file.readAll())
    file.close()
    return state
end

function go(dir)
    print("going",dir)
    turnTowards(dir)
    goForward()
end

function turnTowards(dir)
    currentDirection = readDirectionFromFile()
    -- print("turn towards",dir)
    if dir == currentDirection then return true
    elseif dir == "North" then
        if currentDirection == "South" then
            turtle.turnRight()
            turtle.turnRight()
        elseif currentDirection == "East" then
            turtle.turnLeft()
        elseif currentDirection == "West" then
            turtle.turnRight()
        end
        writeDirectionToFile("North")
    elseif dir == "South" then
        if currentDirection == "North" then
            turtle.turnRight()
            turtle.turnRight()
        elseif currentDirection == "East" then
            turtle.turnRight()
        elseif currentDirection == "West" then
            turtle.turnLeft()
        end
        writeDirectionToFile("South")
    elseif dir == "East" then
        if currentDirection == "West" then
            turtle.turnRight()
            turtle.turnRight()
        elseif currentDirection == "North" then
            turtle.turnRight()
        elseif currentDirection == "South" then
            turtle.turnLeft()
        end
        writeDirectionToFile("East")
    elseif dir == "West" then
        if currentDirection == "East" then
            turtle.turnRight()
            turtle.turnRight()
        elseif currentDirection == "South" then
            turtle.turnRight()
        elseif currentDirection == "North" then
            turtle.turnLeft()
        end
        writeDirectionToFile("West")
    end
end

function moveTo(loc)
    --TODO include directiont o turn after and refactor all relevant code
    local sx,sy,sz = writeLocationToFile()
    -- print("I am at      ",sx,sy,sz)
    local tx,ty,tz = loc[1],loc[2],loc[3]
    -- print("I am going to",tx,ty,tz)
    if sx == tx and sy == ty and sz == tz then
        print("done")
        return true
    elseif tx > sx then go("East") moveTo(loc)
    elseif tx < sx then go("West") moveTo(loc)
    else
        if tz < sz then go("North") moveTo(loc)
        elseif tz > sz then go("South") moveTo(loc)
        end
    end            
end

function resume()
    print("resuming")
    local state = getSavedState()
    moveTo({state["x"]+0,state["y"]+0,state["z"]+0})
    -- asdfkja;sldkfja;slkdfjasl;kdfja;slkdfja;sl
    turnTowards(state["direction"])
    turtle.select(state["selectedSlot"]+0)
end

function goAndRefuel()
    if turtle.getFuelLevel() <10000 then
        print("less than 10% fuel")
        saveCurrentState()
        moveTo(refuelingStation)
        turnTowards("North")
        turtle.select(16)
        turtle.suck()
        turtle.refuel(64)
        resume()
    end
end

function getType()

    local a,block = turtle.inspectDown()
    
    -- print(textutils.serialise(block))
    -- local file = fs.open("scratch","w")
    -- file.write(textutils.serialise(block))
    -- file.close()
    -- print(block.name)
    
    if a == true then
        return block.name
    end
end

function cultivate()
    local type = getType()
    if type == "minecraft:wheat" or type == "farmersdelight:cabbages" then
        local a,block = turtle.inspectDown()
        if block.state.age == 7 then
            turtle.select(1)
            turtle.digDown()
            turtle.select(2)
            turtle.placeDown()
        end
    elseif type == "minecraft:beetroots" then
        local a,block = turtle.inspectDown()
        if block.state.age == 3 then
            turtle.select(1)
            turtle.digDown()
            turtle.select(2)
            turtle.placeDown()
        end
    end
end

function glideWheat()
    emptyInv()

    moveTo(wheat)
    turnTowards("East")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    
    turnTowards("South")
    goForward()
    turnTowards("West")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()

    emptyInv()
end

function glideCabbage()
    emptyInv()

    moveTo(cabbage)
    turnTowards("East")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    
    turnTowards("South")
    goForward()
    turnTowards("West")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()

    emptyInv()
end

function glideBeetroot()

    emptyInv()

    moveTo(beetroot)
    turnTowards("East")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    
    turnTowards("South")
    goForward()
    turnTowards("West")
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()
    goForward()
    cultivate()

    emptyInv()

end

function emptyInv()
    moveTo(inventoryStation)
    turnTowards("North")
    for i = 16,1,-1 do -- -1 so when it finishes slot 1 is selected
        turtle.select(i)
        turtle.drop()
    end
    
end

glideBeetroot()
glideWheat()
glideCabbage()

print"program end"