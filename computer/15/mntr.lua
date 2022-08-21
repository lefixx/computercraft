trade = peripheral.wrap("top")
drawer = peripheral.wrap("back")
cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_5")
kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_4")
treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
trade = peripheral.wrap("thermal:machine_press_1")
carpentryTrade = peripheral.wrap("thermal:machine_press_2")
miningTrade = peripheral.wrap("thermal:machine_press_3")
bulkBlastDepot = peripheral.wrap("create:depot_6")
coinDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_2")
dynamo = peripheral.wrap("thermal:dynamo_stirling_2")
furnaceEndineDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_11")

crafter = peripheral.wrap("turtle_0")
modem = peripheral.wrap("back")


while true do
    local kelpInv = kelpDrawer.list()[2].count

    trade.pushItems("storagedrawers:standard_drawers_1_2", 3 ,64)
    carpentryTrade.pushItems("storagedrawers:standard_drawers_1_2", 3 ,64)
    miningTrade.pushItems("storagedrawers:standard_drawers_1_2", 3 ,64)

    shell.run("clear")
    print(kelpDrawer.getItemDetail(2).displayName,kelpDrawer.list()[2].count,"/ 1000")
    print(cobbleDrawer.getItemDetail(5).displayName ,cobbleDrawer.getItemDetail(2).count,"/ 1000") -- gabbro
    print(cobbleDrawer.getItemDetail(2).displayName ,cobbleDrawer.getItemDetail(3).count,"/ 1000") --diortie
    print(cobbleDrawer.getItemDetail(3).displayName ,cobbleDrawer.getItemDetail(4).count,"/ 1000") --granite
    print(cobbleDrawer.getItemDetail(4).displayName ,cobbleDrawer.getItemDetail(5).count,"/ 1000") --andesite
    if treeDrawer.list()[2] then print(treeDrawer.getItemDetail(2).displayName ,treeDrawer.getItemDetail(2).count,"/ 1000") end
    if treeDrawer.list()[3] then print(treeDrawer.getItemDetail(3).displayName ,treeDrawer.getItemDetail(3).count,"/ 1000") end
    print(treeDrawer.getItemDetail(4).displayName ,treeDrawer.getItemDetail(4).count,"/ 1000")
    print(treeDrawer.getItemDetail(5).displayName ,treeDrawer.getItemDetail(5).count,"/ 1000")

    dynamo.pullItems(peripheral.getName(furnaceEndineDrawer),3,64)

    if trade.getEnergy() == 0 then print"tradeNO ENERGY" end
    if trade.list()[3] ~= nil and trade.list()[3].count == 0 then print "FULL COIN" end
    if carpentryTrade.getEnergy() == 0 then print"carpentryTradeNO ENERGY" end
    if carpentryTrade.list()[3] and trade.list()[3].count == 0 then print "FULL COIN" end
    if miningTrade.getEnergy() == 0 then print"miningTradeNO ENERGY" end
    -- if miningTrade.list()[3] and trade.list()[3].count == 0 then print "FULL COIN" end

    if kelpInv >= 1000 then
        trade.pullItems("storagedrawers:standard_drawers_4_4",2,64)
    end

    if treeDrawer.list()[2] and treeDrawer.list()[2].count >= 1000 then
        carpentryTrade.pullItems("storagedrawers:standard_drawers_4_15",2,64)
    end

    if not bulkBlastDepot.list()[1] then --if depot is empty
        -- print"baster is emptu"
        if cobbleDrawer.list()[5].count >= 1000 then
            bulkBlastDepot.pullItems("storagedrawers:standard_drawers_4_5",5,64)
            -- print"blasting gabbro"
        elseif cobbleDrawer.list()[2].count >= 1000 then
            bulkBlastDepot.pullItems("storagedrawers:standard_drawers_4_5",2,64)
            -- print"blasting diorite"
        elseif cobbleDrawer.list()[3].count >= 1000 then
            bulkBlastDepot.pullItems("storagedrawers:standard_drawers_4_5",3,64)
            -- print"blasting granite"
        elseif cobbleDrawer.list()[4].count >= 1000 then
            bulkBlastDepot.pullItems("storagedrawers:standard_drawers_4_5",4,64)
            -- print"blasting andesite"
        end
    end

    if bulkBlastDepot.list()[1] then
        if bulkBlastDepot.list()[1].name == "create:gabbro" or bulkBlastDepot.list()[1].name == "minecraft:diorite"or bulkBlastDepot.list()[1].name == "minecraft:granite" then
            miningTrade.pullItems("create:depot_6",1)
            print"selling blasted products"
        elseif peripheral.wrap("storagedrawers:standard_drawers_1_5").list()[2].count >= 1000 and bulkBlastDepot.list()[1].name == "minecraft:andesite" then
            miningTrade.pullItems("create:depot_6",1)
            print"selling excess andesite"
        elseif bulkBlastDepot.list()[1].name == "minecraft:andesite"
        then bulkBlastDepot.pushItems("storagedrawers:standard_drawers_1_5",1)
        end
    end



    -- displayStuff()
    os.sleep(5)
end
