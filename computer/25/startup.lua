dyeDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_22")
hopper = peripheral.wrap("minecraft:hopper_4")


function getBoneMeal()
    local found = false
    for i = 1,16 do
        if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == "minecraft:bone_meal" then
            turtle.select(i)
            found = true
        end
    end
    if found == false then 
        hopper.pullItems("storagedrawers:standard_drawers_4_14",2,10)
        os.sleep(1)
        getBoneMeal()
    end
end

function pushUp()
    for i = 1,16 do
        if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == "minecraft:cocoa_beans" then
            turtle.select(i)
            while turtle.getItemCount() ~= 0 do
                turtle.dropUp()
                os.sleep(0.5)
            end
        end
    end
end


while true do 
    print("loop")
    getBoneMeal()
    turtle.place()
    turtle.suck()
    pushUp()

    os.sleep(0.5)

end