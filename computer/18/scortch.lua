smeltery = peripheral.wrap("left")
barrel   = peripheral.wrap("top")
cast     = peripheral.wrap("bottom")


while true do
-- if magma exists
    for i,v in pairs(smeltery.tanks()) do
        if v.name == "tconstruct:magma" then
            -- if flint exists
            for k, m in pairs(barrel.list()) do
                if m.name == "minecraft:flint" then
                    -- if cast is empty of cast has flint
                    if not cast.list()[1] or cast.list()[1].name == "minecraft:flint" then
                        -- move a flint to the cast
                        cast.pullItems("top", k,1)
                        print"x"
                        -- pour cream to the cast
                        cast.pullFluid("left")
                        -- wait
                        os.sleep(3)
                    end
                end
            end
        end
    end
    -- pull brick or anything stuck on the casting table
    barrel.pullItems("bottom",2)
end
