function findAndPlaceSapling()
        for i = 16,1,-1 do
            if turtle.getItemDetail(i) ~= nil and (turtle.getItemDetail(i).name == "minecraft:oak_sapling" )  then
                turtle.select(i)
                turtle.place()
            end
        end
end

while true do

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()

    turtle.forward()
    turtle.turnRight()
    findAndPlaceSapling()
    turtle.turnLeft()


    turtle.forward()
    turtle.forward()
    turtle.turnRight()

    os.sleep(60)
end
