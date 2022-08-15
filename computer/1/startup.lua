redstone.setOutput("left",true)
redstone.setOutput("right",true)
chiller    = peripheral.wrap("thermal:machine_chiller_2")
myself     = peripheral.wrap("turtle_6")
crate      = peripheral.wrap("create:adjustable_crate_0")
charger    = peripheral.wrap("thermal:charge_bench_0")
drawers    = peripheral.wrap("storagedrawers:controller_1")
pulveriser = peripheral.wrap("thermal:machine_pulverizer_1")


function find(x)
    for i = 1,16 do 
        if turtle.getItemDetail(i).name == x then 
            print(i)
            return i
        end
    end
end


function makeCatalyst(type)
    local a,b,c,d
    if type == "ingneus" then
        a = find("kubejs:substrate_andesite")
        b = find("kubejs:substrate_granite")
        c = find("kubejs:substrate_cobblestone")
        d = find("kubejs:substrate_diorite")
    end
    turtle.select(a)
    turtle.drop(1)
    turtle.select(b)
    turtle.drop(1)
    turtle.select(c)
    turtle.drop(1)
    turtle.select(d)
    turtle.drop(1)

    sendPulse()

    turtle.suck()
end

function sendPulse()
    redstone.setOutput("left",false)
    os.sleep(0.5)
    redstone.setOutput("left",true)

end

function loadSnowBalls()
    turtle.select(1)
    crate.pullItems(peripheral.getName(drawers),3)
    os.sleep(1)
    turtle.suckUp()
    turtle.drop()
end


function loadManipulator()
    turtle.select(1)
    charger.pushItems(peripheral.getName(crate),1)
    os.sleep(1)
    turtle.suckUp()
    turtle.drop()
end


function unload()
    for i = 1,5 do
        turtle.suck()
    end
    turtle.suckUp()
    for i =1,16 do
        if turtle.getItemDetail(i) then
            if turtle.getItemDetail(i).name == "thermal:blizz_rod" then
                turtle.select(i)
                turtle.dropUp()
                drawers.pullItems(peripheral.getName(crate),1)
            elseif turtle.getItemDetail(i).name == "appliedenergistics2:entropy_manipulator" then
                turtle.select(i)
                turtle.dropUp()
                charger.pullItems(peripheral.getName(crate),1)
            elseif turtle.getItemDetail(i).name == "minecraft:snowball" then
                turtle.select(i)
                turtle.dropUp()
                drawers.pullItems(peripheral.getName(crate),1)
            end
        end   
    end
end


function craftBlizz()
    while true do os.sleep(2)

        unload()
        loadSnowBalls()
        loadManipulator()
        sendPulse()
        unload()

     end
end

function craftSnowballs()
    while true do os.sleep(2)
        if drawers.list()[3].count <256 then 
            chiller.pushItems(peripheral.getName(drawers),2)
        end
    end
end

function clearPulveriser()
    pulveriser.pushItems(peripheral.getName(drawers),1)
    pulveriser.pushItems(peripheral.getName(drawers),2)
    pulveriser.pushItems(peripheral.getName(drawers),3)
    pulveriser.pushItems(peripheral.getName(drawers),4)
    pulveriser.pushItems(peripheral.getName(drawers),5)
    pulveriser.pushItems(peripheral.getName(drawers),6)
end

function craftBlizzPowder()
    while true do os.sleep(5) 
        pulveriser.pullItems(peripheral.getName(drawers),2,10)
        os.sleep(10)
        clearPulveriser()
    end
end



function pulveriserManager()
    clearPulveriser()
    craftBlizzPowder()
end

parallel.waitForAll(craftSnowballs,craftBlizz,craftBlizzPowder)


