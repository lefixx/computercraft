

function placeStuff()
    while true do
        for pb = 1,16 do
            if turtle.getItemDetail(pb) and turtle.getItemDetail(pb).name == "thermal:gunpowder_block" then
                for ed = 1,16 do
                    if turtle.getItemDetail(ed) and turtle.getItemDetail(ed).name == "appliedenergistics2:ender_dust"  then
                        for sin = 1,16 do
                            if turtle.getItemDetail(sin) and turtle.getItemDetail(sin).name == "appliedenergistics2:singularity"  then
                                turtle.select(sin)
                                turtle.drop()
                                turtle.select(ed)inspectDown
                                turtle.drop()
                                turtle.select(pb)
                                turtle.place()

                                local a,b = turtle.inspect()
                                if a == true and b.name == "thermal:gunpowder_block" then
                                    redstone.setOutput("left",true)
                                    os.sleep(0.2)
                                    redstone.setOutput("left",false)
                                    os.sleep(10)
                                end






                            end
                        end
                    end
                end
            end
        end
    os.sleep(1)
    end
end

parallel.waitForAll(placeStuff)
