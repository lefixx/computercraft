-- trade = peripheral.wrap("top")
-- drawer = peripheral.wrap("back")
-- cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_1")
-- kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_3")
-- treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_2")
-- trade = peripheral.wrap("thermal:machine_press_0")
-- crafter = peripheral.wrap("turtle_0")
modem = peripheral.wrap("bottom")
strainer = peripheral.wrap("waterstrainer:strainer_0")

function requestSedimentStrainer()
    rednet.open("bottom")
    rednet.send(0,{"craft","sedimentStrainer"})
end

while true do
    shell.run("clear")
    if strainer.getItemDetail(1) == nil then
        print("requesting new sediment strainer")
        requestSedimentStrainer()
        os.sleep(20)
    else print("strainer:",math.floor(strainer.getItemDetail(1).durability*100).."%")
    end
    os.sleep(5)
end
