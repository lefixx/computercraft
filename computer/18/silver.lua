smeltery = peripheral.wrap("left")
barrel   = peripheral.wrap("top")
cast     = peripheral.wrap("bottom")


while true do
-- if magma exists
    for i,v in pairs(smeltery.tanks()) do
        if v.name == "tconstruct:molten_silver" then
            print"here"
            -- if not cast.list()[1] then
                print(cast.pullFluid("left"))
                -- wait
                os.sleep(3)
            -- end
        end
    end
    -- pull brick or anything stuck on the casting table
    barrel.pullItems("bottom",2)
end
