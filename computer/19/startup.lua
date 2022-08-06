shell.run"clear"
washerDepot = peripheral.wrap("create:depot_9")
cobbleBasket = peripheral.wrap('farmersdelight:basket_0')
crushingWheel = peripheral.wrap("create:crushing_wheel_controller_0")
crusherDepot = peripheral.wrap("create:depot_15")
millstone1 = peripheral.wrap("create:millstone_2")
millstone2 = peripheral.wrap("create:millstone_3")
drawer = peripheral.wrap("storagedrawers:standard_drawers_2_3")
melter = peripheral.wrap("tconstruct:melter_1")
heater = peripheral.wrap("tconstruct:heater_0")
treeFarmDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
fluidCell = peripheral.wrap("thermal:fluid_cell_0")
skyMill = peripheral.wrap("create:millstone_5")
skyBasin = peripheral.wrap('create:basin_6')
chargeBasin = peripheral.wrap('create:basin_7')
charger1 = peripheral.wrap("appliedenergistics2:charger_0")
charger2 = peripheral.wrap("appliedenergistics2:charger_1")
charger3 = peripheral.wrap("appliedenergistics2:charger_2")
charger4 = peripheral.wrap("appliedenergistics2:charger_3")
chargers = {charger1,charger2,charger3,charger4}
roseBasin = peripheral.wrap("create:basin_8")
tubeDepot = peripheral.wrap("create:depot_16")
ironSpout = peripheral.wrap("create:spout_2")
waterBasin = peripheral.wrap("enderstorage:ender_tank_1")
kinetikDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_1")
precisionDepot = peripheral.wrap("create:depot_13")
precisionDeployer = peripheral.wrap("create:deployer_1")
tubeDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_9")
screwdriverDepot = peripheral.wrap("create:depot_14")
precisionDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_12")
crafter = peripheral.wrap("create:mechanical_crafter_1")
makeSeeds = true
flintBasin = peripheral.wrap("create:basin_12")
flintTilesBasin = peripheral.wrap("create:basin_14")
masonryTrader = peripheral.wrap("thermal:machine_press_4")
coinDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_2")
cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_2_5")
crystalBarrel = peripheral.wrap("metalbarrels:silver_tile_0")
crystalOverflow = peripheral.wrap("storagedrawers:standard_drawers_1_10")
seedDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_11")
seedCrafter = peripheral.wrap("create:mechanical_crafter_8")
crystalSpout1 = peripheral.wrap("thermal:fluid_cell_3")
crystalSpout2 = peripheral.wrap("thermal:fluid_cell_4")
crystalSpout3 = peripheral.wrap("thermal:fluid_cell_5")
crystalSpout4 = peripheral.wrap("thermal:fluid_cell_6")
crystalSpouts = {crystalSpout1, crystalSpout2, crystalSpout3, crystalSpout4, }
crystalDepot1 = peripheral.wrap("create:depot_17")
crystalDepot2 = peripheral.wrap("create:depot_18")
crystalDepot3 = peripheral.wrap("create:depot_19")
crystalDepot4 = peripheral.wrap("create:depot_20")
crystalDepots = {crystalDepot1,crystalDepot2,crystalDepot3,crystalDepot4}
cobblestoneChestInStage1 = peripheral.wrap("storagedrawers:standard_drawers_4_5")


function debug(string, func)
    if true then print(string, func) end
end

function craftMechanism()
    while true do
        debug("clearing the deployer", tubeDrawer.pullItems(peripheral.getName(precisionDeployer),1))
        debug("pulling a mechanism",precisionDepot.pullItems(peripheral.getName(kinetikDrawer),2,1))
        debug("equipping a tube", precisionDeployer.pullItems(peripheral.getName(tubeDrawer),2,2))
        os.sleep(1)
        debug("clearing the deployer", tubeDrawer.pullItems(peripheral.getName(precisionDeployer),1))
        debug("equipping screwdriver", precisionDeployer.pullItems(peripheral.getName(screwdriverDepot),1))
        os.sleep(0.5)
        debug("unequipping", precisionDeployer.pushItems(peripheral.getName(screwdriverDepot),1))
        debug("storing", precisionDrawer.pullItems(peripheral.getName(precisionDepot),1))
    end
end

function cobblestone()
    while true do
        cobbleDrawer.pushItems(peripheral.getName(washerDepot),3,64)

        for i,v in pairs (cobbleBasket.list()) do
            cobbleBasket.pushItems(peripheral.getName(cobbleDrawer),i)
        end

        if crusherDepot.list()[1] then
            print(crusherDepot.list()[1].name)
            if crusherDepot.list()[1].name == "minecraft:gravel" then
                cobbleDrawer.pullItems(peripheral.getName(crusherDepot),1)
                -- elseif crusherDepot.list()[1].name == "appliedenergistics2:sky_dust" then
                --     skyBasin.pullItems(peripheral.getName(crusherDepot),1)
                -- elseif crusherDepot.list()[1].name == "appliedenergistics2:sky_stone_block" then
                --     crushingWheel.pullItems(peripheral.getName(crusherDepot),1)
                --     debug("crushing",crushingWheel.pullItems(peripheral.getName(cobbleDrawer),2))
            end
        else debug("crushing",crushingWheel.pullItems(peripheral.getName(cobbleDrawer),2))
        end


        if washerDepot.list()[1] and (washerDepot.list()[1].name == "minecraft:flint" or washerDepot.list()[1].name == "minecraft:iron_nugget") then
            drawer.pullItems(peripheral.getName(washerDepot),1)
        end
        if washerDepot.list()[2] and (washerDepot.list()[2].name == "minecraft:flint" or washerDepot.list()[2].name == "minecraft:iron_nugget") then
            drawer.pullItems(peripheral.getName(washerDepot),2)
        end

        os.sleep(5)
    end

