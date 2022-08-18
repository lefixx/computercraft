redstone.setOutput("left",true)
redstone.setOutput("right",true)
chiller         = peripheral.wrap("thermal:machine_chiller_3")
myself          = peripheral.wrap("turtle_6")
crate           = peripheral.wrap("create:adjustable_crate_2")
charger         = peripheral.wrap("thermal:charge_bench_1")
drawers         = peripheral.wrap("storagedrawers:controller_2")
pulveriser      = peripheral.wrap("thermal:machine_pulverizer_1")
basin           = peripheral.wrap("create:basin_24")
basin2          = peripheral.wrap("create:basin_25")
igneous         = peripheral.wrap("thermal:device_rock_gen_0")
igneous2        = peripheral.wrap("thermal:device_rock_gen_1")
wheelsIn        = peripheral.wrap("create:smart_chute_3")
wheelsOut       = peripheral.wrap("create:chute_6")
encapsulator    = peripheral.wrap("thermal:machine_bottler_0")
drain           = peripheral.wrap("create:item_drain_2")
drainInput      = peripheral.wrap("minecraft:hopper_7")
drainOutput     = peripheral.wrap("create:chute_7")
sandCell        = peripheral.wrap("thermal:fluid_cell_9")
induction       = peripheral.wrap("thermal:machine_smelter_0")
pyroliser       = peripheral.wrap("thermal:machine_pyrolyzer_0")
charcoalDrawer  = peripheral.wrap("storagedrawers:standard_drawers_4_12")
creosoteCell    = peripheral.wrap("thermal:fluid_cell_10")
belt1           = peripheral.wrap("create:belt_3")
coalChunksDepot = peripheral.wrap("create:depot_34")
deployer        = peripheral.wrap("create:deployer_10")
deployerDepot   = peripheral.wrap("create:depot_35")
inductiveChest  = peripheral.wrap("storagedrawers:standard_drawers_1_31")




function findInDrawers(name)
    for i,v in pairs(drawers.list()) do
        if v.name == name then
            return i, v.count
        end
    end
end

function sendPulse()
    redstone.setOutput("right",false)
    os.sleep(0.4)
    redstone.setOutput("right",true)
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
        if not haveEnough("minecraft:snowball",1000,1000) then
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
    pulveriser.pullItems(peripheral.getName(drawers),findInDrawers("thermal:blizz_rod"),20)
    while pulveriser.list()[1] do
        os.sleep(0.2)
    end
    clearPulveriser()
end

function craftBasalzPowder()
    clearPulveriser()
    pulveriser.pullItems(peripheral.getName(drawers),findInDrawers("thermal:basalz_rod"),20)
    while pulveriser.list()[1] do
        os.sleep(0.2)
    end
    clearPulveriser()
end

function pulveriserManager()
    while true do os.sleep(1)
        if haveEnough("thermal:basalz_rod",500,500)  and not haveEnough("thermal:basalz_powder",1000,1000)  then
            craftBasalzPowder()
        end
        
        if not haveEnough("thermal:blizz_powder",1000,1000) and haveEnough("thermal:blizz_rod",500,500) then 
            craftBlizzPowder()
        end
    end
end

function craftIceCharge()
    
    basin.pullItems(peripheral.getName(drawers),findInDrawers("thermal:blizz_powder"),8)
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin),10)
    
end

function craftEarthCharge()
    basin.pullItems(peripheral.getName(drawers),findInDrawers("thermal:basalz_powder"),8)
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin),10)
end

function craftSiliconCompound()
    basin.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:purified_sand"),1)
    basin.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:coke_chunk"),1)
    basin.pullFluid(peripheral.getName(sandCell),500)
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin),10)
end

function pressManager()
    for i,v in pairs(basin.list()) do
        drawers.pullItems(peripheral.getName(basin),i)
    end
    while true do os.sleep(1)
        if haveEnough("thermal:basalz_powder",500,500) and not haveEnough("thermal:earth_charge",1000,1000) then
            craftEarthCharge()
        elseif haveEnough("thermal:blizz_powder",500,500) and not haveEnough("thermal:ice_charge",1000,1000) then
            craftIceCharge()
        elseif (haveEnough("kubejs:coke_chunk",500,500)) and (not haveEnough("kubejs:silicon_compound",1000,1000)) and haveEnough("kubejs:purified_sand", 500,500) then
            craftSiliconCompound()
        end
    end
end

