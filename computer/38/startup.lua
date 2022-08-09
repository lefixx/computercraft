shell.run("clear")

refuelingStation = {4313, 67, -2832}
otherPoint = {4317, 67, -2826}

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
    print("wrote direction to file: ",dir)
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
    local x,y,z = readLocationFromFile()
    local direction = readDirectionFromFile()
    local selectedSlot = turtle.getSelectedSlot()
    local currentState = z..","..y..","..z..","..direction..","..selectedSlot
    local file = fs.open("stateSave","w")
    file.write(currentState)
    file.close()
end

function getCurrentState()
    local file = fs.open("stateSave","r")
    file = file.readAll()

    local nextCommaLocation,b = string.find(file,",") --finds next comma locatin
    local x = string.sub(file,1,nextCommaLocation-1)  --extracts up to first comma location to x 
    -- print(x)
    file = string.sub(file,nextCommaLocation+1)   --crops up to first comma location

    nextCommaLocation,b = string.find(file,",")
    local y = string.sub(file,1,nextCommaLocation-1)
    file = string.sub(file,nextCommaLocation+1)

    nextCommaLocation,b = string.find(file,",")
    local z = string.sub(file,1,nextCommaLocation-1)
    file = string.sub(file,nextCommaLocation+1)

    nextCommaLocation,b = string.find(file,",")
    local dir = string.sub(file,1,nextCommaLocation-1)
    slot = string.sub(file,nextCommaLocation+1)

    return x,y,z,dir,slot
end

function go(dir)
    print("going",dir)
    turnTowards(dir)
    goForward()
end

function turnTowards(dir)
    currentDirection = readDirectionFromFile()
    print(currentDirection)
    print(dir)
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
    local sx,sy,sz = writeLocationToFile()
    print("I am at      ",sx,sy,sz)
    local tx,ty,tz = loc[1],loc[2],loc[3]
    print("I am going to",tx,ty,tz)
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



function goAndRefuel()
    if turtle.getFuelLevel() <10000 then
        print("less than 10% fuel")
        saveCurrentState()
        moveTo("RefuelingStation")
        refuelFromRefuelingStation()
        resume()
    end
end

moveTo(refuelingStation)
moveTo(otherPoint)

print"program end"