melter = peripheral.wrap("left")
barrel = peripheral.wrap("Top")
grinder = peripheral.wrap("bottom")
castingTable = peripheral.wrap("right")
meltables = { "Copper Dust", "Nickel Dust", "Lead Dust", "Gold Dust", "Zinc Dust","Silver Coin","Iron Dust"}
crushables = {"Crushed Iron Ore","Crushed Copper Ore","Crushed Nickel Ore","Crushed Lead Ore","Crushed Lead Ore", "Crushed Zinc Ore", "Crushed Gold Ore"}


function isMeltable(item)
    for i,v in pairs(meltables) do
        if item == v then return true end
    end
    return false
end

function isCrushable(item)
    for i,v in pairs(crushables) do
        if item == v then return true end
    end
    return false
end

while true do
    -- from Crusher to barrel

    for i,v in pairs(grinder.list()) do

        target = grinder.getItemDetail(i).displayName

        -- i is key
        -- v is {count, name}
        -- grinder.getItemDetail(i). = {count, displayName, name, tags, maxCount}
        -- target = displayName


        if target ~= nil then
            if isMeltable(target) then
                barrel.pullItems("bottom",i)
            end
        end
    end

    --from barrel to crusher

    for i=1,27,1 do
        if barrel.getItemDetail(i) ~= nil then
            local target = barrel.getItemDetail(i).displayName
            if isCrushable(target) then
                grinder.pullItems("top",i)
            end
        end
    end

    --from barrel to melter

    for i=1,27,1 do
        if barrel.getItemDetail(i) ~= nil then
            local target = barrel.getItemDetail(i).displayName
            local count = barrel.getItemDetail(i).count
            if isMeltable(target) and count >=3 then
                print(" --from barrel to melter found Meltable")
                melter.pullItems("top",i)
            end
        end
    end

    --from melter to casting table

    castingTable.pullFluid("left")

    --from casting table to barrel

    castingTable.pushItems("top",2)

    os.sleep(1)
end
