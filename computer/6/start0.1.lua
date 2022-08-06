shell.run("clear")
waterlvl= 71


function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

function getSavedLocation()
    local location = fs.open("loc","r")
    local x = location.readAll()
    location.close()
    print ("previus location ", x)
    return x
end
--
function saveCurrentLocation()
    local file = fs.open("loc", "w")
    local x = currentLocation
    file.write(x)
    print("new location is",x)
    file.close()
end

function checkIfOverBedrock()
    foo, bar = turtle.inspectDown()
    if bar.name == "minecraft:bedrock" then return true end
    return false
end

function checkIfOverStella()
    foo, bar = turtle.inspectDown()
    if bar.name == "forbidden_arcanus:stella_arcanum" then return true end
    return false
end

function mineUntilBedrock()
    while checkIfOverBedrock() == false do
        if checkIfOverStella() == true then print"STELLA" return end
        turtle.digDown()
        turtle.down()
        print(currentLocation)
        currentLocation[2] = currentLocation[2] - 1
        saveCurrentLocation()
    end
end

function returnToSurface()
    while currentLocation[2] <= waterlvl do
        turtle.up()
        currentLocation[2] = currentLocation[2] + 1
    end
end


currentLocation = getSavedLocation()
mineUntilBedrock()
returnToSurface()
