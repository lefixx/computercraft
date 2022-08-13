furnace = peripheral.wrap("minecraft:furnace_2")
drawer = peripheral.wrap("storagedrawers:standard_drawers_4_11")
treeFarmDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
-- turtleCoalDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_26")

charcoalSlot = 3
logSlot = 2
topSlot = 1
bottomSlot = 2
outputSlot = 3

while true do
    print(furnace.pullItems(peripheral.getName(treeFarmDrawer),3,64,2)) --
    print(furnace.pullItems(peripheral.getName(drawer),logSlot,1,topSlot)) --put wood in top slot
    print(furnace.pullItems(peripheral.getName(drawer),charcoalSlot,1,topSlot)) --put charcoal in top slot
    print(furnace.pullItems(peripheral.getName(drawer),charcoalSlot,1,bottomSlot)) --put charcoal in bottom slot
    print(drawer.pullItems(peripheral.getName(furnace),outputSlot))
    -- print(drawer.pushItems(peripheral.getName(turtleCoalDrawer),3))
    print(furnace.pullItems(peripheral.getName(treeFarmDrawer),2,64,1)) --
    print(furnace.pullItems(peripheral.getName(drawer),4,64)) --
    -- print(drawer.pushItems(peripheral.getName(furnace),charcoalSlot,1,bottomSlot))
    os.sleep(1)
end
