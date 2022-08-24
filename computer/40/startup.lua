shell.run("clear")
shell.run("bg asdf.lua")

first  = peripheral.wrap("create:mechanical_crafter_23")
second = peripheral.wrap("create:mechanical_crafter_24")
third  = peripheral.wrap("create:mechanical_crafter_25")
depot  = peripheral.wrap("create:depot_38")

castingTables = {}
castingTables.three  = peripheral.wrap("tconstruct:table_2")
castingTables.times  = peripheral.wrap("tconstruct:table_3")
castingTables.plus   = peripheral.wrap("tconstruct:table_4")
castingTables.divide = peripheral.wrap("tconstruct:table_5")
castingTables.eight  = peripheral.wrap("tconstruct:table_6")
castingTables.minus  = peripheral.wrap("tconstruct:table_7")

smeltery = peripheral.wrap("tconstruct:smeltery_0")
smelteryDrain = peripheral.wrap("tconstruct:drain_0")

dick = {}
dick[1]  = "one"
dick[2]  = "two"
dick[3]  = "three"
dick[4]  = "four"
dick[5]  = "five"
dick[6]  = "six"
dick[7]  = "seven"
dick[8]  = "eight"
dick[9]  = "nine"
dick[0]  = "zero"


function moveNumber(cast,crafter)  --casting table object    -- number is "!" or "2" etc -- craft is object
    if not crafter.list()[1] then
        while not cast.list()[2] do
            os.sleep(0.01)
        end
        crafter.pullItems(peripheral.getName(cast),2)
    end
end


function make(number)
    if number == "zero" then
        moveNumber(castingTables.three,first)
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.minus,second)
    elseif number == "one" then
        moveNumber(castingTables.three,first)
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.divide,second)
    elseif number == "two" then
        make("six")        
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.divide,second)
        while not depot.list()[1] do
            os.sleep(0.01)
        end
        depot.pushItems(peripheral.getName(first),1)
    elseif number == "three" then
        depot.pullItems(peripheral.getName(castingTables.three),2)
    elseif number == "four" then
        make("one")        
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.plus,second)
        while not depot.list()[1] do
            os.sleep(0.01)
        end
        depot.pushItems(peripheral.getName(first),1)

    elseif number == "five" then
        moveNumber(castingTables.eight,first)
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.minus,second)
    elseif number == "six" then
        moveNumber(castingTables.three,first)
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.plus,second)
    elseif number == "seven" then
        make("one")        
        moveNumber(castingTables.eight,first)
        moveNumber(castingTables.minus,second)
        while not depot.list()[1] do
            os.sleep(0.01)
        end
        depot.pushItems(peripheral.getName(third),1)

    elseif number == "eight" then
        print("make")
        repeat
            os.sleep(0.01)
        until(castingTables.eight.list()[2])
        depot.pullItems(peripheral.getName(castingTables.eight),2)
    elseif number == "nine" then
        moveNumber(castingTables.three,first)
        moveNumber(castingTables.three,third)
        moveNumber(castingTables.times,second)
    end
    repeat
        os.sleep(0.1)
    until(depot.list()[1])
end


function melt(number)
    make(number)
    depot.pushItems(peripheral.getName(smeltery),1)
end


function meltEverything()
    for i = 0,9 do
        print(dick[i])
        melt(dick[i])
    end
end

function meltLeast()
    local number 
    local least = 100000
    local liquid = nil
    for k,v in pairs(smelteryDrain.tanks()) do
        if string.sub(v.name,1,8) == "kubejs:n" then 
            if v.amount < least then 
                least = v.amount
                number = string.sub(v.name,15,-1)
            end
        end
    end
    melt(dick[number+0])
end



for i =1,9 do
    meltEverything()
end

