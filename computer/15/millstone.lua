mill = peripheral.wrap("create:millstone_1")
-- trade = peripheral.wrap("top")
-- drawer = peripheral.wrap("back")
-- cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_1")
kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_4")
-- treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_2")
trade = peripheral.wrap("thermal:machine_press_1")
-- crafter = peripheral.wrap("turtle_0")
modem = peripheral.wrap("bottom")
barrel = peripheral.wrap("minecraft:barrel_1")

function requestCanvas()
    rednet.open("bottom")
    rednet.send(0,{"craft","canvas"})
end

function requestStraw()
    mill.pullItems("storagedrawers:standard_drawers_4_4",3,1)
    os.sleep(1)
    kelpDrawer.pullItems("create:millstone_1",3)
end

function riceInv()
    for k,v in pairs(mill.list()) do
        if v.name == "farmersdelight:rice" then return v.count end
    end
    return 0
end

function sellRice()
    rednet.open("bottom")
    rednet.send(0,{"craft","bag of rice"})
    os.sleep(20)
    trade.pullItems("minecraft:barrel_1",1,1)
end

while true do
    shell.run("clear")
    if kelpDrawer.list()[3] == nil then
        ricePaniclesInv = 0
    else
        ricePaniclesInv = kelpDrawer.list()[3].count
    end

    if kelpDrawer.list()[5] == nil then
        strawInv = 0
    else
        strawInv = kelpDrawer.list()[5].count
    end

    if kelpDrawer.list()[4] == nil then
        canvasInv = 0
    else
        canvasInv = kelpDrawer.list()[4].count
    end

    print("Rice Pan/les:",ricePaniclesInv)
    print("Straw:", strawInv)
    print("canvas:", canvasInv)
    print("rice:",riceInv())


    if canvasInv < 4 and strawInv >= 4 then
        requestCanvas()
        print"Requesting Canvas"
        os.sleep(20)
    end

    if strawInv <= 4 and ricePaniclesInv >=1 then
        print"rqsng Straw"
        requestStraw()
        os.sleep(5)
    end

    if riceInv() >= 9 then
        sellRice()
        os.sleep(20)
    end

    os.sleep(5)
end
