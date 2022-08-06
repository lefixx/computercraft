dyeDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_22")
hopper = peripheral.wrap("minecraft:hopper_4")

while true do
    turtle.place()
    if dyeDrawer.list()[2] and dyeDrawer.list()[2].count < 100 then
        hopper.pullItems("storagedrawers:standard_drawers_4_14",2,64)
        os.sleep(30)
    end
    for i = 1,16 do
        if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == "minecraft:cocoa_beans" then
            turtle.select(i)
            turtle.dropUp()
        end
    end
    turtle.select(1)
    turtle.suck()
    -- turtle.suckDown()
end
