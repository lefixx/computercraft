kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_4") --slot 2
strainer   = peripheral.wrap("waterstrainer:strainer_0")
basin      = peripheral.wrap("create:basin_0")
algalDrawer= peripheral.wrap("storagedrawers:standard_drawers_4_10")
stoneDrawer= peripheral.wrap("storagedrawers:standard_drawers_4_5")
furnace    = peripheral.wrap("minecraft:furnace_1")
washDepot  = peripheral.wrap("create:depot_4")
local lastSlotContainingClay = 0
shell.run("clear")



function restocker()
    while true do
        if washDepot.list()[1] and washDepot.list()[1].name == "minecraft:clay_ball"  then  --pull clay from washer depot
            algalDrawer.pullItems("create:depot_4",1)
        end

        algalDrawer.pullItems(peripheral.getName(furnace),3) -- pull aglal bricks from furnace
        furnace.pullItems(peripheral.getName(algalDrawer),2,64,1)


    os.sleep(1)
    end
end


function claymaker()
    while true do
        for i,v in pairs(strainer.list()) do
            if v.name == "minecraft:clay_ball" then
                algalDrawer.pullItems("waterstrainer:strainer_0",i)
            end

            --pull clay from strainer
            if (not algalDrawer.list()[5] or algalDrawer.list()[4].count<=100) and (not washDepot.list()[1]) then   -- if clay is less that 100 pull sand and wash it
                print("low on clay")
                for i,v in pairs(strainer.list()) do
                    if v.count == 64 then
                        if v.name == "minecraft:sand" or v.name == "biomesoplenty:orange_sand" or v.name == "biomesoplenty:white_sand" then
                            washDepot.pullItems("waterstrainer:strainer_0",i)
                        end
                    end
                end
            end

            os.sleep(1)
        end
    end
end

function craftAlgalMix()
    -- print"Crafting an algal mix"

    -- if ((not algalDrawer.list()[2]) or algalDrawer.list()[2].count <= 100) and (algalDrawer.list()[5]) and algalDrawer.list()[5].count>=1 then
        basin.pullItems("storagedrawers:standard_drawers_4_4",2,1)
        basin.pullItems("storagedrawers:standard_drawers_4_10",5,1)
        -- sleep(4)
        for i,v in pairs(basin.list()) do
            if v.name == "architects_palette:algal_blend" then
                algalDrawer.pullItems(peripheral.getName(basin),i)
            end
        end
    -- else
        -- print"error"
    -- end
end

function craftAndesiteAlloy()
    -- print"Crafting andesite Alloy"
    basin.pullItems(peripheral.getName(stoneDrawer),5,1)
    basin.pullItems("storagedrawers:standard_drawers_4_10",3,1)
    -- sleep(4.5)
    algalDrawer.pullItems("create:basin_0",10)
    for i,v in pairs(basin.list()) do
        if v.name == "crate:andesite_alloy" then
            basin.pushItems(peripheral.getName(algalDrawer),i)
        end
    end
end


function basinManager()
    while true do
        parallel.waitForAll(craftAlgalMix, craftAndesiteAlloy)
        os.sleep(1)
    end
end

function sander()
    while true do
        if not algalDrawer.list()[5] then
            for i,v in pairs(strainer.list()) do
                if v.count == 64 then
                    if v.name == "minecraft:sand" or v.name == "biomesoplenty:orange_sand" or v.name == "biomesoplenty:white_sand" then
                        washDepot.pullItems("waterstrainer:strainer_0",i)
                    end
                end
            end
        end

    os.sleep(10)
    end
end

parallel.waitForAll(restocker,basinManager,claymaker)


























-- if ((not algalDrawer.list()[2]) or algalDrawer.list()[2].count <= 100) and (algalDrawer.list()[5]) and algalDrawer.list()[5].count>=1 then
--
-- elseif (algalDrawer.list()[3]) and algalDrawer.list()[3].count >= 1 and stoneDrawer.list()[4] and stoneDrawer.list()[4].count >=1 then
--     -- if I have algal bricks 3 and andesite Cobblestone
--     local toCraft = 0
--     if algalDrawer.list()[3].count >= stoneDrawer.list()[4].count then
--         toCraft = stoneDrawer.list()[4].count
--     else
--         toCraft = algalDrawer.list()[3].count
--     end
--
--     if toCraft >= 64 then toCraft = 32 end
--     print("crftng", toCraft, "alloy")
--
--     basin.pullItems("storagedrawers:standard_drawers_4_10",3,toCraft)
--     basin.pullItems("storagedrawers:standard_drawers_4_5",5,toCraft)
--
--     local done = false
--     local time = 0
--
--     while done == false do
--         print(toCraft)
--         print(basin.list()[10] == true)
--         if basin.list()[10] and basin.list()[10].count == toCraft*2 or basin.list() == {} then
--             done = true
--         else
--             time = time + 1
--             print(time)
--             os.sleep(1)
--         end
--     end
--
--     print"done, pulling"
--     algalDrawer.pullItems("create:basin_0",10,64,4)
--
-- elseif algalDrawer.list()[2] and algalDrawer.list()[2].count >= 1 and  (not algalDrawer.list()[3] or  algalDrawer.list()[3].count<=100) then -- if mix exists
--     print"crftng brik"
--     furnace.pullItems("storagedrawers:standard_drawers_4_10",2,1,1)
-- end
