while true do os.sleep(2)
    peripheral.wrap("left").pushItems("right",10)
    peripheral.wrap("right").pushItems("left",3)
end
