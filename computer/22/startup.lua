shell.run("clear")
coalDepot = peripheral.wrap("create:depot_22")
spoutDepot = peripheral.wrap("create:depot_21")
spout = peripheral.wrap("create:spout_5")
basin = peripheral.wrap("create:basin_15")
basket = peripheral.wrap("farmersdelight:basket_1")
coalDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_12")
water = peripheral.wrap("enderstorage:ender_tank_1")
lava = peripheral.wrap("thermal:fluid_cell_8")
precisionDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_12")
drawer = peripheral.wrap("storagedrawers:standard_drawers_1_13")

print("Start")





print("END")

function restocker()
    while true do
        coalDrawer.pushItems(peripheral.getName(coalDepot),3,64)
        basin.pullFluid(peripheral.getName(water))
        for i,v in pairs(basket.list()) do
            if v.name == "minecraft:weeping_vines" or v.name == "minecraft:twisting_vines" then
                basin.pullItems(peripheral.getName(basket),i)
            end
        end
        os.sleep(5)
    end
end


function debug(x)
    if true then
        print(x)
    end
end



function infernalMaker()
    while true do
        debug"loopin"
        if not spoutDepot.list()[1] or spoutDepot.list()[1].name == "create:precision_mechanism" then -- if depot is empty
            debug"depo empty or precision"
            for i,v in pairs(basin.tanks()) do
                if v.name == "tconstruct:liquid_soul" then
                    debug("found liquid_soul")
                    if lava.tanks()[1].amount >= 3000 then

                        --clear
                        spoutDepot.pushItems(peripheral.getName(basket),1)
                        lava.pullFluid(peripheral.getName(spout))
                        basin.pullFluid(peripheral.getName(spout))


                        spoutDepot.pullItems(peripheral.getName(precisionDrawer),2,1)
                        spout.pullFluid(peripheral.getName(basin),500,"tconstruct:liquid_soul")
                        os.sleep(1)
                        for i =1,4 do
                            spout.pullFluid(peripheral.getName(lava),1000,"minecraft:lava")
                            os.sleep(2)
                        end
                    end
                end
            end
        elseif spoutDepot.list()[1].name == "kubejs:incomplete_infernal_mechanism" then
            basin.pullFluid(peripheral.getName(spout))
            spout.pullFluid(peripheral.getName(lava),1000,"minecraft:lava")
        elseif spoutDepot.list()[1].name == "kubejs:infernal_mechanism" then
            drawer.pullItems(peripheral.getName(spoutDepot),1)
        end
        os.sleep(1)
    end
end


parallel.waitForAll(restocker,infernalMaker)