function craftIceCharge2()
    -- if basin.list()[findInDrawers("thermal:blizz_powder")] then
        basin2.pullItems(peripheral.getName(drawers),findInDrawers("thermal:blizz_powder"),8)
    -- end
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin2),10)
end

function craftEarthCharge2()
    basin2.pullItems(peripheral.getName(drawers),findInDrawers("thermal:basalz_powder"),8)
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin2),10)
end

function craftSiliconCompound2()
    basin2.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:purified_sand"),1)
    basin2.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:coke_chunk"),1)
    basin2.pullFluid(peripheral.getName(sandCell),500)
    os.sleep(0.5)
    drawers.pullItems(peripheral.getName(basin2),10)
end

function pressManager2()
    for i,v in pairs(basin2.list()) do
        drawers.pullItems(peripheral.getName(basin2),i)
    end
    while true do os.sleep(0.1)

        if haveEnough("thermal:basalz_powder",500,500) and not haveEnough("thermal:earth_charge",1000,1000) then
            craftEarthCharge2()
        elseif (drawers.list()[findInDrawers"thermal:blizz_powder"].count > 8) and (drawers.list()[findInDrawers"thermal:ice_charge"].count < 512) then
            craftIceCharge2()
        elseif (haveEnough("kubejs:coke_chunk",500,500)) and (not haveEnough("kubejs:silicon_compound",1000,1000)) and haveEnough("kubejs:purified_sand", 64,64) then
            craftSiliconCompound2()
        end
            
    end
end

function haveEnough(item,min,max)
    
    local slot,count  = findInDrawers(item)
    
    if not slot then 
        return false
    else
        if count > max then return true end
        if count > min then return false end
        if count < max then return false end
    end
end

function laserManager()
    while true do os.sleep(1)
        
        if not haveEnough("thermal:blizz_rod",1000,1000) then
        -- if drawers.list()[findInDrawers("thermal:blizz_rod")].count <1024 then
            craftBlizz()
        end
        
        -- if drawers.list()[findInDrawers("thermal:basalz_rod")].count <1024 then
        if not haveEnough("thermal:basalz_rod",1000,1000) and haveEnough("minecraft:basalt",500,500) then
            craftBasalzShard()
        end
    end
end

function IngneousManager()

    while true do os.sleep(20)
        -- if drawers.list()[findInDrawers("minecraft:basalt")].count < 1024 then
        
        if not haveEnough("minecraft:basalt",1000,1000) then
            drawers.pullItems(peripheral.getName(igneous),1)
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
        
        if haveEnough("minecraft:cobblestone",500,500) and not haveEnough("minecraft:gravel",1000,1000) then 
            makeGravel()
        end

        
        
        -- if (not drawers.list()[findInDrawers("minecraft:sand")]) or drawers.list()[findInDrawers("minecraft:sand")].count< 256 then 
        --     if drawers.list()[findInDrawers("minecraft:gravel")] then
        if not haveEnough("minecraft:sand",1000,1000) and haveEnough("minecraft:gravel",500,500) then
            makeSand()
        end
    end
end

function igneous2Manager()
    while true do
        if not haveEnough("minecraft:cobblestone",1000,1000) then    
            drawers.pullItems(peripheral.getName(igneous2),1)
        end
        os.sleep(5)
    end
end

function makeGravel()
    wheelsIn.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:cobblestone"),64)
end

function makeSand()
    wheelsIn.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:gravel"),64)
end

function encapsulatorManager()
    while true do os.sleep(0.2)
        if not haveEnough("kubejs:sand_ball",1000,1000) and haveEnough("minecraft:sand",500,500) then
            encapsulator.pushItems(peripheral.getName(drawers),1)
            encapsulator.pushItems(peripheral.getName(drawers),2)
            encapsulator.pullItems(peripheral.getName(drawers),findInDrawers("minecraft:sand"),1)
            while encapsulator.list()[1] do
                os.sleep(0.1)
            end
            encapsulator.pushItems(peripheral.getName(drawers),1)
            encapsulator.pushItems(peripheral.getName(drawers),2)
        end
    end
end

function drainManager()
    while true do os.sleep(1) 
        if not haveEnough("kubejs:rough_sand",1000,1000) and haveEnough("kubejs:sand_ball",500,500) then
            drainInput.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:sand_ball"))
        end
            
        drain.pushFluid(peripheral.getName(sandCell))
    end
end

function drainOutputManager()
    while true do os.sleep(0.2)
        drainOutput.pushItems(peripheral.getName(drawers),1)
    end
end

