drawer = peripheral.wrap("bottom")
chute = peripheral.wrap("top")
trader = peripheral.wrap("left")

shell.run("clear")



function calculate(x)
    for i,v in pairs(drawer.list()) do
        if v.name == x then
            return v.count
        end
    end
end

function locate(x)
    for i,v in pairs(drawer.list()) do
        if v.name == x then
            return i
        end
    end
end

while true do
    if calculate("minecraft:melon_slice") > 800 then
        chute.pullItems(peripheral.getName(drawer),locate("minecraft:melon_slice"),27)
        turtle.select(1)
        sleep(1)
        turtle.transferTo(2,3)
        turtle.transferTo(3,3)
        turtle.transferTo(5,3)
        turtle.transferTo(6,3)
        turtle.transferTo(7,3)
        turtle.transferTo(9,3)
        turtle.transferTo(10,3)
        turtle.transferTo(11,3)
        turtle.craft()
        turtle.turnRight()
        turtle.drop()
        turtle.turnLeft()
    end
    os.sleep(2)
    drawer.pullItems(peripheral.getName(trader),2)

end
