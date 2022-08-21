chestWithCoal   = peripheral.wrap("storagedrawers:standard_drawers_4_11")
-- basin           = peripheral.wrap("create:basin_26")
furnace         = peripheral.wrap("minecraft:blast_furnace_3")
cokeDrawer      = peripheral.wrap("storagedrawers:controller_2")

function burnCoke()
    for i,v in pairs(cokeDrawer.list()) do
        if v.name == "thermal:coal_coke" then
            furnace.pullItems(peripheral.getName(cokeDrawer),i,1,2)
        end
    end
end

while true do 
    burnCoke()
    peripheral.wrap("right").pushItems("left",1)
    os.sleep(4)
    peripheral.wrap("left").pushItems("right",1)
    os.sleep(0.1)
end

