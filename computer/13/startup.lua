treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_4")
hopper = peripheral.wrap("minecraft:hopper_0")
strainer = peripheral.wrap("waterstrainer:strainer_0")
barrel = peripheral.wrap("minecraft:barrel_1")
mill = peripheral.wrap("create:millstone_1")

if not peripheral.find("modem") then turtle.turnRight() end
local modem = peripheral.find("modem") or error("No modem attached", 0)

modem.open(0)
local stickPos = {2,3,9,10,11,1}
local strawPos = {2,5,6,1}
local ricePos = {2,3,5,6,7,9,10,11,1}


function clearGrid()
    print("clearGrid()")
    turtle.turnLeft()
    for i = 1,16,1 do
        turtle.select(i)
        if turtle.getItemDetail(i) ~= nil and turtle.getItemDetail().name == "minecraft:stick" then
            print"stick"
            turtle.drop()
            treeDrawer.pullItems("minecraft:barrel_1",1,64,4,4)
        end
        turtle.drop()
        print"dropped"
    end
    turtle.turnRight()
end

function craftBagOfRice()
    print"craftBagOfRice()"
    clearGrid()
    turtle.select(1)
    for k,v in pairs(ricePos) do
        print(v)
        hopper.pullItems("create:millstone_1",2,1)
        print("wait")
        os.sleep(1)
        if turtle.getItemCount(1) == 0 then print"error" return end
        print("transfer")
        print(turtle.transferTo(v))
    end
    print("craft")
    turtle.craft()
    turtle.turnLeft()
    turtle.drop()
    turtle.turnRight()

end

function craftSedimentStrainer()
    print"craftSedimentStrainer()"
    clearGrid()
    turtle.select(1)
    for i = 5,7,1 do
        hopper.pullItems("storagedrawers:standard_drawers_4_4",4,1)
        os.sleep(1)
        turtle.transferTo(i)
    end
    for k,v in pairs(stickPos) do
        print(v)
        hopper.pullItems("storagedrawers:standard_drawers_4_15",4,1)
        print("wait")
        os.sleep(2)
        if turtle.getItemCount(1) == 0 then print"error" return end
        print("transfer")
        print(turtle.transferTo(v))
    end
    print("craft")
    turtle.craft()
    turtle.turnLeft()
    turtle.drop()
    turtle.turnRight()
    strainer.pullItems("minecraft:barrel_1",1,1)
end

function craftCanvas()
    print"craftCanvas()"
    clearGrid()
    turtle.select(1)
    for k,v in pairs(strawPos) do
        print(v)
        hopper.pullItems("storagedrawers:standard_drawers_4_4",5,1)
        print("wait")
        os.sleep(1)
        if turtle.getItemCount(1) == 0 then print"error" return end
        print("transfer")
        print(turtle.transferTo(v))
    end
    print("craft")
    turtle.craft()
    turtle.turnLeft()
    turtle.drop()
    turtle.turnRight()
    kelpDrawer.pullItems("minecraft:barrel_1",1,1,1,5)
end

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print(message.message[1])
    print(message.message[2])
    if message.message[1]~= nil then
        if message.message[1] == "craft" then
            print("crafting")
            if message.message[2] == "canvas" then
                craftCanvas()
            elseif message.message[2] == "sedimentStrainer" then
                if kelpDrawer.list()[4].count >= 3 then
                    craftSedimentStrainer()
                else
                    print"not enough canvas"
                end
            elseif message.message[2] == "bag of rice" then
                craftBagOfRice()
            end
        end
    end
end