end


function mainProccess()
    while true do


        melter.pullItems(peripheral.getName(drawer),2)
        heater.pullItems(peripheral.getName(treeFarmDrawer),4,64)
        skyMill.pullItems(peripheral.getName(skyMill),3,1)
        skyBasin.pullItems(peripheral.getName(skyMill),2)
        skyBasin.pushFluid(peripheral.getName(chargeBasin),1000,"tconstruct:molten_obsidian")



        for k,v in pairs(chargers) do
            if chargeBasin.list()[1] and chargeBasin.list()[1].name == "appliedenergistics2:certus_quartz_crystal" then
                print("charging", v.pullItems(peripheral.getName(chargeBasin),1))
            end
            if chargeBasin.list()[10] and chargeBasin.list()[10].name == "appliedenergistics2:certus_quartz_crystal" then
                print("charging", v.pullItems(peripheral.getName(chargeBasin),10))
            end
            chargeBasin.pullItems(peripheral.getName(v),1)

        end



        roseBasin.pullFluid(peripheral.getName(chargeBasin),1000,"thermal:redstone")



        for i,v in pairs(crystalSpouts) do --put water in the water spout tanks
            debug("crystal Spout"..i, v.pullFluid(peripheral.getName(waterBasin),10000,"minecraft:water"))
        end




        -- if roseBasin.pullItems(peripheral.getName(crystalDepot1),1) == 1 then makeSeeds = true end


        skyBasin.pullFluid(peripheral.getName(waterBasin),1000,"minecraft:water")

        flintBasin.pullItems(peripheral.getName(drawer),3,64)
        flintTilesBasin.pullItems(peripheral.getName(flintBasin),10)
        flintBasin.pushItems(peripheral.getName(flintTilesBasin),10)
        masonryTrader.pullItems(peripheral.getName(flintTilesBasin),10)
        masonryTrader.pushItems(peripheral.getName(coinDrawer),3)

        ironSpout.pullFluid(peripheral.getName(fluidCell),1000,"tconstruct:molten_iron")

        if roseBasin.list()[10] and roseBasin.list()[10].name == "create:polished_rose_quartz" then
            print("tubing",tubeDepot.pullItems(peripheral.getName(roseBasin),10))
        end

        tubeDrawer.pullItems(peripheral.getName(tubeDepot),2)
        --
        if tubeDepot.list()[1] and tubeDepot.list()[1].name == "create:electron_tube" then
            print("storing",tubeDrawer.pullItems(peripheral.getName(tubeDepot),1))
        end
        --
        --
        -- precisionDepot.pullItems(peripheral.getName(kinetikDrawer),2,1)
        --
        -- precisionDeployer.pullItems(peripheral.getName(tubeDrawer),2,2)
        --
        -- os.sleep(1)
        --
        -- if precisionDeployer.list()[1] then
        --     print("putting back", precisionDeployer.pushItems(peripheral.getName(tubeDrawer),1))
        -- end
        --
        -- print("equipping screwdriver", precisionDeployer.pullItems(peripheral.getName(screwdriverDepot),1))
        -- os.sleep(0.5)
        -- print("unequipping screwdriver", precisionDeployer.pushItems(peripheral.getName(screwdriverDepot),1))
        --
        -- if precisionDepot.list()[1] and precisionDepot.list()[1].name == "create:precision_mechanism" then
        --
        --     print("finished",precisionDrawer.pullItems(peripheral.getName(precisionDepot),1))
        --
        -- end
    end
end

function crystals()
    while true do
        for i,v in pairs(crystalDepots) do
            if v.list()[1] and (v.list()[1].name == "appliedenergistics2:purified_nether_quartz_crystal" or v.list()[1].name == "appliedenergistics2:purified_certus_quartz_crystal") then
                debug("seedCrafter",v.pushItems(peripheral.getName(seedCrafter),1,1))
                debug("rosebasin",roseBasin.pullItems(peripheral.getName(v),1))
                debug("overflow", v.pushItems(peripheral.getName(crystalOverflow),1))
            else
                debug("adding a seed", v.pullItems(peripheral.getName(seedDrawer),2,1))
            end
        end
        debug("looping crystals()")
        os.sleep(1)
    end
end

function restockCobblestoneFromStage1()
    while true do
        cobbleDrawer.pullItems(peripheral.getName(cobblestoneChestInStage1),5,64,2)
    os.sleep(2)
    end
end


parallel.waitForAll(mainProccess, craftMechanism, cobblestone,crystals, restockCobblestoneFromStage1)
