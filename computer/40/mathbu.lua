print("-=math=-")


third  = peripheral.wrap("create:mechanical_crafter_19")
second = peripheral.wrap("create:mechanical_crafter_20")
first  = peripheral.wrap("create:mechanical_crafter_21")
depot  = peripheral.wrap("create:depot_36")

castingTables = {}
castingTables.three  = peripheral.wrap("tconstruct:table_2")
castingTables.times  = peripheral.wrap("tconstruct:table_3")
castingTables.plus   = peripheral.wrap("tconstruct:table_4")
castingTables.divide = peripheral.wrap("tconstruct:table_5")
castingTables.eight  = peripheral.wrap("tconstruct:table_6")
castingTables.minus  = peripheral.wrap("tconstruct:table_7")

smeltery = peripheral.wrap("tconstruct:smeltery_0")

dick = {}
dick["1"]  = "kubejs:one"
dick["2"]  = "kubejs:two"
dick["3"]  = "kubejs:three"
dick["4"]  = "kubejs:four"
dick["5"]  = "kubejs:five"
dick["6"]  = "kubejs:six"
dick["7"]  = "kubejs:seven"
dick["8"]  = "kubejs:eight"
dick["9"]  = "kubejs:nine"
dick["0"]  = "kubejs:zero"



function placeNumber(number,slot)
    for i,v in pairs(castingTables) do
        if castingTables[i].list()[2].name == number then
            print("found "..number)
            
        end
    end
end

function clearDepot()
    smeltery.pullItems(peripheral.getName(depot),1)
end


function craft0()

    first.pullItems(peripheral.getName(castingTables.three),2)

    repeat
        os.sleep(0.01)
    until (castingTables.three.list()[2])

    third.pullItems(peripheral.getName(castingTables.three),2)
    second.pullItems(peripheral.getName(castingTables.minus),2)

    repeat
        os.sleep(0.1)
    until (depot.list()[1])
    
end


function pprint(x)
    print(textutils.serialise(x))
end


function getNumber(no,pos)    --no has to be int or string,  pos has to be object,or no
    print("getNumber",no,pos)
    
    os.sleep(1)
    
    if pos == 1 then
        pos = first
    elseif pos == 2 then
        pos = second
    elseif pos == 3 then
        pos = third
    elseif pos == nil then
        pos = smeltery
    end

    
    if depot.list()[1] then 
        
        pprint(dick[depot.list()[1].name])    
        pprint(no)
        print(dick[depot.list()[1].name] == no)
        
        if dick[depot.list()[1].name] == no then
            depot.pushItems(peripheral.getName(pos),1)
            return
        end
    end
    
    
    
    if no == 0 then
        getNumber(3,1)
        getNumber(3,3)
        getNumber(3,2)
    elseif no == 1 then
        getNumber(3,1)
        getNumber(3,3)
        getNumber("divide",2)
    elseif no == 2 then
        getNumber(6,1)
        getNumber(3,3)
        getNumber("minus",2)
    elseif no == 3 then
        
        pos.pullItems(peripheral.getName(castingTables.three),2)
        -- print"+++++++++"
        -- os.sleep(20)
    elseif no == 4 then
        getNumber(8,1)
        getNumber(2,3)
        getNumber("devide",2)
    elseif no == 5 then
        getNumber(8,1)
        getNumber(3,3)
        getNumber("minus",2)
    elseif no == 6 then
        getNumber(3,1)
        getNumber(3,3)
        getNumber("plus",2)
    elseif no == 7 then
        getNumber(8,1)
        getNumber(1,3)
        getNumber("minus",2)
    elseif no == 8 then
        pos.pullItems(peripheral.getName(castingTables.three),2)
    elseif no == 9 then
        getNumber(3,1)
        getNumber(3,3)
        getNumber("times",2)
    elseif no == "plus" then
        pos.pullItems(peripheral.getName(castingTables.plus),2)
    elseif no == "minus" then
        pos.pullItems(peripheral.getName(castingTables.minus),2)
    elseif no == "times" then
        pos.pullItems(peripheral.getName(castingTables.times),2)
    elseif no == "divide" then
        pos.pullItems(peripheral.getName(castingTables.divide),2)
    end


    os.sleep(1)
end

function meltNumber(no)
    print("meltNumber")
    clearDepot()
    
    getNumber(no)

    os.sleep(0.2)
    repeat
        print"asef"
        os.sleep(0.3)
    until(depot.list()[1])
    clearDepot()
end

-- getNumber(3,1)
meltNumber(8)




print("end")
os.sleep(1000)