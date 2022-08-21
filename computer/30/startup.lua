shell.run("clear")

crystalBasin               = peripheral.wrap("create:basin_21")
blastFurnace               = peripheral.wrap("minecraft:blast_furnace_2")
crystal                    = "forbidden_arcanus:arcane_crystal"
crafterSticks              = peripheral.wrap("create:mechanical_crafter_14")
crafterCobble              = peripheral.wrap("create:mechanical_crafter_15")
crafterGun                 = peripheral.wrap("create:mechanical_crafter_16")
-- turtle                  = peripheral.wrap("turtle_2")
crusherInput               = peripheral.wrap("create:smart_chute_1")
crusherOutput              = peripheral.wrap("create:smart_chute_2")
chromaticDrawer            = peripheral.wrap("storagedrawers:standard_drawers_1_23")
crushingWheelDrawer        = peripheral.wrap("storagedrawers:standard_drawers_1_19")
singularityDrawer          = peripheral.wrap("storagedrawers:standard_drawers_1_20")
singularityBasin           = peripheral.wrap("create:basin_22")
singularityVacuum          = peripheral.wrap("thermal:device_collector_3")
gunpowderBlockDrawer       = peripheral.wrap("storagedrawers:standard_drawers_1_21")
vacuum2                    = peripheral.wrap("thermal:device_collector_2")
dyeDrawer                  = peripheral.wrap("storagedrawers:standard_drawers_1_22")
turtleHopper               = peripheral.wrap("minecraft:hopper_3")
firstHopper                = peripheral.wrap("minecraft:hopper_1")
secondHopper               = peripheral.wrap("minecraft:hopper_2")
crafterCompount            = peripheral.wrap("create:mechanical_crafter_12")
radiantSheetDepot          = peripheral.wrap("create:depot_26")
mechanismDepot             = peripheral.wrap("create:depot_30")
magnetDepot                = peripheral.wrap("create:depot_31")
precisionDrawer            = peripheral.wrap("storagedrawers:standard_drawers_1_12")
mechanismDeployer          = peripheral.wrap("create:deployer_9")
inductiveDrawer            = peripheral.wrap("storagedrawers:standard_drawers_1_31")
paintballDrawers           = peripheral.wrap("storagedrawers:controller_0")
radiantInductionCoilDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_25")
radiantCrafter             = peripheral.wrap("create:mechanical_crafter_17")
crystalBasinS              = peripheral.getName(crystalBasin)
nextStageDrawers           = peripheral.wrap("storagedrawers:controller_2")
cokeDrawer                 = peripheral.wrap("storagedrawers:controller_2")

green   = "appliedenergistics2:green_paint_ball"
blue    = "appliedenergistics2:blue_paint_ball"
red     = "appliedenergistics2:red_paint_ball"
magenta = "appliedenergistics2:magenta_paint_ball"
yellow  = "appliedenergistics2:yellow_paint_ball"


function debug(x)
    if true then print(x) end
end




function burnCoke()
    for i,v in pairs(cokeDrawer.list()) do
        if v.name == "thermal:coal_coke" then
            blastFurnace.pullItems(peripheral.getName(cokeDrawer),i,1,2)
        end
    end
end


function crystalBasinF()
    while true do
        for i,v in pairs(crystalBasin.list()) do
            if v.name == crystal then
                blastFurnace.pullItems(crystalBasinS,i,64)
                os.sleep(0.5)
                blastFurnace.pushItems(crystalBasinS,3)
                -- blastFurnace.pushItems(crystalBasinS,2)
                blastFurnace.pushItems(crystalBasinS,1)
            end
        end
        os.sleep(2)

    end
end

function blastFurnaceF()
    while true do
            blastFurnace.pushItems(crystalBasinS,3,64)
            -- blastFurnace.pullItems("storagedrawers:standard_drawers_4_11",3,32,2)
            burnCoke()
        os.sleep(10)
    end
end

function craftersF()
    while true do
        crafterSticks.pullItems("storagedrawers:standard_drawers_4_15",4,5)
        
        if nextStageDrawers.list() then
            print"asdf"
            local amount,slot
            for i,v in pairs(nextStageDrawers.list()) do 
                if v.name == "minecraft:cobblestone" then
                    slot = i
                    amount = v.count
                end
            end
            
            if amount and amount > 512 then
                
                crafterCobble.pullItems(peripheral.getName(nextStageDrawers), slot,16)
                
                
                
                if not gunpowderBlockDrawer.list()[2] or (gunpowderBlockDrawer.list(2) and gunpowderBlockDrawer.list()[2].count < 200) then
                    crafterGun.pullItems("storagedrawers:standard_drawers_4_14",3,9)
                end
                os.sleep(0.5)
            end
        end
    end
end

function crusherF()
    while true do
        local foo = crusherOutput.list()[1]
        if (not crusherInput.list()[1]) and (not foo) then
            if ((singularityDrawer.list()[2]) and (singularityDrawer.list()[2].count < 64)) then 
                if crushingWheelDrawer.list()[2] and crushingWheelDrawer.list()[2].count >= 64 then
                    crusherInput.pullItems(peripheral.getName(crushingWheelDrawer),2,64)
                    local finished = false
                    while finishe == false do
                        if (foo) and foo.count == 64 then
                            finished = true
                        end
                    end
                    crusherOutput.pushItems(peripheral.getName(singularityDrawer),1)
                else 
                    debug("not enough crushing wheels")
                end
            else
                crusherInput.pullItems(peripheral.getName(chromaticDrawer),2,1)
            end
        elseif foo and foo.name=="appliedenergistics2:singularity" then
            singularityDrawer.pullItems(peripheral.getName(crusherOutput),1)
        else debug("crushing wheel input/putput occupied")
        end
        os.sleep(1)
    end
