monitor = peripheral.wrap("right")

while true do 
    rednet.open("back")
    local a,b,c = rednet.receive()
    print(b)
    rednet.close("back")
    monitor.clear()
    monitor.setCursorPos(5, 3)
    b = math.floor(b/1000)
    monitor.write("Fuel: "..b.." %")
end
    
print"end"
