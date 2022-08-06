potatoes = {}
reachedStart = false
startPotition = {4272, -2772}

rows = {
    ["potatoes"] = 0,
    ["wheat"] = 1,
    ["onions"] = 2,
    ["cabbage"] = 3,
    ["rice"]=4,
    ["coffee"] = 5,
    ["pumpkins"] = 10,
}

rows2={
    [1]="potatoes",
    [2]="wheat",
    [3]="onions",
    [4]="cabbage",
    [5]="rice",
    [6]="tomatoes",
    [7]="carrots",
    [8]="pumpkins",
    -- [9]="pumkin stems",
    -- [10]="pumpkins",
    [11]="flax",
    [12]="nothing",
    [13]="nothing",
    [14]="nothing",
    [16]="melons",
    -- [16]="pumpkin stems",
    -- [17]="pumpkins",
    [18]="sugar cane",
    [19]="water",
    [20]="sugar cane",
}


function selectBonemeal()
    for i = 16,1,-1 do
        if turtle.getItemDetail(i) ~= nil and (turtle.getItemDetail(i).name == "minecraft:bone_meal" or turtle.getItemDetail(i).name == "thermal:phytogro" )  then
            turtle.select(i)
            return
        end
    end
end

function find(item)
    for i = 1,16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == item then
                return turtle.select(i)
            end
        end
    end
    print("Run out of ",item)
end

function goToStart()
    -- go to start
    reachedStart = false
    while reachedStart == false do
        while turtle.forward() == true do end
        local a,b = turtle.inspect()
        local c,d = turtle.inspectDown()
        if b.name == "storagedrawers:controller_slave" then
            for i = 1,16 do
                turtle.select(i)
                turtle.drop()
            end
             reachedStart = true
        end
        turtle.turnLeft()
    end
    print("at start")
end

function refuel()
    if turtle.getFuelLevel() < 5120 then
        print"fuel low, going to refuel"
        goToStart()
        turtle.suckDown()
        shell.run("refuel 64")
    end
    print"fuel ok"
end

function goTo(loc)
    local toTravel = 0
    print("Going to",loc)
    for i,v in pairs(rows2) do
        if v == loc then
            toTravel = i -1
        end
    end

    goToStart()

    for i = 1,toTravel do
        turtle.forward()
    end

    turtle.turnLeft()
end

function takeCareOfPotatoes()
    goTo("potatoes")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("minecraft:potato")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("minecraft:potato")
            turtle.placeDown()
        end
        turtle.forward()
    end

    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("minecraft:potato")
    turtle.drop()
end

function takeCareOfWheat()
    goTo("wheat")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("minecraft:wheat_seeds")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("minecraft:wheat_seeds")
            turtle.placeDown()
        end
        turtle.forward()
    end

    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("minecraft:wheat")
    turtle.drop()
    find("minecraft:wheat_seeds")
    turtle.drop()
    turtle.turnRight()
end

function takeCareOfOnions()
    goTo("onions")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("farmersdelight:onion")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("farmersdelight:onion")
            turtle.placeDown()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("farmersdelight:onion")
    turtle.drop()
    turtle.turnRight()
end

function takeCareOfCabbage()
    goTo("cabbage")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("farmersdelight:cabbage_seeds")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("farmersdelight:cabbage_seeds")
            turtle.placeDown()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("farmersdelight:cabbage_seeds")
    turtle.drop()
    find("farmersdelight:cabbage")
    turtle.drop()
    turtle.turnRight()
end

function takeCareOfTomatoes()
    goTo("tomatoes")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("farmersdelight:tomato_seeds")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("farmersdelight:tomato_seeds")
            turtle.placeDown()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("farmersdelight:tomato_seeds")
    turtle.drop()
    find("farmersdelight:tomato")
    turtle.drop()
    turtle.turnRight()
end

function takeCareOfCarrots()
    goTo("carrots")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()

        if under.name~=nil and under.state.age == 7 then
            turtle.digDown()
            find("minecraft:carrot")
            turtle.placeDown()
        end

        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("minecraft:carrot")
            turtle.placeDown()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("minecraft:carrot")
    turtle.drop()

    turtle.turnRight()
end

function takeCareofCoffee()
    goTo("coffee")
    turtle.up()
    for i = 1,3 do
        for i = 1,8 do
            local foo, under = turtle.inspectDown()
                if under.name~=nil and under.state.age == 3 then
                    turtle.digDown()
                end
            turtle.forward()
        end
        for i = 1,8 do
            turtle.back()
        end
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
    end
    turtle.down()
    turtle.turnLeft()
end

function takeCareofRice()
    goTo("rice")
    for i = 1,9 do
        local foo, under = turtle.inspectDown()
        if under.name~=nil and under.state.age == 3 then
            turtle.digDown()
        end
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()

    while turtle.forward() == true do end
    find("farmersdelight:rice_panicle")
    turtle.drop()
    turtle.turnRight()
end

function takeCareofPumpkins()
    goTo("pumpkins")
    turtle.down()

    repeat
    --    local q,w = turtle.inspectDown()
    --    if w.name == "minecraft:pumpkin" then
            turtle.digDown()
    --    end
    until turtle.forward() == false

    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.down()

    repeat
        local foo, under = turtle.inspectDown()
        if under.name == nil or under.name == "minecraft:pumpkin" then
            print"nothing under"
            turtle.digDown()
            find("minecraft:pumpkin_seeds")
            turtle.placeDown()
        end
    until turtle.forward() == false

    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.down()
    repeat
        local q,w = turtle.inspectDown()
        if w.name == "minecraft:pumpkin" then
            turtle.digDown()
        end
    until turtle.forward() == false
    turtle.up()

    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    find("minecraft:pumpkin_seeds")
    turtle.drop()
    find("minecraft:pumpkin")
    turtle.drop()
    turtle.turnLeft()
end

function takeCareofMelons()
    goTo("melons")
    turtle.down()

    repeat
        turtle.digDown()
    until turtle.forward() == false

    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.down()
    repeat
        local foo, under = turtle.inspectDown()
        if under.name == nil then
            print"nothing under"
            turtle.digDown()
            find("minecraft:melon_seeds")
            turtle.placeDown()
        end
    until turtle.forward() == false
    turtle.up()
    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.down()
    repeat
        turtle.digDown()
    until turtle.forward() == false
    turtle.up()

    turtle.turnLeft()
    turtle.turnLeft()
    while turtle.forward() == true do end
    find("minecraft:melon_seeds")
    turtle.drop()
    find("minecraft:melon")
    turtle.drop()
    turtle.turnLeft()
end


while true do
    refuel()
    takeCareOfPotatoes()
    takeCareOfWheat()
    takeCareOfOnions()
    takeCareOfCabbage()
    takeCareofRice()
    takeCareOfTomatoes()
    takeCareOfCarrots()
    takeCareofPumpkins()
    takeCareofMelons()
    -- takeCareofCoffee()
    os.sleep(20)
end