end

function addDyeToSingularityBasin()
    while true do
        singularityBasin.pullItems(peripheral.getName(dyeDrawer),2)
        os.sleep(0.5)
    end
end

function singularities()
    while true do
        local count = 0
        for i,v in pairs(singularityVacuum.list()) do
            if singularityVacuum.list()[i] and singularityVacuum.list()[i].name == "appliedenergistics2:quantum_entangled_singularity" then
                count = count + singularityVacuum.list()[i].count
            end
        end
        debug(count)
        if count <= 10 then
            debug"less than 10"
            if turtleHopper.pullItems(peripheral.getName(singularityDrawer),2,8) then
                if turtleHopper.pullItems("storagedrawers:standard_drawers_4_14",4,8) then
                    turtleHopper.pullItems(peripheral.getName(gunpowderBlockDrawer),2,1)
                end
            end
            os.sleep(20)
        end


        local hasSing = false
        local slot

        for i,v in pairs(singularityBasin.list()) do
            if v.name == "appliedenergistics2:quantum_entangled_singularity" then
                print(hasSing)
            end
        end
        
        
        
        if not hasSing then
            for z,v in pairs(singularityVacuum.list()) do
                if singularityBasin.pullItems(peripheral.getName(singularityVacuum),z,1) then
                end
            end
        end

    os.sleep(0.5)
    end
end

function pullChromaticSingularitiesFromBasin()
    while true do
        os.sleep(0,2)
        for i,v in pairs(singularityBasin.list()) do   -- look in the singularity basin
            if v.name == "kubejs:dye_entangled_singularity" then --if there is chromatic singularity
                singularityBasin.pushItems("storagedrawers:standard_drawers_1_23",i)  --push it to the drawers?
            end
        end
    end

end

function secondHopperIsEmpty()
    local boo = true
    for i,v in pairs(secondHopper.list()) do
        if secondHopper.list()[i] then boo = false end
    end
    return boo
end

function paintballs()
    while true do

        local foo = crusherOutput.list()[1]

        if foo then 
            bar = string.sub(foo.name,-4)=="ball"
        end

        if foo and bar then
            debug(crusherOutput.pushItems("storagedrawers:controller_slave_1",1))
        end

    os.sleep(0.01)
    end
end

function rediantSheets()
    while true do
        if radiantSheetDepot.list()[1] and radiantSheetDepot.list()[1].name == "kubejs:radiant_sheet" then
            radiantSheetDepot.pushItems(peripheral.getName(radiantCrafter),1)
        end
        os.sleep(0.2)
    end

end

function craftMechanisms()
    while true do

        if not mechanismDepot.list()[1] then
            precisionDrawer.pushItems(peripheral.getName(mechanismDepot),2,1) -- get a mechanism
            mechanismDeployer.pullItems(peripheral.getName(radiantInductionCoilDrawer),2,2)
            os.sleep(1)
            mechanismDeployer.pullItems(peripheral.getName(magnetDepot),1)
            os.sleep(0.4)
            mechanismDeployer.pushItems(peripheral.getName(magnetDepot),1)
            if mechanismDepot.list()[1] and mechanismDepot.list()[1].name == "kubejs:inductive_mechanism" then
                inductiveDrawer.pullItems(peripheral.getName(mechanismDepot),1)
            end
        elseif mechanismDepot.list()[1] and mechanismDepot.list()[1].name == "kubejs:incomplete_inductive_mechanism" then
            mechanismDeployer.pullItems(peripheral.getName(radiantInductionCoilDrawer),2,1)
            os.sleep(0.7)
            mechanismDeployer.pushItems(peripheral.getName(radiantInductionCoilDrawer),1)
            mechanismDeployer.pullItems(peripheral.getName(magnetDepot),1)
            os.sleep(0.4)
            mechanismDeployer.pushItems(peripheral.getName(magnetDepot),1)
            if mechanismDepot.list()[1] and mechanismDepot.list()[1].name == "kubejs:inductive_mechanism" then
                inductiveDrawer.pullItems(peripheral.getName(mechanismDepot),1)
            end
        elseif mechanismDepot.list()[1].name == "create:precision_mechanism" then
            precisionDrawer.pushItems(peripheral.getName(mechanismDepot),2,1)
            mechanismDeployer.pullItems(peripheral.getName(radiantInductionCoilDrawer),2,2)
            os.sleep(1)
            mechanismDeployer.pullItems(peripheral.getName(magnetDepot),1)
            os.sleep(0.4)
            mechanismDeployer.pushItems(peripheral.getName(magnetDepot),1)
            if mechanismDepot.list()[1] and mechanismDepot.list()[1].name == "kubejs:inductive_mechanism" then
                inductiveDrawer.pullItems(peripheral.getName(mechanismDepot),1)
            end
        end

        os.sleep(0.1)
    end
end




parallel.waitForAll(
    crystalBasinF,
    rediantSheets,
    blastFurnaceF,
    craftersF,
    crusherF,
    singularities,
    addDyeToSingularityBasin,
    paintballs,
    craftMechanisms,
    pullChromaticSingularitiesFromBasin
)
