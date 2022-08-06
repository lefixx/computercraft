depot = peripheral.wrap("right")
barrel = peripheral.wrap("left")
furnace = peripheral.wrap("top")


while true do
    if depot.getItemDetail(1) and depot.getItemDetail(1).displayName == "Invar Ingot" then
        print"Invar on depot"
        depot.pushItems("left",1)
    end

    for i = 1,27,1 do
        if barrel.getItemDetail(i) and barrel.getItemDetail(i).displayName == "Unprocessed Invar Ingot" then
            barrel.pushItems("right",i)
        end
    end


    if furnace.getItemDetail(3) ~= nil and furnace.getItemDetail(3).displayName=="Unprocessed Invar Ingot" then
        furnace.pushItems("left",3)
    end

    os.sleep(1)
end
