monitor = peripheral.wrap("right")

while true do 
    rednet.open("back")
    local a,b,c = rednet.receive()
    print(b)
    rednet.close("back")
    monitor.clear()
    monitor.setCursorPos(3, 2)
    c = b[2]
    b = math.floor(b[1]/1000)
    monitor.write("Fuel: "..b.." %")
    monitor.setCursorPos(3, 4)
    monitor.write("Reserve: "..c.." %")
end
    
print"end"
