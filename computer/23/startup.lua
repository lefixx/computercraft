furnace = peripheral.wrap("minecraft:furnace_2")
drawer = peripheral.wrap("storagedrawers:standard_drawers_4_11")
treeFarmDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
cokeDrawer = peripheral.wrap("storagedrawers:controller_2")

topSlot = 1
bottomSlot = 2
outputSlot = 3


function haveSamplings()
    if treeFarmDrawer.list()[3] and treeFarmDrawer.list()[3].count > 200 then 
        return true
    end
    return false
end

function burnSampling()
    furnace.pullItems(peripheral.getName(treeFarmDrawer),3,64,bottomSlot)
end

function haveCharcoal()
    if drawer.list()[3] then
        return true
    end
    return false
end

function burnCharcoal()
    furnace.pullItems(peripheral.getName(drawer),3,1)
end

function haveCoke()
    for i,v in pairs(cokeDrawer.list()) do
        if v.name == "thermal:coal_coke" then
            return true
        end
    end
    return false
end

function burnCoke()
    for i,v in pairs(cokeDrawer.list()) do
        if v.name == "thermal:coal_coke" then
            furnace.pullItems(peripheral.getName(cokeDrawer),i,1,bottomSlot)
        end
    end
end

function bottomSlotManager()
    while true do os.sleep(5)
        if haveSamplings() then
            burnSampling()
        elseif haveCoke() then
            burnCoke()
        elseif haveCharcoal() then
            burnCharcoal() 
        end
    end
end

function topSlotManager()
    while true do os.sleep(1)
        if not drawer.list()[topSlot] then
            furnace.pullItems(peripheral.getName(treeFarmDrawer),2,64,topSlot)
        end
    end
end

function outputSlotManager()
    while true do os.sleep(1)
        if furnace.list()[outputSlot] then
            drawer.pullItems(peripheral.getName(furnace),outputSlot)
        end
    end
end
    
    parallel.waitForAll(bottomSlotManager,topSlotManager,outputSlotManager)
    
    
    