chestWithCoal   = peripheral.wrap("storagedrawers:standard_drawers_4_11")
-- basin           = peripheral.wrap("create:basin_26")
furnace         = peripheral.wrap("minecraft:blast_furnace_3")

while true do 
    chestWithCoal.pushItems(peripheral.getName(furnace),3,1,2)
    peripheral.wrap("right").pushItems("left",1)
    os.sleep(4)
    peripheral.wrap("left").pushItems("right",1)
    os.sleep(0.1)
end
