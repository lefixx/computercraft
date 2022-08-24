smelteryDrain = peripheral.wrap("tconstruct:drain_0")
while true do os.sleep(0.5)


    local file = fs.open("temp.txt","w")
    file.write(textutils.serialise(smelteryDrain.tanks()))
    file.close()

end