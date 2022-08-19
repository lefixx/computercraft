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


function checkFor(thing)
    for i = 1,16 do
        if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == thing then
            return i
        end
    end
end



while true do os.sleep(0.2) 

    
    local coco = checkFor("minecraft:cocoa_beans")
    
    if coco then 
        for hg = 1, turtle.getItemCount(coco) do
            print(hg)
            turtle.select(coco)
            if not turtle.dropUp(1) then return end
            os.sleep(1)
        end
    else
        local bone = checkFor("minecraft:bone_meal")
        
        if bone then 
            turtle.select(bone)
            turtle.place()
            os.sleep(0.5)
            turtle.suck()
        else 
            getBoneMeal()
        end
    end
        

end
    

-- while true do 
--     print("loop")
--     pushUp()
--     getBoneMeal()
--     turtle.place()
--     turtle.suck()

--     os.sleep(0.5)

-- end