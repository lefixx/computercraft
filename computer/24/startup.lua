shell.run("clear")

chute = peripheral.wrap("top")
ext = peripheral.wrap("bottom")
drawer = peripheral.wrap("back")
trader = peripheral.wrap("front")
slots = {1,2,5,6}

shell.run("clearContents")

function emptyExt()
    while true do
        ext.pushItems("back",1)
        os.sleep(1)
    end
end


function emptyTrader()
    while true do
        trader.pushItems("back",2)
        os.sleep(1)
    end
end

function makeTiles()
    while true do
        if ext.list()[1] and ext.list()[1].count >= 16 then
            print"make tiles"
            ext.pushItems("top",1,16)
            turtle.select(1)
            os.sleep(1)
            turtle.transferTo(5,4)
            turtle.transferTo(2,4)
            turtle.transferTo(6,4)
            turtle.craft()
            turtle.transferTo(2,4)
            turtle.transferTo(5,4)
            turtle.transferTo(6,4)
            turtle.craft()
            sellStuff()
        end
    end
end

function sellStuff()
    for i = 1,16 do
        if turtle.getItemDetail(i) then
            print(turtle.getItemDetail(i).name == "architects_palette:basalt_tiles")
            if turtle.getItemDetail(i).name == "architects_palette:basalt_tiles" then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
end



parallel.waitForAll(makeTiles)
