
function place()
    while true do
        for i = 1,16 do
            turtle.select(i)
            if turtle.getItemDetail() then 
                if turtle.getItemDetail().name == "minecraft:stick" then
                    turtle.place()
                elseif turtle.getItemDetail().name == "minecraft:torch" then
                    turtle.dropDown()
                end
            end
        end
        os.sleep(1)
    end
end

function suck()

    while true do
        turtle.suck()
    os.sleep (1) end

end


parallel.waitForAll(place, suck)