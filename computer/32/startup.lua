shell.run("clear")

pumkin = "minecraft:pumpkin"
potato = "minecraft:potato"

trader      = peripheral.wrap("front")
drawer      = peripheral.wrap("back")
chute       = peripheral.wrap("top")

tranderName = peripheral.getName(trader)
drawerName  = peripheral.getName(drawer)
chuteName   = peripheral.getName(chute)


function clearTrader()
    trader.pushItems(drawerName,3)
end

function sellPumkins()
    trader.pullItems(drawerName, find(pumkin),9,1)
    os.sleep(1)
    clearTrader()
end

function sellPotatoes()
    print(find(potato))
    print(chute.pullItems(drawerName, find(potato),9))
    os.sleep(1)
    for i = 2,11 do
        if i ~= 4 and i ~= 8 then 
            turtle.transferTo(i,1)
        end
    end
    turtle.craft()
    turtle.drop()
    os.sleep(1)
    clearTrader()
end


function find(name)
    for i,v in pairs(drawer.list()) do
        if v.name == name then return i end
    end
end


function selling()
    while true do 
        if drawer.getItemDetail(find(pumkin)).count > 512 then 
            sellPumkins()
        elseif drawer.getItemDetail(find(potato)).count > 512 then 
            sellPotatoes()
        end
    os.sleep(1) end
end


clearTrader()
selling()