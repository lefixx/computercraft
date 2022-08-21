shell.run("clear")

refuelingStation = {4313, 67, -2832, "North"}
inventoryStation = {4314, 67, -2832, "North"}
wheat            = {4315, 67, -2831, "East"}
cabbage          = {4315, 67, -2828, "East"}
beetroot         = {4315, 67, -2825, "East"}
carrot           = {4315, 67, -2822, "East"}
tomato           = {4315, 67, -2819, "East"}
potato           = {4315, 67, -2816, "East"}
onion            = {4315, 67, -2813, "East"}
flax             = {4315, 67, -2810, "East"}
rice             = {4315, 67, -2807, "East"}
pumpkin         =  {4311, 67, -2829, "West"}
melon            = {4311, 67, -2825, "West"}
sugarCane        = {4312, 67, -2831, "West"}

--TODO move pumkins and mellons one layer down



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
    --add direction validation
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
    
    local state = {}
    state["x"] = x
    state["y"] = y
    state["z"] = z
    state["direction"] = direction
    state["selectedSlot"] = selectedSlot
    local file = fs.open("stateSave","w")
    -- print(textutils.serialise(state))
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
    -- print("going",dir)
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
    --TODO go to x=4314 first
    local sx,sy,sz = writeLocationToFile()
    -- print("I am at      ",sx,sy,sz)
    local tx,ty,tz = loc[1],loc[2],loc[3]
    -- print("I am going to",tx,ty,tz)
    if sx == tx and sy == ty and sz == tz then
        -- print("done moving")
        if loc[4] then
            turnTowards(loc[4])
        end
        return true
    elseif tz < sz then go("North") moveTo(loc)
    elseif tz > sz then go("South") moveTo(loc)
    else
        if tx > sx then go("East") moveTo(loc)
        elseif tx < sx then go("West") moveTo(loc)
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

function checkFuelAndRefuel()
    reportFuel()
    if turtle.getFuelLevel() <10000 then
        print("less than 10% fuel")
        saveCurrentState()
        moveTo(refuelingStation)
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

function emptyInv()
    moveTo(inventoryStation)
    checkFuelAndRefuel()
    for i = 1,16 do
        if turtle.refuel(i) == true then
            print("BURNABLE")
            throw()
        end
        if turtle.getItemCount(i) ~= 0 then
            turtle.select(i)
            turtle.drop()
        end
        turtle.select(1)
    end
    
end

function cultivate()
    local type = getType()
    if type == "minecraft:wheat" or type == "farmersdelight:cabbages" or type == "farmersdelight:tomatoes" then
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
    elseif type == "minecraft:carrots" or type == "minecraft:potatoes" or type =="farmersdelight:onions" then
        
        local a,block = turtle.inspectDown()
        if block.state.age == 7 then
            turtle.digDown()
            turtle.select(1)
            turtle.placeDown()
        end
    elseif type == "supplementaries:flax" then
        local a,block = turtle.inspectDown()
        if block.state.age == 7 then
            turtle.select(1)
            turtle.digDown()
            turtle.down()
            turtle.select(2)
            turtle.placeDown()
            turtle.up()
        end
    elseif type == "farmersdelight:rice_upper_crop" then
        local a,block = turtle.inspectDown()
        if block.state.age == 3 then
            turtle.select(1)
            turtle.digDown()
        end
    end
end

function glideWheat()
    emptyInv()
    
    moveTo(wheat)
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

function glideCarrot()
    
    emptyInv()
    
    moveTo(carrot)
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

function glideTomato()
    
    emptyInv()
    
    moveTo(tomato)
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

function glidePotato()
    
    emptyInv()
    
    moveTo(potato)
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

function glideOnion()
    
    emptyInv()
    
    moveTo(onion)
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

function glideFlax()
    
    emptyInv()
    
    moveTo(flax)
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

function glideRice()
    
    emptyInv()
    
    moveTo(rice)
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

function glidePumpkin()
    emptyInv()
    
    moveTo(pumpkin)
    goForward()
    for i =1,8 do
        if turtle.detectDown() then
            turtle.digDown()
        end
        goForward()
    end
    turnTowards("South")
    goForward()
    if turtle.detectDown() then
        turtle.digDown()
    end
    goForward()
    turnTowards("East")
    goForward()
    for i =1,8 do
        if turtle.detectDown() then
            turtle.digDown()
        end
        goForward()
    end
    goForward()
    goForward()
    goForward()
    emptyInv()
end

function glideMelon()
    emptyInv()
    
    moveTo(melon)
    turnTowards("West")
    for i =1,8 do
        if turtle.detectDown() then
            turtle.digDown()
        end
        goForward()
    end
    goForward()
    turnTowards("South")

    if turtle.detectDown() then
        turtle.digDown()
    end
    goForward()
    
    goForward()
    turnTowards("East")
    for i =1,8 do
        if turtle.detectDown() then
            turtle.digDown()
        end
        goForward()
    end
    goForward()
    goForward()
    goForward()
    emptyInv()
end

function glideSugarCane()
    emptyInv()
    moveTo(sugarCane)
    for i = 1,8 do
        if turtle.detect() then
            turtle.dig()
        end
        turtle.suck()
        turtle.suckDown()
        turtle.suckUp()
        goForward()
    end
    emptyInv()
end

function reportFuel()

    local coalCount
    local drawer = peripheral.wrap("front")
    for i,v in pairs(drawer.list()) do
        if v.name == "minecraft:charcoal" then
            coalCount = v.count
        end
    end

    coalCount = math.floor(coalCount/20,48)
    print("coal"..coalCount)
    rednet.open("Left")
    rednet.broadcast({turtle.getFuelLevel(),coalCount})
    rednet.close("Left")

end


glideMelon()
while true do 
    
    glideWheat()
    glideCabbage()
    glideBeetroot()
    glideCarrot()
    glideTomato()
    glidePotato()
    glideOnion()
    glideFlax()
    glideRice()
    
    glideSugarCane()
    glidePumpkin()
    glideMelon()
    os.sleep(60)
end



print"program end"
