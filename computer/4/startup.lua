shell.run("clear")

barrel = peripheral.wrap("bottom")
depot  = peripheral.wrap("top")


while true do
    if not depot.list()[1] then
        for i,v in pairs(barrel.list()) do
            if v.name == "kubejs:invar_compound" then
                barrel.pushItems("top",i,1)
            end
        end
    elseif depot.list()[1].name == "thermal:invar_ingot"then
        barrel.pullItems("top",1)
    end
os.sleep(2)
end





























-- shell.run("clear")
-- trade = peripheral.wrap("top")
-- drawer = peripheral.wrap("back")
-- cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_1")
-- kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_3")
-- treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_2")
-- trade = peripheral.wrap("thermal:machine_press_0")
-- crafter = peripheral.wrap("turtle_0")
-- modem = peripheral.wrap("back")
--
-- function requestSedimentStrainer()
--     rednet.open("back")
--     rednet.send(0,{"craft","canvas"})
-- end
--
-- function displayStuff()
--     print(kelpDrawer.getItemDetail(2).displayName,kelpDrawer.list()[2].count)
--     print(cobbleDrawer.getItemDetail(1).displayName ,cobbleDrawer.getItemDetail(2).count)
--     print(cobbleDrawer.getItemDetail(2).displayName ,cobbleDrawer.getItemDetail(2).count)
--     print(cobbleDrawer.getItemDetail(3).displayName ,cobbleDrawer.getItemDetail(3).count)
--     print(cobbleDrawer.getItemDetail(4).displayName ,cobbleDrawer.getItemDetail(4).count)
--     print(treeDrawer.getItemDetail(1).displayName ,treeDrawer.getItemDetail(1).count)
--     print(treeDrawer.getItemDetail(2).displayName ,treeDrawer.getItemDetail(2).count)
--     print(treeDrawer.getItemDetail(3).displayName ,treeDrawer.getItemDetail(3).count)
--     print(treeDrawer.getItemDetail(4).displayName ,treeDrawer.getItemDetail(4).count)
--
-- end
--
-- requestSedimentStrainer()
--
-- while true do
--     shell.run("clear")
--     print(kelpDrawer.getItemDetail(2).displayName,kelpDrawer.list()[2].count,"/ 1000")
--     local kelpInv = kelpDrawer.list()[2].count
--     if kelpInv >= 1000 then
--         print("pushing 64")
--         trade.pullItems("storagedrawers:standard_drawers_4_3",2,64)
--     end
--     print(cobbleDrawer.getItemDetail(5).displayName ,cobbleDrawer.getItemDetail(5).count,"/ 1000")
--     print(cobbleDrawer.getItemDetail(2).displayName ,cobbleDrawer.getItemDetail(2).count,"/ 1000")
--     print(cobbleDrawer.getItemDetail(3).displayName ,cobbleDrawer.getItemDetail(3).count,"/ 1000")
--     print(cobbleDrawer.getItemDetail(4).displayName ,cobbleDrawer.getItemDetail(4).count,"/ 1000")
--     print(treeDrawer.getItemDetail(2).displayName ,treeDrawer.getItemDetail(2).count,"/ 1000")
--     print(treeDrawer.getItemDetail(3).displayName ,treeDrawer.getItemDetail(3).count,"/ 1000")
--     print(treeDrawer.getItemDetail(4).displayName ,treeDrawer.getItemDetail(4).count,"/ 1000")
--     print(treeDrawer.getItemDetail(5).displayName ,treeDrawer.getItemDetail(5).count,"/ 1000")
--
--
--
--     if trade.getEnergy() == 0 then print"NO ENERGY" end
--     if trade.list()[3] ~= nil and trade.list()[3].count == 0 then print "FULL COIN" end
--
--
--     -- displayStuff()
--     os.sleep(5)
-- end