function craftPurifiedSand()
    induction.pullItems(peripheral.getName(drawers),findInDrawers("thermal:earth_charge"),1)
    induction.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:rough_sand"),1)
    while not induction.list()[5] do
        os.sleep(0.1)
    end
    induction.pushItems(peripheral.getName(drawers),5)

end

function craftSilicon()
    induction.pullItems(peripheral.getName(drawers),findInDrawers("thermal:ice_charge"),1)
    induction.pullItems(peripheral.getName(drawers),findInDrawers("kubejs:silicon_compound"),1)
    while not induction.list()[5] do
        os.sleep(0.1)
    end
    induction.pushItems(peripheral.getName(drawers),5)
end

function inductionSmelterManager()

    for i,v in pairs(induction.list()) do
        drawers.pullItems(peripheral.getName(induction),i)
    end

    while true do os.sleep(0.2)
        if not haveEnough("appliedenergistics2:silicon",1000,1000) and haveEnough("kubejs:silicon_compound",500,500) then
            craftSilicon()
        elseif not haveEnough("kubejs:purified_sand",1000,1000) then
            craftPurifiedSand()
        end
    end
end

function pyroliserManager()
    while true do os.sleep(1)
        if not haveEnough("thermal:coal_coke",1000,1000) then
            charcoalDrawer.pushItems(peripheral.getName(pyroliser),3,10)
            
            while pyroliser.list()[1] do 
                os.sleep(0.2)
            end
            
            pyroliser.pushItems(peripheral.getName(drawers),2)
            pyroliser.pushFluid(peripheral.getName(creosoteCell))
            
        end
    end
end

function cokeDepotManager()
    while true do os.sleep(0.5)
        print";;;"
        if haveEnough("thermal:coal_coke",500,500) and not haveEnough("kubejs:coke_chuck",1000,1000) then
            cokeDepot.pullItems(peripheral.getName(drawers),findInDrawers("thermal:coal_coke"),1)
            os.sleep(5)
            cokeDepot.pushItems(peripheral.getName(drawers),10)
        end
    end
end

function coalManager()
    while true do os.sleep(1)
        if haveEnough("thermal:coal_coke",500,500) and not haveEnough("kubejs:coke_chuck",1000,1000) then
            belt1.pullItems(peripheral.getName(drawers),findInDrawers("thermal:coal_coke"),1)
            coalChunksDepot.pushItems(peripheral.getName(drawers),1)
        end
    end
end

function deployerEquip(item)
    deployer.pullItems(peripheral.getName(drawers),findInDrawers(item),1)
end

function deployerLoad(item)
    deployerDepot.pullItems(peripheral.getName(drawers),findInDrawers(item),1)
end

function deployerClear()
    for i,v in pairs(deployerDepot.list()) do
        drawers.pullItems(peripheral.getName(deployerDepot),i)
    end
    deployer.pushItems(peripheral.getName(drawers),1)
end

function craftPrintedSilicon()
    deployerClear()
    deployerEquip("appliedenergistics2:silicon_press")
    deployerLoad("appliedenergistics2:silicon")
    os.sleep(1)
    deployerDepot.pushItems(peripheral.getName(drawers),1)
    deployerClear()

end

function craftCalculationMechanism()
    deployerClear()
    deployerDepot.pullItems(peripheral.getName(inductiveChest),2,1)

    deployerEquip("appliedenergistics2:printed_silicon")
    deployerEquip("appliedenergistics2:printed_silicon")

    os.sleep(0.7)
    deployerEquip("kubejs:flash_drive")
    os.sleep(0.5)
    deployerClear()
end

function deployerManager()
    deployerClear()
    while true do os.sleep(1)
        if not haveEnough("appliedenergistics2:printed_silicon",1000,1000) and haveEnough("appliedenergistics2:silicon",500,500) then
            craftPrintedSilicon()
            if haveEnough("appliedenergistics2:printed_silicon",500,500) and not haveEnough("kubejs:calculation_mechanism",4000,4000) then
                craftCalculationMechanism()
            end
        end
    end
end

function status()

    while true do os.sleep(1)
        redstone.setOutput("bottom",true)
        os.sleep(0.1)
        redstone.setOutput("bottom",false)
    end


end


parallel.waitForAll(
    pressManager,
    pressManager2,
    laserManager,craftSnowballs,pulveriserManager,
    IngneousManager,wheelOutPutManager,igneous2Manager,wheelInPutManager,encapsulatorManager,
    drainManager,drainOutputManager,inductionSmelterManager, pyroliserManager,coalManager,
    deployerManager,
    status
    
)

