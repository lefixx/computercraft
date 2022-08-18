shell.run("fg")

chest = peripheral.wrap("Top")
furnace = peripheral.wrap("Bottom")
speaker = peripheral.wrap("right")
burnables = {"Cobblestone",
    "Fir Log",
    "Potato",
    "Raw Cod",
    "Raw Cod Slice",
    "Oak Log",
    "Crushed Copper Ore",
    "Grout",
    "Granite Cobblestone",
    "Andesite Cobblestone",
    "Diorite Cobblestone",
    "Algal Blend",
    "Raw Porkchop",
    "Raw Chicken",
    "Oak Log",
    "Raw Salmon",
    "Raw Salmon Slice",
    "Raw Fish Fillet",
    "Tin Can",
    "Coffee Beans"}



fuels = {"Coal", "Charcoal", "Stick", "Bowl", "Fir Sapling", "Bow", "Crossbow"}

function isFuel(item)
    for i,v in ipairs(fuels) do
        if item == v then return true end
    end
    return false
end

function isFurnacable(item)
    for i,v in ipairs(burnables) do
        if item == v then return true end
    end
    return false
end



while true do
    for i=1,27,1 do
        print(i)
        if chest.getItemDetail(i) ~= nil then
        target = chest.getItemDetail(i).displayName
            if isFurnacable(target) then
                print("found Furnacable")
                speaker.playNote("harp",0.3,i)
                furnace.pullItems("top",i,nil,1)
            elseif isFuel(target) then
                print("Found fuel")
                furnace.pullItems("top",i,nil,2)
                speaker.playNote("basedrum",0.3,i)
            end
        end
    end
    furnace.pushItems("top", 3)
    os.sleep(1)
end
