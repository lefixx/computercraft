shell.run("clear")

function writeLocationToFile()
    local x,y,z = gps.locate()
    loc = fs.open("loc","w")
    loc.write(x..","..y..","..z)
    loc.close()
    loc = fs.open("loc","r")
    -- print(loc.read(100))
    loc.close()
end

function readLocationFromFile()
    loc = fs.open("loc","r")
    local location = loc.readAll()
    -- print( location)
    local nextCommaLocation,b = string.find(location,",")
    local x = string.sub(location,1,nextCommaLocation-1)
    -- print(x)
    location = string.sub(location,nextCommaLocation+1)
    local nextCommaLocation,b = string.find(location,",")
    local y = string.sub(location,1,nextCommaLocation-1)
    -- print(y)
    local z = string.sub(location,nextCommaLocation+1)
    -- print(z)
    return x,y,z
end

writeLocationToFile()
print(readLocationFromFile())
print"program end"