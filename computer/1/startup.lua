redstone.setOutput("left",true)
redstone.setOutput("right",true)
chiller    = peripheral.wrap("thermal:machine_chiller_2")
myself     = peripheral.wrap("turtle_6")
crate      = peripheral.wrap("create:adjustable_crate_0")
charger    = peripheral.wrap("thermal:charge_bench_0")
drawers    = peripheral.wrap("storagedrawers:controller_1")
pulveriser = peripheral.wrap("thermal:machine_pulverizer_1")
basin      = peripheral.wrap("create:basin_24")
igneous    = peripheral.wrap("thermal:device_rock_gen_0")
igneous2   = peripheral.wrap("thermal:device_rock_gen_1")
wheelsIn   = peripheral.wrap("create:smart_chute_3")
wheelsOut  = peripheral.wrap("create:chute_6")


function find(x)
    for i = 1,16 do 
        if turtle.getItemDetail(i).name == x then 
            print(i)
            return i
        end
    end
end

function findInDrawers(name)
    for i,v in pairs(drawers.list()) do
        if v.name == name then
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
    crate.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:snowball"))
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

function loadFluxoMagnet()

    turtle.select(1)
    charger.pushItems(peripheral.getName(crate),2)
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
            local target = turtle.getItemDetail(i).name
            if target == "thermal:blizz_rod" then
                turtle.select(i)
                turtle.dropUp()
                drawers.pullItems(peripheral.getName(crate),1)
            elseif target == "appliedenergistics2:entropy_manipulator" then
                turtle.select(i)
                turtle.dropUp()
                charger.pullItems(peripheral.getName(crate),1,1,1)
            elseif target == "thermal:flux_magnet" then
                turtle.select(i)
                turtle.dropUp()
                charger.pullItems(peripheral.getName(crate),1,1,2)
            elseif target == "minecraft:snowball" or target == "minecraft:basalt" or target == "thermal:basalz_rod" then
                turtle.select(i)
                turtle.dropUp()
                drawers.pullItems(peripheral.getName(crate),1)
            end
        end   
    end
end

function craftBlizz()

        unload()
        loadSnowBalls()
        loadManipulator()
        sendPulse()
        unload()

end

function craftBasalzShard()

    unload()
    loadBasalt()
    loadFluxoMagnet()
    sendPulse()
    unload()

end

function loadBasalt()

    turtle.select(1)
    drawers.pushItems(peripheral.getName(crate),findInDrawers("minecraft:basalt"))
    os.sleep(1)
    turtle.suckUp()
    turtle.drop()

end

function craftSnowballs()
    while true do os.sleep(2)
        if (not drawers.list()[findInDrawers("minecraft:snowball")]) or drawers.list()[findInDrawers("minecraft:snowball")].count <256 then 
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
    clearPulveriser()   
    pulveriser.pullItems(peripheral.getName(drawers),findInDrawers("thermal:blizz_rod"),10)
    os.sleep(5.5)
    clearPulveriser()
end

function craftBasalzPowder()
    clearPulveriser()
    pulveriser.pullItems(peripheral.getName(drawers),findInDrawers("thermal:basalz_rod"),10)
    os.sleep(5.5)
    clearPulveriser()
end

function pulveriserManager()
    while true do os.sleep(1)
        if (not drawers.list()[findInDrawers("thermal:basalz_powder")])   or drawers.list()[findInDrawers("thermal:basalz_powder")].count < 1024    then
            craftBasalzPowder()
        end
        
        if (not drawers.list()[findInDrawers("thermal:blizz_powder")]) then 
            -- if (not drawers.list()[findInDrawers("thermal:blizz_powder")]) or drawers.list()[findInDrawers("thermal:blizz_powder").count < 1024] then
            craftBlizzPowder()
        end
    end
end

function craftIceCharge()
    if basin.list()[findInDrawers("thermal:blizz_powder")] then
        basin.pullItems(peripheral.getName(drawers),findInDrawers("thermal:blizz_powder"),8)
    end
    os.sleep(0.2)
    
end

function craftEarthCharge()
    
    basin.pullItems(peripheral.getName(drawers),findInDrawers("thermal:basalz_powder"),8)
    os.sleep(0.2)
    
end

function craftSandstone()

    if (not drawers.list()[findInDrawers("minecraft:sand")]) or drawers.list()[findInDrawers("minecraft:sand")].count > 7 then
        basin.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:sand"))
    end
    
    os.sleep(0.4)

end

function pressManager()
    while true do os.sleep(1)

        if (drawers.list()[findInDrawers"minecraft:sand"].count > 4) and (drawers.list()[findInDrawers"minecraft:sandstone"].count < 512) then
            craftSandstone()
        end

        if (drawers.list()[findInDrawers"thermal:basalz_powder"].count > 8) and (drawers.list()[findInDrawers"thermal:earth_charge"].count < 512) then
            craftEarthCharge()
        end

        if (drawers.list()[findInDrawers"thermal:blizz_powder"].count > 8) and (drawers.list()[findInDrawers"thermal:ice_charge"].count < 512) then
            craftIceCharge()
        end

        for i,v in pairs(basin.list()) do
            drawers.pullItems(peripheral.getName(basin),10)
        end
    end
end

function laserManager()
    while true do os.sleep(1)
        
        if drawers.list()[findInDrawers("thermal:blizz_rod")].count <1024 then
            craftBlizz()
        end
        
        if drawers.list()[findInDrawers("thermal:basalz_rod")].count <1024 then
            craftBasalzShard()
        end
    end
end

function IngneousManager()

    while true do os.sleep(20)
        if drawers.list()[findInDrawers("minecraft:basalt")].count < 1024 then
            drawers.pullItems(peripheral.getName(igneous),findInDrawers("minecraft:basalt"))
        end
    end

end

function wheelOutPutManager()
    while true do os.sleep(0.1)
        wheelsOut.pushItems(peripheral.getName(drawers),1)
    end
end

function wheelInPutManager()
    while true do os.sleep(1)

        if (not drawers.list()[findInDrawers("minecraft:gravel")]) or drawers.list()[findInDrawers("minecraft:gravel")].count< 256 then 
            if drawers.list()[findInDrawers("minecraft:cobblestone")] then
                makeGravel()
            end
        end

        if (not drawers.list()[findInDrawers("minecraft:sand")]) or drawers.list()[findInDrawers("minecraft:sand")].count< 256 then 
            if drawers.list()[findInDrawers("minecraft:gravel")] then
                makeSand()
            end
        end


    end
end

function igneous2Manager()
    while true do os.sleep(10)
        drawers.pullItems(peripheral.getName(igneous2),1)
    end
end

function makeGravel()
    wheelsIn.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:cobblestone"))
end

function makeSand()
    wheelsIn.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:gravel"))
end



craftSandstone()
parallel.waitForAll(laserManager,craftSnowballs,pulveriserManager,pressManager,IngneousManager,wheelOutPutManager,igneous2Manager,wheelInPutManager)


